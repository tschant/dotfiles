local u = require("utils.core")
vim.g.mapleader = ","

-- Basics
u.map("n", "<leader>w", ":update<CR>")
u.map("i", "jk", "<ESC>")
u.map("n", "Q", "<Nop>")
u.map("n", "<leader>V", ":vs<CR>")
u.map("n", "<leader>H", ":sp<CR>")
u.map("n", "<leader>sv", ":source $MYVIMRC<CR>")
u.map("n", "n", "nzz")
u.map("n", "N", "Nzz")
u.map("n", "<leader>c", ":let @+=expand('%:p')<CR>")

u.map("n", "<leader>fi", ":setlocal foldmethod=indent<CR>")
u.map("n", "<leader>fs", ":setlocal foldmethod=expr<CR>") -- expr for treesitter based folding
u.map("x", "<leader>y", "\"+y")

-- Move selected line / block of text in visual mode
u.map("x", "K", ":move '<-2<CR>gv-gv")
u.map("x", "J", ":move '>+1<CR>gv-gv")

-- Better window navigation
u.map("n", "<CR>", ":NeoZoomToggle<CR>")
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

-- Resize windows
u.map("n", "<S-k>", ":resize -2<CR>")
u.map("n", "<S-j>", ":resize +2<CR>")
u.map("n", "<S-h>", ":vertical resize -2<CR>")
u.map("n", "<S-l>", ":vertical resize +2<CR>")

-- Floaterm
u.map("n", "<leader>tk", ":FloatermKill<CR>")

-- Undotree
u.map("n", "<leader>u", ":UndotreeToggle<CR>")

-- Git
u.map("n", "<leader>gg", ":FloatermNew lazygit<CR>")
u.map("n", "<leader>gf", ":Telescope git_files<CR>")
u.map("n", "<leader>gc", ":Telescope git_commits<CR>")
u.map("n", "<leader>gb", ":Telescope git_branches<CR>")
u.map("n", "<leader>gs", ":Telescope git_status<CR>")

-- buffer navigation
u.map("n", "<leader>q", ":BufDel<CR>")
u.map("n", "<C-q>", ":BufDel<CR>")
u.map("n", "<TAB>", ":BufferLineCycleNext<CR>")
u.map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>")
u.map("n", "<Leader>b1", ":BufferLineGoToBuffer 1<CR>")
u.map("n", "<Leader>b2", ":BufferLineGoToBuffer 2<CR>")
u.map("n", "<Leader>b3", ":BufferLineGoToBuffer 3<CR>")
u.map("n", "<Leader>b4", ":BufferLineGoToBuffer 4<CR>")
u.map("n", "<Leader>b5", ":BufferLineGoToBuffer 5<CR>")
u.map("n", "<Leader>b6", ":BufferLineGoToBuffer 6<CR>")
u.map("n", "<Leader>b7", ":BufferLineGoToBuffer 7<CR>")
u.map("n", "<Leader>b8", ":BufferLineGoToBuffer 8<CR>")
u.map("n", "<Leader>b9", ":BufferLineGoToBuffer 9<CR>")
u.map("n", "<Leader>bp", ":BufferLinePick<CR>")

-- File manager
u.map("n", "<leader>e", ":NvimTreeToggle<CR>")
u.map("n", "<leader>fr", ":NvimTreeRefresh<CR>")

-- Telescope
u.map("n", "<leader>ff", ":Telescope find_files<CR>")
u.map("n", "<leader>fg", ":Telescope live_grep<CR>")
u.map("n", "<leader>fh", ":Telescope help_tags<CR>")
u.map("n", "<leader>fc", ":Telescope colorscheme<CR>")
u.map("n", "<leader>fa", ":lua require('utils.core').search_dotfiles()<CR>")
-- u.map("n", "<leader>fn", ":lua require('utils.core').search_nvim()<CR>")
u.map("n", "<leader>bb", ":Telescope buffers<CR>")
u.map("n", "<Leader>fo", [[<Cmd>Telescope oldfiles<CR>]])
u.map("n", "<leader>fp", ":Telescope projects<CR>")

-- Dashboard
u.map("n", "<Leader><Home>", [[<Cmd> Dashboard<CR>]])
u.map("n", "<Leader>fn", [[<Cmd> DashboardNewFile<CR>]])
u.map("n", "<Leader>bm", [[<Cmd> DashboardJumpMarks<CR>]])
u.map("n", "<leader>sl", [[<Cmd> RestoreSession<CR>]])
u.map("n", "<leader>ss", [[<Cmd> SaveSession<CR>]])

-- LSP
u.map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")
u.map("n", "gd", ":Telescope lsp_definitions<CR>")
u.map("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>")
u.map("n", "gr", ":Telescope lsp_references<CR>")
u.map("n", "gh", ":lua vim.lsp.buf.hover()<CR>")
u.map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
u.map("n", "<space>rn", ":lua vim.lsp.buf.rename()<CR>")
u.map("n", "<c-p>", ":lua vim.diagnostic.goto_prev()<CR>")
u.map("n", "<c-n>", ":lua vim.diagnostic.goto_next()<CR>")

-- Trouble
u.map("n", "<leader>xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true})

-- Spell checker
u.map("n", "<leader>ck", ":set spell!<cr>")

-- format code
u.map("n", "<Leader>fm", [[<Cmd> Neoformat<CR>]], {})

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
