return {
	"folke/noice.nvim",
	dependencies = {
		{ "MunifTanjim/nui.nvim", branch = "main" },
		"rcarriga/nvim-notify",
	},
	config = function()
		require("notify").setup({
			background_color = "#000000",
		})
		require("noice").setup({
			renader = "minimal",
			stages = "static",
			views = {
				mini = {
					align = "line-left",
					reverse = false,
					position = {
						row = -1,
						col = 0,
					},
					timeout = 10000,
				},
			},
			cmdline = {
				view = "cmdline",
			},
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				message = { enabled = false },
				progress = { enabled = false },
			},
			health = { checker = false },
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = false, -- position the cmdline and popupmenu together
				long_message_to_split = false, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = true, -- add a border to hover docs and signature help
			},
			notify = {
				enabled = true,
				view = "notify",
			},
			messages = {
				view = "mini",
			},
		})
	end,
	event = "VeryLazy",
	keys = {
		{ "<leader>nd", ":lua require('noice').cmd('dismiss')<cr>", desc = "Dismiss notifications" },
		{ "<leader>nh", ":lua require('noice').cmd('telescope')<cr>", desc = "History notifications" },
		{ "<leader>nl", ":lua require('noice').cmd('last')<cr>", desc = "Last notifications" },
	},
}
