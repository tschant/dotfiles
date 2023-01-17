local cmd = vim.cmd

local Theme = "horizon"
local config_load = function() 
	if Theme == "catppuccin" then
		require("catppuccin").setup({
			-- flavour = 'latte',
			flavour = 'mocha',
			transparent_background = true,
			term_colors = true,
			integrations = {
				nvimtree = {
					enabled = false,
					show_root = true,
				},
				barbar = true,
				dashboard = false,
				telescope = true,
				gitsigns = true
			}
		})
	end

	cmd("colorscheme " .. Theme)

	-- Use terminal background color instead of colorscheme
	cmd "hi Normal ctermbg=none guibg=none"
	cmd "hi NormalNC ctermbg=none guibg=#262626"

	-- highlights --
	cmd "hi EndOfBuffer guifg=#525252 guibg=NONE"
	cmd "hi gitcommitOverflow guifg=#525252 guibg=NONE"
	cmd "hi gitcommitTrailers guifg=#525252 guibg=NONE"
	cmd "hi Visual guibg=#525252"
	-- cmd "hi Comment guifg=#307050"
	-- cmd "au ColorScheme * hi Comment guifg=#3d4149"
	-- cmd "hi SignColumn guibg=NONE"
	-- cmd "hi EndOfBuffer guifg=#1e222a"
	-- cmd "hi PmenuSel guibg=#98c379"
	-- cmd "hi Pmenu  guibg=#282c34"
	--
	-- -- git signs
	local colors = require("utils.colors")
	cmd("hi DiffAdd guifg=" .. colors.green .. " guibg = none")
	cmd("hi DiffChange guifg =" .. colors.blue .. " guibg = none")
	cmd("hi DiffModified guifg =" .. colors.orange .. " guibg = none")
	cmd("hi DiffDeleted guifg =" .. colors.red .. " guibg = none")
	cmd("hi DiagnosticError guifg =" .. colors.error .. " guibg = none")
	cmd("hi DiagnosticWarn guifg =" .. colors.warning .. " guibg = none")
	cmd("hi DiagnosticInfo guifg =" .. colors.info .. " guibg = none")
	-- cmd("hi DiagnosticHint guifg =" .. colors.hint .. " guibg = none")
end

return {
	{
		'kartikp10/noctis.nvim',
		dependencies = { 'rktjmp/lush.nvim' },
		-- lazy = false,
		-- priority = 1000,
		config = config_load
	}, 
	--[[ {
		'talha-akram/noctis.nvim',
		lazy = false,
		priority = 1000,
		config = config_load
	}, ]]
	-- Themes
	--"norcalli/nvim-base16.lua",
	{
		"catppuccin/nvim",
		branch = "main",
		-- event = "VeryLazy",
		config = config_load
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		-- branch = "fennel",
		-- event = "VeryLazy",
		-- lazy = false,
		-- priority = 1000,
		config = config_load
	},
	{
		'LunarVim/horizon.nvim',
		lazy = false,
		priority = 1000,
		config = config_load
	},
}
