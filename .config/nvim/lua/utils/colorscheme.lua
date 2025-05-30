local cmd = vim.cmd
local utils = {}

function utils.setColorScheme(Theme)
	cmd("colorscheme " .. Theme)

	-- Use terminal background color instead of colorscheme
	vim.api.nvim_set_hl(0, "Normal", { ctermbg = "none", bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { ctermbg = "none", bg = "#262626" })
	vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "none", bg = "none" })
	vim.api.nvim_set_hl(0, "FoldColumn", { ctermbg = "none", bg = "none" })
	vim.api.nvim_set_hl(0, "FocusedLine", { ctermbg = "none", bg = "none", fg = "#0088aa" })
	vim.api.nvim_set_hl(0, "LineNR", { ctermbg = "none", bg = "none" })
	vim.api.nvim_set_hl(0, "Whitespace", { fg = "#323232" })

	vim.api.nvim_set_hl(0, "NeominimapSearchLine", { link = "IncSearch" })
	vim.api.nvim_set_hl(0, "NeominimapSearchSign", { link = "IncSearch" })

	-- highlights --
	vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "#525252", bg = "NONE" })

	-- -- git signs
	-- local colors = require("utils.colors")
	-- vim.api.nvim_set_hl(0, "DiffAdd", { fg = colors.green, bg = "none" })
	-- vim.api.nvim_set_hl(0, "DiffChange", { fg = colors.blue, bg = "none" })
	-- vim.api.nvim_set_hl(0, "DiffModified", { fg = colors.orange, bg = "none" })
	-- vim.api.nvim_set_hl(0, "DiffDeleted", { fg = colors.red, bg = "none" })
	-- vim.api.nvim_set_hl(0, "DiagnosticError", { fg = colors.error, bg = "none" })
	-- vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = colors.warning, bg = "none" })
	-- vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = colors.info, bg = "none" })
	-- vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = colors.hint, bg = "none" })

	vim.api.nvim_set_hl(0, "NotifyBackground", { fg = "none", bg = "#000000" })
end

return utils
