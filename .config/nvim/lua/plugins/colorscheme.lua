local cmd = vim.cmd

local Theme = "midnight"
local config_load = function() 
	cmd("colorscheme " .. Theme)

	-- Use terminal background color instead of colorscheme
	cmd "hi Normal ctermbg=none guibg=none"
	cmd "hi NormalNC ctermbg=none guibg=#262626"
	cmd "hi SignColumn ctermbg=none guibg=none"
	cmd "hi FoldColumn ctermbg=none guibg=none"
	cmd "hi FocusedLine ctermbg=none guibg=none guifg=#525252"
	-- cmd "hi StatusColumnBorder guifg=SignColumn guibg=SignColumn"
	-- cmd "hi StatusColumnGitSigns guifg=SignColumn guibg=SignColumn"

	-- highlights --
	cmd "hi EndOfBuffer guifg=#525252 guibg=NONE"
	cmd "hi gitcommitOverflow guifg=#525252 guibg=NONE"
	cmd "hi gitcommitTrailers guifg=#525252 guibg=NONE"
	cmd "hi Visual guibg=#525252"
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
	cmd("hi DiagnosticHint guifg =" .. colors.hint .. " guibg = none")
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
		"dasupradyumna/midnight.nvim",
		-- branch = "main",
		lazy = false,
		priority = 1000,
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
		-- lazy = false,
		-- priority = 1000,
		config = config_load
	},
	-- {
	-- 	'KoBruhh/tranquil-vim',
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = config_load
	-- },
}
