return {
	{
		"MagicDuck/grug-far.nvim",
		-- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
		-- additional lazy config to defer loading is not really needed...
		opts = {
			showCompactInputs = true,
			showInputsTopPadding = true,
			showInputsBottomPadding = true,
		},
		config = true,
		keys = {
			{
				"<leader>/r",
				"<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>",
				desc = "Search/Replace",
				mode = {"n"},
			},
			{
				"<leader>/r",
				"<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>'),  paths = vim.fn.expand('%') }  })<cr>",
				desc = "Search/Replace",
				mode = {"x"},
			},
		},
	},
	{
		"hamidi-dev/kaleidosearch.nvim",
		dependencies = {
			"tpope/vim-repeat",
			"stevearc/dressing.nvim",
		},
		opts = {
			keymaps = {
				enabled = false,
			},
		},
		config = true,
		enabled = false,
		keys = {
			{
				"<leader>//",
				function()
					require("kaleidosearch").prompt_and_search()
				end,
				desc = "Search word",
				mode = "n",
			},
			{
				"<leader>/n",
				function()
					require("kaleidosearch").prompt_and_search()
				end,
				desc = "Search word",
				mode = "n",
			},
			{
				"<leader>/*",
				function()
					require("kaleidosearch").toggle_word_or_selection()
				end,
				desc = "Search word under cursor",
				mode = { "x", "n" },
			},
			{
				"<leader>/c",
				function()
					require("kaleidosearch").clear_all_highlights()
					-- vim.api.nvim_command("set hlsearch")
					-- vim.api.nvim_command("nohl")
				end,
				desc = "Clear search",
				mode = "n",
			},
		},
	},
	{
		"nvim-pack/nvim-spectre",
		enabled = false,
		keys = {
			{ "<leader>sp", ":lua require('spectre').open()<cr>", desc = "Spectre open" },
			{ "<leader>sw", ":lua require('spectre').open_visual()<cr>", desc = "Spectre open visual" },
		},
	},
}
