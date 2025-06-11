return {
	{
		"anuvyklack/windows.nvim",
		dependencies = {
			"anuvyklack/middleclass",
			"anuvyklack/animation.nvim",
		},
		config = function()
			vim.o.winwidth = 10
			vim.o.winminwidth = 10
			vim.o.equalalways = false
			require("windows").setup()
		end,
		keys = {
			{ "<C-w>z", ":lua require('windows.commands').maximize()<CR>", desc = "maximize windows" },
			{ "<C-w>=", ":lua require('windows.commands').equalize()<CR>", desc = "equalize windows" },
		},
	},

	{
		"mrjones2014/smart-splits.nvim",
		config = true,
		keys = {
			{ "<C-h>", ":lua require('smart-splits').move_cursor_left()<CR>", desc = "Window left" },
			{ "<C-j>", ":lua require('smart-splits').move_cursor_down()<CR>", desc = "Window down" },
			{ "<C-k>", ":lua require('smart-splits').move_cursor_up()<CR>", desc = "Window up" },
			{ "<C-l>", ":lua require('smart-splits').move_cursor_right()<CR>", desc = "Window right" },
			{
				"<leader>w<space>",
				function()
					require("which-key").show({ keys = "<leader>w", loop = true })
				end,
				desc = "Window",
			},
			{ "<leader>wH", ":lua require('smart-splits').resize_left()<CR>", desc = "resize left" },
			{ "<leader>wJ", ":lua require('smart-splits').resize_down()<CR>", desc = "resize down" },
			{ "<leader>wK", ":lua require('smart-splits').resize_up()<CR>", desc = "resize up" },
			{ "<leader>wL", ":lua require('smart-splits').resize_right()<CR>", desc = "resize right" },
		},
	},
	{
		"beauwilliams/focus.nvim",
		keys = {
			{ "<leader>sh", ":lua require'focus'.split_command('h')<CR>", desc = "Focus Left" },
			{ "<leader>sj", ":lua require'focus'.split_command('j')<CR>", desc = "Focus Down" },
			{ "<leader>sk", ":lua require'focus'.split_command('k')<CR>", desc = "Focus Up" },
			{ "<leader>sl", ":lua require'focus'.split_command('l')<CR>", desc = "Focus Right" },
		},
	},
}
