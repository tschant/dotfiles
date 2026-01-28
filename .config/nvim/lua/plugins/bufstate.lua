local function shorten_path(path)
	local parts = vim.split(path, "/", { plain = true })
	for i = 1, #parts - 1 do
		if parts[i] ~= "" and parts[i] ~= "~" then
			parts[i] = parts[i]:sub(1, 1)
		end
	end
	return table.concat(parts, "/")
end

---Rename current tab based on its working directory
local function rename_current_tab()
	local cwd = vim.fn.getcwd(-1, 0)
	local tab_label = shorten_path(vim.fn.fnamemodify(cwd, ":~"))
	vim.cmd("LualineRenameTab  " .. tab_label)
end

---Rename all tabs based on their working directories
local function rename_all_tabs()
	local current_tab = vim.api.nvim_get_current_tabpage()
	for _, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
		vim.api.nvim_set_current_tabpage(tabpage)
		rename_current_tab()
	end
	vim.api.nvim_set_current_tabpage(current_tab)
end

---Create new tab with workspace (tcd + session)
local function new_tab_workspace()
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
		rename_current_tab()
	end)
end

local function close_tab()
	if #vim.api.nvim_list_tabpages() <= 1 then
		vim.notify("Cannot close the last tab", vim.log.levels.WARN)
		return
	end
	if vim.fn.confirm("Close tab?", "&Yes\n&No", 2) == 1 then
		vim.cmd("tabclose")
	end
end

return {
	"syntaxpresso/bufstate.nvim",
	dependencies = { "folke/snacks.nvim" },
	lazy = false,
	config = function(_, opts)
		require("bufstate").setup(opts)
		vim.api.nvim_create_autocmd("SessionLoadPost", {
			callback = rename_all_tabs,
			desc = "Rename all lualine tabs after session load",
		})
		vim.api.nvim_create_autocmd("VimEnter", {
			callback = rename_current_tab,
			desc = "Rename tab to working directory on startup",
		})
	end,
	opts = {
		filter_by_tab = true,
		autoload_last_session = false,
		stop_lsp_on_tab_leave = false,
		autosave = {
			enabled = true,
			on_exit = true,
			interval = 300000, -- 5 minutes
			debounce = 30000, -- 30 seconds
		},
	},
	keys = {
		-- Session management
		{ "<leader>bs", "<Cmd>BufstateSave<CR>", desc = "Quick save session" },
		{ "<leader>bS", "<Cmd>BufstateSaveAs<CR>", desc = "Save session as" },
		{ "<leader>bl", "<Cmd>BufstateLoad<CR>", desc = "Load session" },
		{ "<leader>bd", "<Cmd>BufstateDelete<CR>", desc = "Delete session" },
		{ "<leader>bn", "<Cmd>BufstateNew<CR>", desc = "New session" },

		-- Tab management
		{ "<leader>tn", new_tab_workspace, desc = "New tab + workspace" },
		{ "<leader>tc", close_tab, desc = "Close tab" },
		{ "<leader>t]", "<Cmd>tabnext<CR>", desc = "Next tab" },
		{ "<leader>t[", "<Cmd>tabprev<CR>", desc = "Previous tab" },
		{ "<C-PageUp>", "<Cmd>tabnext<CR>", mode = { "n", "v", "t" }, desc = "Next tab" },
		{ "<C-PageDown>", "<Cmd>tabprev<CR>", mode = { "n", "v", "t" }, desc = "Previous tab" },
	},
}
