local u = require("utils.core")
vim.g.mapleader = ","

-- Basics
u.map("n", "<leader>w", ":update<CR>")
u.map("i", "jk", "<ESC>")
u.map("n", "Q", "<Nop>")
u.map("n", "<leader>V", ":vs<CR>")
u.map("n", "<leader>H", ":sp<CR>")
-- u.map("n", "<leader>sv", ":source $MYVIMRC<CR>")
u.map("n", "n", "nzz")
u.map("n", "N", "Nzz")
u.map("n", "<leader>cc", ":let @+=expand('%')<CR>")
u.map("t", "<leader><ESC>", "<C-\\><C-n>")

u.map("n", "<leader>si", ":setlocal foldmethod=indent<CR>")
u.map("n", "<leader>ss", ":setlocal foldmethod=expr<CR>") -- expr for treesitter based folding
u.map("x", "<leader>y", "\"+y")

-- VimMulti
u.map("n", "<M-Up>", ":call vm#commands#add_cursor_up(0, v:count1)<cr>")
u.map("n", "<M-Down>", ":call vm#commands#add_cursor_down(0, v:count1)<cr>")

-- -- Move selected line / block of text in visual mode
-- u.map("n", "K", ":move '<-2<CR>gv-gv")
u.map("x", "K", ":move '<-2<CR>gv-gv")
-- u.map("n", "J", ":move '>+1<CR>gv-gv")
u.map("x", "J", ":move '>+1<CR>gv-gv")

-- Better window navigation
u.map("n", "<CR>", "<CR>")
u.map("n", "<C-h>", "<C-w>h")
u.map("n", "<C-j>", "<C-w>j")
u.map("n", "<C-k>", "<C-w>k")
u.map("n", "<C-l>", "<C-w>l")
u.map("n", "<leader>h", ":FocusSplitLeft<CR>")
u.map("n", "<leader>j", ":FocusSplitDown<CR>")
u.map("n", "<leader>k", ":FocusSplitUp<CR>")
u.map("n", "<leader>l", ":FocusSplitRight<CR>")

-- Check file in shellcheck
-- u.map("n", "<leader>sc", ":!clear && shellcheck -x %<CR>")

-- Floaterm
u.map("n", "<leader>wn", ":FloatermNew nvim +VimwikiIndex .<CR>")

-- Undotree
u.map("n", "<leader>u", ":UndotreeToggle<CR>")

-- Git
u.map("n", "<leader>gg", ":FloatermNew lazygit<CR>")
-- u.map("n", "<leader>gf", ":Telescope git_files<CR>")
-- u.map("n", "<leader>gc", ":Telescope git_commits<CR>")
-- u.map("n", "<leader>gb", ":Telescope git_branches<CR>")

-- buffer navigation BarBar
u.map("n", "<leader>q", ":BufferClose<CR>")
u.map("n", "<C-q>", ":BufferClose<CR>")
u.map("n", "<TAB>", ":BufferNext<CR>")
u.map("n", "<S-TAB>", ":BufferPrev<CR>")

-- File manager
-- u.map("n", "<leader>e", ":NvimTreeToggle<CR>")
-- u.map("n", "<leader>rr", ":NvimTreeRefresh<CR>")

-- Neotree
u.map("n", "<leader>e", ":Neotree filesystem reveal left toggle=true<CR>")
u.map("n", "<leader>gs", ":Neotree git_status reveal bottom toggle=true<CR>")
u.map("n", "<leader>xx", ":Neotree diagnostics reveal bottom toggle=true<cr>")

-- Dashboard
u.map("n", "<Leader><Home>", [[<Cmd> Dashboard<CR>]])
u.map("n", "<Leader>nn", [[<Cmd> DashboardNewFile<CR>]])
-- u.map("n", "<Leader>bm", [[<Cmd> DashboardJumpMarks<CR>]])
u.map("n", "<leader>sr", [[<Cmd> RestoreSession<CR>]])
u.map("n", "<leader>sv", [[<Cmd> SaveSession<CR>]])

