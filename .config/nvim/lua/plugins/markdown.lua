local colors = require("utils.colors")

return {
	"MeanderingProgrammer/markdown.nvim",
	name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	ft = "markdown",
	enabled = true,
	opts = {
		bullet = {
			-- Turn on / off list bullet rendering
			enabled = true,
		},
		checkbox = {
			-- Turn on / off checkbox state rendering
			enabled = true,
			-- Determines how icons fill the available space:
			--  inline:  underlying text is concealed resulting in a left aligned icon
			--  overlay: result is left padded with spaces to hide any additional text
			position = "inline",
			unchecked = {
				-- Replaces '[ ]' of 'task_list_marker_unchecked'
				icon = "   󰄱 ",
				-- Highlight for the unchecked icon
				highlight = "RenderMarkdownUnchecked",
				-- Highlight for item associated with unchecked checkbox
				scope_highlight = nil,
			},
			checked = {
				-- Replaces '[x]' of 'task_list_marker_checked'
				icon = "   󰱒 ",
				-- Highlight for the checked icon
				highlight = "RenderMarkdownChecked",
				-- Highlight for item associated with checked checkbox
				scope_highlight = nil,
			},
		},
		html = {
			-- Turn on / off all HTML rendering
			enabled = true,
			comment = {
				-- Turn on / off HTML comment concealing
				conceal = false,
			},
		},
		-- Add custom icons lamw26wmal
		link = {
			render_modes = true,
			image = vim.g.neovim_mode == "skitty" and "" or "󰥶 ",
			custom = {
				youtu = { pattern = "youtu%.be", icon = "󰗃 " },
			},
		},
		heading = {
			sign = false,
			icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
			backgrounds = {
				"Headline1Bg",
				"Headline2Bg",
				"Headline3Bg",
				"Headline4Bg",
				"Headline5Bg",
				"Headline6Bg",
			},
			foregrounds = {
				"Headline1Fg",
				"Headline2Fg",
				"Headline3Fg",
				"Headline4Fg",
				"Headline5Fg",
				"Headline6Fg",
			},
		},
	},
	init = function()
		local color_fg = colors.black
		local color1_bg = colors.cyan
		local color2_bg = colors.lightblue
		local color3_bg = colors.blue
		local color4_bg = colors.purple
		local color5_bg = colors.magenta
		local color6_bg = colors.green
		vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], color_fg, color1_bg))
		vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], color_fg, color2_bg))
		vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], color_fg, color3_bg))
		vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], color_fg, color4_bg))
		vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], color_fg, color5_bg))
		vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], color_fg, color6_bg))
	end,
	--[[ config = function()
		require("render-markdown").setup({
			headings = {
				"󰼏 ",
				"󰼐 ",
				"󰼑 ",
				"󰼒 ",
				"󰼓 ",
				"󰼔 ",
			},
			dash = "━",
			bullets = { "", "", "", "" },

			checkbox = {
				unchecked = "󰄰 ",
				checked = "󰄯 ",
			},
			quote = "▍",
		})
	end, ]]
}
