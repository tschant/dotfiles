-- require("handlers")
local cmd = vim.cmd

local Theming = {
    -- Press <space>fc to see all available themes
    -- colorscheme = "base16-gruvbox-dark-pale",
    colorscheme = "catppuccin",
    -- colorscheme = "kanagawa",
    -- colorscheme = "srcery",
    -- colorscheme = "nightfox",
    -- colorscheme = "nordfox",
    colorscheme_style = "",
    statusline = "slant"
}
-- New colors aren't as nice, using old branch
require("catppuccin").setup({
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
--[[ require("catppuccino").setup({
	colorscheme = "neon_latte",
	transparency = true,
	term_colors = true,
	integrations = {
		nvimtree = {
			enabled = false,
			show_root = true,
		},
		barbar = true,
		bufferline = true,
		dashboard = false,
		telescope = true,
		gitsigns = true
	}
}) ]]

require('kanagawa').setup({
    undercurl = true,
    commentStyle = "italic",
    functionStyle = "NONE",
    keywordStyle = "italic",
    statementStyle = "bold",
    typeStyle = "NONE",
    transparent = true,
    colors = {},
    overrides = {},
})

-- Nightfox settings

cmd("colorscheme " .. Theming.colorscheme)

-- Use terminal background color instead of colorscheme
cmd "hi Normal ctermbg=none guibg=none"

-- highlights --
cmd "hi LineNr guifg=#383c44 guibg=NONE"
-- cmd "hi Comment guifg=#307050"
-- cmd "au ColorScheme * hi Comment guifg=#3d4149"
cmd "hi SignColumn guibg=NONE"
cmd "hi VertSplit guibg=NONE guifg=#2a2e36"
cmd "hi EndOfBuffer guifg=#1e222a"
cmd "hi PmenuSel guibg=#98c379"
cmd "hi Pmenu  guibg=#282c34"

-- git signs
cmd "hi DiffAdd guifg=#81A1C1 guibg = none"
cmd "hi DiffChange guifg =#3A3E44 guibg = none"
cmd "hi DiffModified guifg = #81A1C1 guibg = none"

