return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Enabled plugins
		bufdelete = { enabled = true },
		bigfile = require("plugins.snacks.bigfile"),
		dashboard = require("plugins.snacks.dashboard"),
		indent = require("plugins.snacks.indent"),
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = false },
		win = {
			enabled = true,
			backdrop = {
				bg = "#e5e9f0", -- backdrop background color
				blend = 70, -- backdrop transparency (0-100)
			},
		},
		words = { enabled = true },
		-- disabled
		explorer = { enabled = false }, -- neo-tree
		picker = { enabled = false }, -- telescope
		input = { enabled = false },
		notifier = { enabled = false },
		statuscolumn = { enabled = false },
		terminal = { enabled = false },
	},
}