-- LSP
u.map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")
u.map("n", "gd", ":Telescope lsp_definitions<CR>")
u.map("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>")
u.map("n", "gr", ":Telescope lsp_references<CR>")
u.map("n", "gh", ":lua vim.lsp.buf.hover()<CR>")
u.map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
u.map("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
u.map("n", "gp", ":lua vim.diagnostic.goto_prev()<CR>")
u.map("n", "gP", ":lua vim.diagnostic.goto_next()<CR>")

-- Syntax Tree Surfer - treesitter smart selection
u.map("n", "gv", ":lua require('syntax-tree-surfer').targeted_jump({'variable_declaration'})<CR>")
u.map("n", "gfu", ":lua require('syntax-tree-surfer').targeted_jump({'function'})<CR>")
u.map("n", "gif", ":lua require('syntax-tree-surfer').targeted_jump({'if_statement'})<CR>")
u.map("n", "gj", ":lua require('syntax-tree-surfer').targeted_jump({'function', 'if_statement', 'else_clause', 'else_statement', 'elseif_statement', 'for_statement', 'while_statement', 'switch_statement'})<CR>")
u.map("n", "gn", ":lua require('syntax-tree-surfer').filtered_jump('default', true)<CR>")
u.map("n", "gN", ":lua require('syntax-tree-surfer').filtered_jump('default', false)<CR>")
u.map("n", "vd", '<cmd>lua require("syntax-tree-surfer").move("n", false)<cr>', {noremap = true, silent = true})
u.map("n", "vu", '<cmd>lua require("syntax-tree-surfer").move("n", true)<cr>', {noremap = true, silent = true})
-- .select() will show you what you will be swapping with .move(), you'll get used to .select() and .move() behavior quite soon!
u.map("n", "vx", '<cmd>lua require("syntax-tree-surfer").select()<cr>', {noremap = true, silent = true})
-- .select_current_node() will select the current node at your cursor
u.map("n", "vn", '<cmd>lua require("syntax-tree-surfer").select_current_node()<cr>', {noremap = true, silent = true})
-- u.map("x", "J", '<cmd>lua require("syntax-tree-surfer").surf("next", "visual")<cr>', {noremap = true, silent = true})
-- u.map("x", "K", '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual")<cr>', {noremap = true, silent = true})
u.map("x", "H", '<cmd>lua require("syntax-tree-surfer").surf("parent", "visual")<cr>', {noremap = true, silent = true})
u.map("x", "L", '<cmd>lua require("syntax-tree-surfer").surf("child", "visual")<cr>', {noremap = true, silent = true})

-- Spell checker
u.map("n", "<leader>ck", ":set spell!<cr>")
-- format code
u.map("n", "<Leader>cm", [[<Cmd> Neoformat<CR>]], {})

-- Comment
u.map('n', '<c-_>', ':lua require("Comment.api").toggle_current_linewise()<CR>') -- ctrl-/
u.map('x', '<c-_>', ':lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>') -- ctrl-/

--[[ -- Package info
u.map("n", "<leader>ns", ":lua require('package-info').show()<CR>", { silent = true, noremap = true })
-- Hide package versions
u.map("n", "<leader>nc", ":lua require('package-info').hide()<CR>", { silent = true, noremap = true })
-- Update package on line
u.map("n", "<leader>nu", ":lua require('package-info').update()<CR>", { silent = true, noremap = true })
-- Delete package on line
u.map("n", "<leader>nd", ":lua require('package-info').delete()<CR>", { silent = true, noremap = true })
-- Install a new package
u.map("n", "<leader>ni", ":lua require('package-info').install()<CR>", { silent = true, noremap = true })
-- Reinstall dependencies
u.map("n", "<leader>nr", ":lua require('package-info').reinstall()<CR>", { silent = true, noremap = true })
-- Install a different package version
u.map("n", "<leader>np", ":lua require('package-info').change_version()<CR>", { silent = true, noremap = true })
 ]]

-- " Output the current syntax group
u.map('n', '<f10>', [[<Cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>]])
