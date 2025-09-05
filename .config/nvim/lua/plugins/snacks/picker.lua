return {
	enabled = true,
	layout = {
		-- preset = "vertical",
		preview = true,
	},
	matcher = { frecency = true },
	win = {
		input = {
			keys = {
				["<CR>"] = { "confirm", mode = { "n", "x", "i" } },
				["<S-Tab>"] = { "select_and_prev", mode = { "n", "x", "i" } },
				["<Tab>"] = { "select_and_next", mode = { "n", "x", "i" } },
				["<C-j>"] = "down",
				["<C-k>"] = "up",
				["<esc>"] = "close",
				["<C-e>"] = "preview_down",
				["<C-u>"] = "preview_up",
				["<C-d>"] = "delete",
			},
		},
	},
}
