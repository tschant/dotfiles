return {
	enabled = false,
	layout = {
		-- preset = "vertical",
		preview = true,
	},
	win = {
		input = {
			keys = {
				["<CR>"] = "confirm",
				["<C-CR>"] = "multi_open", -- custom multi-open
				["<TAB>"] = "toggle",
				["<C-TAB>"] = { "toggle", "down" },
				["<S-TAB>"] = { "toggle", "up" },
				["<C-j>"] = "down",
				["<C-k>"] = "up",
				["<C-v>"] = { "multi_open", "vsplit" },
				["<C-h>"] = { "multi_open", "split" },
				["<C-t>"] = { "multi_open", "tab" },
				["<esc>"] = "close",
				["<C-e>"] = "preview_down",
				["<C-u>"] = "preview_up",
				["<C-d>"] = "delete",
			},
		},
	},
}
