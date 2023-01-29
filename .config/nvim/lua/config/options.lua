local u = require("utils.core")
require("utils.colors")
local cmd = vim.cmd

vim.g.mapleader = ","
-- Global
u.opt("o", "incsearch", true)
u.opt("o", "ignorecase", true)
u.opt("o", "smartcase", true)
u.opt("o", "smarttab", true)
u.opt("o", "title", true)
u.opt("o", "backup", false)
u.opt("o", "writebackup", false)
u.opt("o", "clipboard", "unnamedplus")
u.opt("o", "showmode", false)
u.opt("o", "pumheight", 15)
u.opt("o", "showtabline", 2)
u.opt("o", "updatetime", 100)
u.opt("o", "scrolloff", 10)
u.opt("o", "cmdheight", 2)
u.opt("o", "termguicolors", true)
u.opt("o", "mouse", "a")
u.opt("o", "hidden", true)
u.opt("o", "splitbelow", true)
u.opt("o", "splitright", true)
u.opt("o", "completeopt", "menuone,noinsert,noselect")
-- u.opt("o", "spell", true)
u.opt("o", "spelllang", Opts.language)
-- u.opt("o", "signcolumn", "number")

-- Window
u.opt("w", "relativenumber", true)
u.opt("w", "number", true)
u.opt("w", "numberwidth", 1)
u.opt("w", "wrap", false)
u.opt("w", "cursorline", true)
u.opt("w", "conceallevel", 0)

-- Buffer
local indent = Formatting.indent_size
u.opt("b", "tabstop", indent)
u.opt("b", "softtabstop", indent)
u.opt("b", "shiftwidth", indent)
u.opt("b", "expandtab", false)
u.opt("b", "autoindent", true)
u.opt("b", "smartindent", true)
u.opt("b", "swapfile", false)
u.opt("b", "fileencoding", "utf-8")
u.opt("b", "syntax", "on")

-- Commands
cmd("set shortmess+=c")
cmd("set iskeyword+=-")
cmd("set path+=**")
cmd("filetype on")
cmd("filetype plugin on")

-- Folding
cmd("set nofoldenable")
cmd("set foldmethod=expr")
cmd("set foldexpr=nvim_treesitter#foldexpr()")
cmd("set foldcolumn=1")

-- Emmet
vim.g.user_emmet_mode = "inv"
vim.g.user_emmet_expandabbr_key = ",,"
vim.g.user_emmet_expandword_key = "<C-y>;"
vim.g.user_emmet_update_tag = "<C-y>u"
vim.g.user_emmet_balancetaginward_key = "<C-y>d"
vim.g.user_emmet_balancetagoutward_key = "<C-y>D"
vim.g.user_emmet_next_key = "<C-y>n"
vim.g.user_emmet_prev_key = "<C-y>N"
vim.g.user_emmet_imagesize_key = "<C-y>i"
vim.g.user_emmet_togglecomment_key = "<C-y>/"
vim.g.user_emmet_splitjointag_key = "<C-y>j"
vim.g.user_emmet_removetag_key = "<C-y>k"
vim.g.user_emmet_anchorizeurl_key = "<C-y>a"
vim.g.user_emmet_anchorizesummary_key = "<C-y>A"
vim.g.user_emmet_mergelines_key = "<C-y>m"
vim.g.user_emmet_codepretty_key = "<C-y>c"
