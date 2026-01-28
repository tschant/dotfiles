local tabs = require("utils.tabs")

return {
	"syntaxpresso/bufstate.nvim",
	dependencies = { "folke/snacks.nvim" },
	lazy = false,
	config = function(_, opts)
		require("bufstate").setup(opts)
		-- Tab autocmds from tabs module
		tabs.setup_autocmds()
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
	keys = vim.list_extend(tabs.keys, {
		-- Session management
		{ "<leader>bs", "<Cmd>BufstateSave<CR>", desc = "Quick save session" },
		{ "<leader>bS", "<Cmd>BufstateSaveAs<CR>", desc = "Save session as" },
		{ "<leader>bl", "<Cmd>BufstateLoad<CR>", desc = "Load session" },
		{ "<leader>bd", "<Cmd>BufstateDelete<CR>", desc = "Delete session" },
		{ "<leader>bn", "<Cmd>BufstateNew<CR>", desc = "New session" },
	}),
}
