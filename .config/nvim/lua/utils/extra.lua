local utils = {}
local G = {}
local Git = {}
local api, fn, ft = vim.api, vim.fn, vim.bo.filetype

-- Local
--- Check if a file or directory exists in this path
function G.exists(file)
	if file == "" or file == nil then
		return false
	end
	local ok, err, code = os.rename(file, file)
	if not ok then
		if code == 13 then
			-- Permission denied, but it exists
			return true
		end
	end
	return ok, err
end

function utils.isdir(path)
	if path == "" or path == nil then
		return false
	end
	-- "/" works on both Unix and Windows
	return G.exists(path .. "/")
end

-- Git
function Git.get_root_dir(path)
	-- return parent path for specified entry (either file or directory)
	local function pathname(path)
		local prefix = ""
		local i = path:find("[\\/:][^\\/:]*$")
		if i then
			prefix = path:sub(1, i - 1)
		end

		return prefix
	end

	-- Checks if provided directory contains git directory
	local function has_git_dir(dir)
		local git_dir = dir .. "/.git"
		if utils.isdir(git_dir) then
			return git_dir
		end
	end

	local function has_git_file(dir)
		local gitfile = io.open(dir .. "/.git")
		if not gitfile then
			return false
		end

		local git_dir = gitfile:read():match("gitdir: (.*)")
		gitfile:close()

		return git_dir and dir .. "/" .. git_dir
	end

	-- Set default path to current directory
	if not path or path == "." then
		path = io.popen("cd"):read("*l")
	end

	-- Calculate parent path now otherwise we won't be
	-- able to do that inside of logical operator
	local parent_path = pathname(path)

	return has_git_dir(path)
		or has_git_file(path) -- Otherwise go up one level and make a recursive call
		or (parent_path ~= path and Git.get_root_dir(parent_path) or nil)
end

function utils.get_branch()
	if ft == "help" then
		return
	end
	local current_file = fn.expand("%:p")
	local current_dir

	-- if file is a symlinks
	if fn.getftype(current_file) == "link" then
		local real_file = fn.resolve(current_file)
		current_dir = fn.fnamemodify(real_file, ":h")
	else
		current_dir = fn.expand("%:p:h")
	end

	local _, gitbranch_pwd = pcall(api.nvim_buf_get_var, 0, "gitbranch_pwd")
	local _, gitbranch_path = pcall(api.nvim_buf_get_var, 0, "gitbranch_path")
	if gitbranch_path and gitbranch_pwd then
		if gitbranch_path:find(current_dir) and string.len(gitbranch_pwd) ~= 0 then
			return gitbranch_pwd
		end
	end
	local git_dir = Git.get_root_dir(current_dir)
	if not git_dir then
		return
	end
	local git_root
	if not git_dir:find("/.git") then
		git_root = git_dir
	end
	git_root = git_dir:gsub("/.git", "")

	-- If git directory not found then we're probably outside of repo
	-- or something went wrong. The same is when head_file is nil
	local head_file = git_dir and io.open(git_dir .. "/HEAD")
	if not head_file then
		return
	end

	local HEAD = head_file:read()
	head_file:close()

	-- if HEAD matches branch expression, then we're on named branch
	-- otherwise it is a detached commit
	local branch_name = HEAD:match("ref: refs/heads/(.+)")
	if branch_name == nil then
		for line in io.popen("git branch 2>nul"):lines() do
			local branch_name_match = line:match("%* (.+)$")
			if branch_name_match then
				return branch_name_match
			end
		end

		return
	end

	api.nvim_buf_set_var(0, "gitbranch_pwd", branch_name)
	api.nvim_buf_set_var(0, "gitbranch_path", git_root)

	return branch_name .. " "
end

function utils.check_workspace()
	local current_file = fn.expand("%:p")
	if current_file == "" or current_file == nil then
		return false
	end
	local current_dir
	-- if file is a symlinks
	if fn.getftype(current_file) == "link" then
		local real_file = fn.resolve(current_file)
		current_dir = fn.fnamemodify(real_file, ":h")
	else
		current_dir = fn.expand("%:p:h")
	end
	local result = Git.get_root_dir(current_dir)
	if not result then
		return false
	end
	return true
end

function utils.get_name_from_group(bufnum, lnum, group)
	local cur_sign = vim.fn.sign_getplaced(bufnum, {
		group = group,
		lnum = lnum,
	})

	if cur_sign == nil then
		return nil
	end

	cur_sign = cur_sign[1]

	if cur_sign == nil then
		return nil
	end

	cur_sign = cur_sign.signs

	if cur_sign == nil then
		return nil
	end

	cur_sign = cur_sign[1]

	if cur_sign == nil then
		return nil
	end

	return cur_sign["name"]
end

function utils.make_hl_statuscolum(group, sym)
	return table.concat({ "%#", group, "#", sym, "%*" })
end

function utils.get_win_count()
	local wc = 0
	local windows = vim.api.nvim_tabpage_list_wins(0)

	for _, v in pairs(windows) do
		local cfg = vim.api.nvim_win_get_config(v)
		local filetype = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(v), "filetype")
		if
			(cfg.relative == "" or cfg.external == false)
			and filetype ~= "qf"
			and filetype ~= "neominimap"
			and filetype ~= "noice"
			and filetype ~= "notify"
			and filetype ~= "neo-tree"
			-- Any others to ignore?
		then
			wc = wc + 1
		end
	end

	return wc
end

function utils.close_win_or_buffer(force)
	local win_amount = utils.get_win_count()
	local bd = require("bufdel")
	if win_amount == 1 then
		bd.delete_buffer_expr(nil, force)
	else
		-- bd.delete_buffer_expr()
		-- this does not close the buffer directly, uncomment above to close file as well
		vim.api.nvim_win_close(0, force)
	end
end

function utils.dump_table(table)
	if type(table) == "table" then
		local s = "{ "
		for k, v in pairs(table) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. utils.dump_table(v) .. ","
		end
		return s .. "} "
	else
		return tostring(table)
	end
end

return utils
