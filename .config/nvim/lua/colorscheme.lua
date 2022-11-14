local cmd = vim.cmd
local colors = require("utils.colors")

local Theming = {
    -- Press <space>fc to see all available themes
    -- colorscheme = "oxocarbon",
    -- colorscheme = "catppuccin",
    colorscheme = "noctis",
    -- colorscheme = "horizon",
    colorscheme_style = "",
    statusline = "slant"
}
-- New colors aren't as nice, using old branch
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

cmd("colorscheme " .. Theming.colorscheme)

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
cmd("hi DiffAdd guifg=" .. colors.green .. " guibg = none")
cmd("hi DiffChange guifg =" .. colors.blue .. " guibg = none")
cmd("hi DiffModified guifg =" .. colors.orange .. " guibg = none")
cmd("hi DiffDeleted guifg =" .. colors.red .. " guibg = none")
