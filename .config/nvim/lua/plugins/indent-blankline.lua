local M = {
	"lukas-reineke/indent-blankline.nvim",
	event = "BufAdd",
	main = "ibl",
	config =  function()
		local highlight = {
			"RainbowRed",
			"RainbowYellow",
			"RainbowBlue",
			"RainbowOrange",
			"RainbowGreen",
			"RainbowViolet",
			-- "RainbowCyan",
		}

		local hooks = require "ibl.hooks"
		-- create the highlight groups in the highlight setup hook, so they are reset
		-- every time the colorscheme changes
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "RainbowRed", { fg =    "#381111" })
			vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#613e1a" })
			vim.api.nvim_set_hl(0, "RainbowBlue", { fg =   "#636218" })
			vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#2a3834" })
			vim.api.nvim_set_hl(0, "RainbowGreen", { fg =  "#184b63" })
			vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#492a63" })
			-- vim.api.nvim_set_hl(0, "RainbowCyan", { fg =   "" })
		end)

		vim.opt.list = true
		vim.opt.listchars:append "space:⋅"
		vim.opt.listchars:append "tab:» "
		-- vim.opt.listchars:append "eol:↴"

		require('ibl').setup {
			scope = {show_start = true, enabled = true, highlight = highlight},
			indent = { highlight = highlight, --[[ char = "⋅", tab_char = "»", ]] },
			exclude = {
				filetypes = {"help", "dashboard", "startify", "NvimTree", "vista", "sagahover"},
			},
		}
	end
}

local N = {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },

	config = function ()
		require("hlchunk").setup({
			exclude_filetypes = {
				help = true,
			},

			chunk = {
				enable = true,
				style = {
					{ fg = "#89B5FA" },
					{ fg = "#F38BA8" }
				},
				chars = {
					horizontal_line = "─",
					vertical_line = "│",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = "┤",
				},

				duration = 200,
				delay = 0,
			},

			blank = { enabled = false, },
			indent = {
				enable = false,
				style = {
					{ fg = "#585a6f" },
					{ fg = "#4e5064" },
					{ fg = "#444659" },
					{ fg = "#3a3c4e" },
					{ fg = "#313244" },
				},
			},
			line_num = { enable = false }
		});
	end
}

return {M, N}
