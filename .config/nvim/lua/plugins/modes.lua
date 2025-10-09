local colors = require("utils.colors")
return {
	"mvllow/modes.nvim",
	event = "VeryLazy",
	enabled = false,
	config = function()
		require("modes").setup({
			colors = {
				bg = "",
				copy = colors.cyan,
				delete = colors.red,
				change = colors.red,
				format = colors.gray,
				insert = colors.hint,
				replace = colors.blue,
				select = colors.yellow,
				visual = colors.yellow,
			},
			line_opacity = 0.15,
			set_cursor = true,
			set_cursorline = true,
			set_number = true,
			set_signcolumn = true,
			ignore = { "NvimTree", "TelescopePrompt" },
		})
	end,
}
