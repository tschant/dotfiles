---Tab management utilities
---@module utils.tabs
local M = {}

---Shorten path for display (e.g., `/Users/foo/bar` → `/U/f/bar`)
---@param path string
---@return string
function M.shorten_path(path)
	local parts = vim.split(path, "/", { plain = true })
	for i = 1, #parts - 1 do
		if parts[i] ~= "" and parts[i] ~= "~" then
			parts[i] = parts[i]:sub(1, 1)
		end
	end
	return table.concat(parts, "/")
end

---Rename tab via LualineRenameTab
---@param label string
function M.rename_tab(label)
	vim.cmd("LualineRenameTab  " .. label)
end

---Rename current tab based on its working directory
---Optionally includes git branch if in a worktree
function M.rename_current_tab()
	local cwd = vim.fn.getcwd(-1, 0)
	local tab_label = M.shorten_path(vim.fn.fnamemodify(cwd, ":~"))

	-- Try to detect git branch for worktree indication
	local branch = vim.fn.system("git -C " .. vim.fn.shellescape(cwd) .. " branch --show-current 2>/dev/null")
	branch = vim.trim(branch)
	if branch ~= "" and branch ~= "main" and branch ~= "master" then
		tab_label = tab_label .. " [" .. branch .. "]"
	end

	M.rename_tab(tab_label)
end

---Rename all tabs based on their working directories
function M.rename_all_tabs()
	local current_tab = vim.api.nvim_get_current_tabpage()
	for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
		vim.api.nvim_set_current_tabpage(tabpage)
		M.rename_current_tab()
	end
	vim.api.nvim_set_current_tabpage(current_tab)
end

---Create new tab with workspace (tcd + session)
function M.new_tab_workspace()
	vim.cmd("tabnew")
	local current_dir = vim.fn.getcwd()
	vim.ui.input({ prompt = "Directory: ", completion = "dir", default = current_dir }, function(dir)
		if not dir then
			vim.cmd("tabclose")
			return
		end
		local expanded = dir ~= "" and vim.fn.expand(dir) or current_dir
		if vim.fn.isdirectory(expanded) ~= 1 then
			vim.notify("Directory does not exist: " .. expanded, vim.log.levels.ERROR)
			vim.cmd("tabclose")
			return
		end
		vim.cmd("tcd " .. vim.fn.fnameescape(expanded))
		M.rename_current_tab()
	end)
end

---Close tab with confirmation
function M.close_tab()
	if #vim.api.nvim_list_tabpages() <= 1 then
		vim.notify("Cannot close the last tab", vim.log.levels.WARN)
		return
	end
	if vim.fn.confirm("Close tab?", "&Yes\n&No", 2) == 1 then
		vim.cmd("tabclose")
	end
end

---Find tab by working directory
---@param path string Absolute path to match
---@return number|nil tabnr Tab number if found, nil otherwise
function M.find_tab_with_cwd(path)
	local normalized = vim.fn.fnamemodify(path, ":p"):gsub("/$", "")
	for tabnr, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
		local tab_cwd = M.get_tab_cwd(tabnr)
		if tab_cwd and vim.fn.fnamemodify(tab_cwd, ":p"):gsub("/$", "") == normalized then
			return tabnr
		end
	end
	return nil
end

---Get working directory for a tab
---@param tabnr number Tab number (1-indexed)
---@return string|nil cwd Working directory or nil if tab doesn't exist
function M.get_tab_cwd(tabnr)
	local tabpages = vim.api.nvim_list_tabpages()
	if tabnr > #tabpages then
		return nil
	end
	local tabpage = tabpages[tabnr]
	local wins = vim.api.nvim_tabpage_list_wins(tabpage)
	if #wins == 0 then
		return nil
	end
	-- Get cwd from first window in tab
	return vim.fn.getcwd(-1, tabnr)
end

---Setup autocommands for tab management
function M.setup_autocmds()
	vim.api.nvim_create_autocmd("SessionLoadPost", {
		callback = M.rename_all_tabs,
		desc = "Rename all lualine tabs after session load",
	})
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = M.rename_current_tab,
		desc = "Rename tab to working directory on startup",
	})
end

---Setup keymaps for tab management
function M.setup_keymaps()
	local opts = { noremap = true, silent = true }
	vim.keymap.set("n", "<leader>tn", M.new_tab_workspace, vim.tbl_extend("force", opts, { desc = "New tab + workspace" }))
	vim.keymap.set("n", "<leader>tc", M.close_tab, vim.tbl_extend("force", opts, { desc = "Close tab" }))
	vim.keymap.set("n", "<leader>t]", "<Cmd>tabnext<CR>", vim.tbl_extend("force", opts, { desc = "Next tab" }))
	vim.keymap.set("n", "<leader>t[", "<Cmd>tabprev<CR>", vim.tbl_extend("force", opts, { desc = "Previous tab" }))
	vim.keymap.set({ "n", "v", "t" }, "<C-PageUp>", "<Cmd>tabnext<CR>", vim.tbl_extend("force", opts, { desc = "Next tab" }))
	vim.keymap.set({ "n", "v", "t" }, "<C-PageDown>", "<Cmd>tabprev<CR>", vim.tbl_extend("force", opts, { desc = "Previous tab" }))
end

---Lazy.nvim compatible keymaps table
M.keys = {
	{ "<leader>tn", function() M.new_tab_workspace() end, desc = "New tab + workspace" },
	{ "<leader>tc", function() M.close_tab() end, desc = "Close tab" },
	{ "<leader>t]", "<Cmd>tabnext<CR>", desc = "Next tab" },
	{ "<leader>t[", "<Cmd>tabprev<CR>", desc = "Previous tab" },
	{ "<C-PageUp>", "<Cmd>tabnext<CR>", mode = { "n", "v", "t" }, desc = "Next tab" },
	{ "<C-PageDown>", "<Cmd>tabprev<CR>", mode = { "n", "v", "t" }, desc = "Previous tab" },
}

return M
