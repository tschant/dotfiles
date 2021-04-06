-- require("handlers")
local cmd = vim.cmd

local base16 = require "base16"
base16(base16.themes["horizon-dark"], true)

-- spacevim settings
vim.g.space_vim_italic = 1

-- highlights --
cmd "hi LineNr guifg=#383c44 guibg=NONE"
cmd "hi Comment guifg=#3d4149"
cmd "hi SignColumn guibg=NONE"
cmd "hi VertSplit guibg=NONE guifg=#2a2e36"
cmd "hi EndOfBuffer guifg=#1e222a"
cmd "hi PmenuSel guibg=#98c379"
cmd "hi Pmenu  guibg=#282c34"

-- telescope stuff and popupmenu

cmd "hi TelescopeBorder   guifg=#2a2e36"
cmd "hi TelescopePromptBorder   guifg=#2a2e36"
cmd "hi TelescopeResultsBorder  guifg=#2a2e36"
cmd "hi TelescopePreviewBorder  guifg=#525865"

--  nvim tree color for folder name and icon

cmd "hi NvimTreeFolderIcon guifg = #61afef"
cmd "hi NvimTreeFolderName guifg = #61afef"
cmd "hi NvimTreeIndentMarker guifg=#383c44"

cmd "hi Normal guibg=NONE ctermbg=NONE"

-- git signs

cmd "hi DiffAdd guifg=#81A1C1 guibg = none"
cmd "hi DiffChange guifg =#3A3E44 guibg = none"
cmd "hi DiffModified guifg = #81A1C1 guibg = none"
