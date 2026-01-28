---Core git worktree operations
---@module utils.git-worktree
local M = {}

---Get the git repository root directory
---@param path? string Optional path to check (defaults to cwd)
---@return string|nil root Git root path or nil if not in a repo
function M.get_git_root(path)
	path = path or vim.fn.getcwd()
	local result = vim.fn.system("git -C " .. vim.fn.shellescape(path) .. " rev-parse --show-toplevel 2>/dev/null")
	if vim.v.shell_error ~= 0 then
		return nil
	end
	return vim.trim(result)
end

---Get the main worktree (bare repo) directory
---@param path? string Optional path to check
---@return string|nil root Main worktree/bare repo path
function M.get_main_worktree_root(path)
	path = path or vim.fn.getcwd()
	local result = vim.fn.system("git -C " .. vim.fn.shellescape(path) .. " rev-parse --git-common-dir 2>/dev/null")
	if vim.v.shell_error ~= 0 then
		return nil
	end
	local common_dir = vim.trim(result)
	-- For bare repos, this returns the .git directory; for worktrees, it returns the common .git
	if common_dir:match("%.git$") then
		return vim.fn.fnamemodify(common_dir, ":h")
	end
	return common_dir
end

---Normalize worktree/branch name (lowercase, hyphens, no special chars)
---@param name string Raw name
---@return string normalized Sanitized name
function M.normalize_worktree_name(name)
	local normalized = name:lower()
	normalized = normalized:gsub("[%s_]+", "-") -- spaces/underscores to hyphens
	normalized = normalized:gsub("[^%w%-]", "") -- remove special chars
	normalized = normalized:gsub("%-+", "-")    -- collapse multiple hyphens
	normalized = normalized:gsub("^%-", ""):gsub("%-$", "") -- trim hyphens
	return normalized
end

---@class WorktreeInfo
---@field path string Absolute path to worktree
---@field branch string|nil Branch name (nil for detached HEAD)
---@field commit string Short commit hash
---@field is_main boolean Whether this is the main worktree

---List all worktrees in the repository
---@param path? string Optional path to check
---@return WorktreeInfo[] worktrees List of worktree info
function M.get_all_worktrees(path)
	path = path or vim.fn.getcwd()
	local result = vim.fn.system("git -C " .. vim.fn.shellescape(path) .. " worktree list --porcelain 2>/dev/null")
	if vim.v.shell_error ~= 0 then
		return {}
	end

	local worktrees = {}
	local current = {}

	for line in result:gmatch("[^\n]+") do
		if line:match("^worktree ") then
			if current.path then
				table.insert(worktrees, current)
			end
			current = { path = line:match("^worktree (.+)") }
		elseif line:match("^HEAD ") then
			current.commit = line:match("^HEAD (%w+)"):sub(1, 7)
		elseif line:match("^branch ") then
			local branch = line:match("^branch refs/heads/(.+)")
			current.branch = branch
		elseif line:match("^bare") then
			current.is_bare = true
		elseif line:match("^detached") then
			current.branch = nil
		end
	end

	if current.path then
		table.insert(worktrees, current)
	end

	-- Mark the first worktree as main (or the bare repo)
	if #worktrees > 0 then
		worktrees[1].is_main = true
	end

	return worktrees
end

---Find worktree by branch name
---@param branch string Branch name to find
---@param path? string Optional path to check
---@return WorktreeInfo|nil worktree Worktree info or nil if not found
function M.find_worktree_for_branch(branch, path)
	local worktrees = M.get_all_worktrees(path)
	for _, wt in ipairs(worktrees) do
		if wt.branch == branch then
			return wt
		end
	end
	return nil
end

---@class CreateWorktreeOpts
---@field base_branch? string Branch to base new worktree on (default: current branch)
---@field create_branch? boolean Whether to create a new branch (default: true)

---Create a new worktree
---@param worktree_path string Path for the new worktree
---@param branch string Branch name
---@param opts? CreateWorktreeOpts Options
---@return boolean success Whether creation succeeded
---@return string? error Error message if failed
function M.create_worktree(worktree_path, branch, opts)
	opts = opts or {}
	local cwd = vim.fn.getcwd()
	local git_root = M.get_git_root(cwd)

	if not git_root then
		return false, "Not in a git repository"
	end

	-- Check if branch already exists
	local branch_exists = vim.fn.system("git -C " .. vim.fn.shellescape(cwd) .. " show-ref --verify --quiet refs/heads/" .. branch)
	local branch_exists_bool = vim.v.shell_error == 0

	local cmd
	if branch_exists_bool then
		-- Use existing branch
		cmd = string.format(
			"git -C %s worktree add %s %s 2>&1",
			vim.fn.shellescape(cwd),
			vim.fn.shellescape(worktree_path),
			vim.fn.shellescape(branch)
		)
	else
		-- Create new branch
		local base = opts.base_branch or "HEAD"
		cmd = string.format(
			"git -C %s worktree add -b %s %s %s 2>&1",
			vim.fn.shellescape(cwd),
			vim.fn.shellescape(branch),
			vim.fn.shellescape(worktree_path),
			vim.fn.shellescape(base)
		)
	end

	local result = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		return false, vim.trim(result)
	end

	return true, nil
end

---Remove a worktree
---@param worktree_path string Path to the worktree
---@param force? boolean Force removal even with changes
---@return boolean success Whether removal succeeded
---@return string? error Error message if failed
function M.remove_worktree(worktree_path, force)
	local cmd = string.format(
		"git worktree remove %s %s 2>&1",
		force and "--force" or "",
		vim.fn.shellescape(worktree_path)
	)

	local result = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		return false, vim.trim(result)
	end

	return true, nil
end

---Check if worktree has uncommitted changes
---@param worktree_path string Path to the worktree
---@return boolean has_changes Whether there are uncommitted changes
function M.worktree_has_changes(worktree_path)
	local result = vim.fn.system("git -C " .. vim.fn.shellescape(worktree_path) .. " status --porcelain 2>/dev/null")
	return vim.trim(result) ~= ""
end

---Get worktree info for current working directory
---@return WorktreeInfo|nil worktree Current worktree info or nil
function M.get_current_worktree()
	local cwd = vim.fn.getcwd()
	local worktrees = M.get_all_worktrees(cwd)

	for _, wt in ipairs(worktrees) do
		-- Check if cwd is within this worktree
		if cwd:find(wt.path, 1, true) == 1 then
			return wt
		end
	end

	return nil
end

---Delete a branch (local only)
---@param branch string Branch name to delete
---@param force? boolean Force delete even if not merged
---@return boolean success
---@return string? error
function M.delete_branch(branch, force)
	local flag = force and "-D" or "-d"
	local cmd = string.format("git branch %s %s 2>&1", flag, vim.fn.shellescape(branch))
	local result = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		return false, vim.trim(result)
	end
	return true, nil
end

return M
