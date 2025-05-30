local colors = require "utils.colors"
vim.api.nvim_set_hl(0, "SnacksIndent0", { fg = "#222222" })
vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = "#323232" })
vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = "#424242" })
vim.api.nvim_set_hl(0, "SnacksIndent3", { fg = "#525252" })
vim.api.nvim_set_hl(0, "SnacksIndent4", { fg = "#626262" })
vim.api.nvim_set_hl(0, "SnacksIndent5", { fg = "#727272" })
vim.api.nvim_set_hl(0, "SnacksIndent6", { fg = "#828282" })
vim.api.nvim_set_hl(0, "SnacksIndent7", { fg = "#929292" })
vim.api.nvim_set_hl(0, "SnacksIndent8", { fg = "#a2a2a2" })
vim.api.nvim_set_hl(0, "SnacksIndent9", { fg = "#b2b2b2" })
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = colors.lightgrey })

vim.opt.list = true
vim.opt.listchars = {
	space = "⋅",
	lead = "·",
	trail = "•",
	-- multispace = "∅",
	nbsp = "‡",
	tab = " »",
	precedes = "❮",
	extends = "❯",
	-- eol = "↵",
	-- eol = "↴",
}

return {
	enabled = true,
	indent = {
		priority = 1,
		enabled = true,
		char = "│",
		only_scope = true,
		only_current = false,
		hl = {
			"SnacksIndent0",
			"SnacksIndent1",
			"SnacksIndent2",
			"SnacksIndent3",
			"SnacksIndent4",
			"SnacksIndent5",
			"SnacksIndent6",
			"SnacksIndent7",
			"SnacksIndent8",
			"SnacksIndent9",
		},
	},
	animate = { enabled = false },
	scope = {
		enabled = true,
		priority = 200,
		char = "│",
		underline = false,
		only_current = false,
		hl = "SnacksIndentScope",
	},
	chunk = {
		enabled = true,
		-- only show chunk scopes in the current window
		only_current = true,
		priority = 200,
		hl = "SnacksIndentChunk",
		char = {
			horizontal = "─",
			vertical = "│",
			corner_top = "╭",
			corner_bottom = "╰",
			arrow = "┤",
		},
	},
	-- filter for buffers to enable indent guides
	filter = function(buf)
		return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
	end,
}
