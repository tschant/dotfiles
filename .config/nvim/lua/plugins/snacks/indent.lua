vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#381111" })
vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#613e1a" })
vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#636218" })
vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#2a3834" })
vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#184b63" })
vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#492a63" })
-- vim.api.nvim_set_hl(0, "RainbowCyan", { fg =   "" })

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
		enabled = true, -- enable indent guides
		char = "│",
		only_scope = false, -- only show indent guides of the scope
		only_current = false, -- only show indent guides in the current window
		hl = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			-- "RainbowCyan",
		},
	},
	animate = { enabled = false },
	---@class snacks.indent.Scope.Config: snacks.scope.Config
	scope = {
		enabled = true, -- enable highlighting the current scope
		priority = 200,
		char = "│",
		underline = false, -- underline the start of the scope
		only_current = false, -- only show scope in the current window
		hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
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

			-- corner_top = "┌",
			-- corner_bottom = "└",
			-- -- corner_top = "╭",
			-- -- corner_bottom = "╰",
			-- horizontal = "─",
			-- vertical = "│",
			-- arrow = ">",
		},
	},
	-- filter for buffers to enable indent guides
	filter = function(buf)
		return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
	end,
}
