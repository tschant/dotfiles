local colors = require("utils.colors")
local icons = require("utils.icons")

local mode_colors = {
	["n"] = { "NORMAL", colors.red },
	["no"] = { "N-PENDING", colors.red },
	["i"] = { "INSERT", colors.purple },
	["ic"] = { "INSERT", colors.purple },
	["t"] = { "TERMINAL", colors.green },
	["v"] = { "VISUAL", colors.cyan },
	["V"] = { "V-LINE", colors.cyan },
	[""] = { "V-BLOCK", colors.cyan },
	["v-m"] = { "V-MULTI", colors.cyan },
	["R"] = { "REPLACE", colors.orange },
	["Rv"] = { "V-REPLACE", colors.orange },
	["s"] = { "SELECT", colors.blue },
	["S"] = { "S-LINE", colors.blue },
	[""] = { "S-BLOCK", colors.blue },
	["c"] = { "COMMAND", colors.magenta },
	["cv"] = { "COMMAND", colors.magenta },
	["ce"] = { "COMMAND", colors.magenta },
	["r"] = { "PROMPT", colors.lightblue },
	["rm"] = { "MORE", colors.lightblue },
	["r?"] = { "CONFIRM", colors.lightblue },
	["!"] = { "SHELL", colors.green },
}

local M = {
	"nvim-lualine/lualine.nvim",
	requires = { "nvim-tree/nvim-web-devicons", opt = true },
	event = "BufReadPre",
}

M.config = function()
	require("lualine").setup({
		options = {
			theme = "auto",
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{
					"mode",
					separator = { right = "" },
					color = function()
						return { fg = colors.bg, bg = mode_colors[vim.fn.mode()][2] }
					end,
				},
			},
			lualine_b = {
				{
					function()
						return "" .. icons.file .. " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. " "
					end,
					color = { bg = colors.lualine_b1 },
					separator = { right = "" },
				},
				{
					"filetype",
					colored = false,
					icon_only = true,
					icon = { align = "right" },
					padding = { left = 1, right = 0 },
				},
				{
					"filename",
					file_status = true,
					padding = { left = 0, right = 1 },
					symbols = {
						modified = icons.unsaved,
						readonly = icons.readonly,
						unnamed = "[No Name]",
						newfile = "[New]",
					},
				},
			},
			lualine_c = {
				{
					"diff",
					symbols = {
						added = icons.git_add .. " ",
						modified = icons.git_change .. " ",
						removed = icons.git_delete .. " ",
					},
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = {
						error = icons.error .. " ",
						warn = icons.warn .. " ",
						hint = icons.hint .. " ",
						info = icons.info .. " ",
					},
				},
			},
			--[[ lualine_x = {
				{
					"lsp_status",
					icon = "",
					ignore_lsp = { "null-ls" },
					color = { fg = colors.green },
				},
			}, ]]
			lualine_x = {
				function()
					if next(vim.lsp.get_clients()) ~= nil then
						return "  LSP - " .. vim.bo.filetype
					end
					return ""
				end,
			},
			lualine_y = {
				{
					"branch",
					icon = icons.branch,
				},
			},
			lualine_z = {
				{
					"location",
					icon = "",
					color = { fg = colors.bg, bg = colors.lightblue },
				},
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	})
end
return M
