-- require("handlers")
local cmd = vim.cmd

--local base16 = require "base16"
--base16(base16.themes["horizon-dark"], true)

cmd("colorscheme " .. Theming.colorscheme)
-- Use terminal background color instead of colorscheme
cmd "au ColorScheme * hi Normal ctermbg=none guibg=none"

-- spacevim settings
vim.g.space_vim_italic = 1

-- highlights --
cmd "au ColorScheme * hi LineNr guifg=#383c44 guibg=NONE"
cmd "au ColorScheme * hi Comment guifg=#307050"
-- cmd "au ColorScheme * hi Comment guifg=#3d4149"
cmd "au ColorScheme * hi SignColumn guibg=NONE"
cmd "au ColorScheme * hi VertSplit guibg=NONE guifg=#2a2e36"
cmd "au ColorScheme * hi EndOfBuffer guifg=#1e222a"
cmd "au ColorScheme * hi PmenuSel guibg=#98c379"
cmd "au ColorScheme * hi Pmenu  guibg=#282c34"

-- telescope stuff and popupmenu

cmd "au ColorScheme * hi TelescopeBorder   guifg=#2a2e36"
cmd "au ColorScheme * hi TelescopePromptBorder   guifg=#2a2e36"
cmd "au ColorScheme * hi TelescopeResultsBorder  guifg=#2a2e36"
cmd "au ColorScheme * hi TelescopePreviewBorder  guifg=#525865"

--  nvim tree color for folder name and icon

cmd "au ColorScheme * hi NvimTreeFolderIcon guifg = #61afef"
cmd "au ColorScheme * hi NvimTreeFolderName guifg = #61afef"
cmd "au ColorScheme * hi NvimTreeIndentMarker guifg=#383c44"

-- git signs

cmd "au ColorScheme * hi DiffAdd guifg=#81A1C1 guibg = none"
cmd "au ColorScheme * hi DiffChange guifg =#3A3E44 guibg = none"
cmd "au ColorScheme * hi DiffModified guifg = #81A1C1 guibg = none"
