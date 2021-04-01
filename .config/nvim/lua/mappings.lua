local u = require("utils.core")

vim.g.mapleader = ","

-- Basics
u.map("n", "<leader>w", ":update<CR>")
u.map("n", "<leader>q", ":BufferClose<CR>")
u.map("n", "<C-w>", ":BufferClose<CR>")
u.map("i", "jk", "<ESC>")
u.map("n", "Q", "<Nop>")
u.map("n", "<leader>V", ":vs<CR>")
u.map("n", "<leader>H", ":sp<CR>")
u.map("n", "<leader><Home>", ":Startify<CR>")
-- u.map("n", "<leader>.", "q:k<CR>")

-- Move selected line / block of text in visual mode
u.map("x", "K", ":move '<-2<CR>gv-gv")
u.map("x", "J", ":move '>+1<CR>gv-gv")

-- Better window navigation
u.map("n", "<C-h>", "<C-w>h")
u.map("n", "<C-j>", "<C-w>j")
u.map("n", "<C-k>", "<C-w>k")
u.map("n", "<C-l>", "<C-w>l")

-- Check file in shellcheck
u.map("n", "<leader>sc", ":!clear && shellcheck -x %<CR>")

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
u.map("n", "<TAB>", ":BufferNext<CR>")
u.map("n", "<S-TAB>", ":BufferPrevious<CR>")
u.map("n", "<A-1>", ":BufferGoto 1<CR>")
u.map("n", "<A-2>", ":BufferGoto 2<CR>")
u.map("n", "<A-3>", ":BufferGoto 3<CR>")
u.map("n", "<A-4>", ":BufferGoto 4<CR>")
u.map("n", "<A-5>", ":BufferGoto 5<CR>")
u.map("n", "<A-6>", ":BufferGoto 6<CR>")
u.map("n", "<A-7>", ":BufferGoto 7<CR>")
u.map("n", "<A-8>", ":BufferGoto 8<CR>")
u.map("n", "<A-9>", ":BufferGoto 9<CR>")
u.map("n", "<A-l>", ":BufferLast<CR>")

-- File manager
u.map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
u.map("n", "<leader>ff", ":Telescope find_files<CR>")
u.map("n", "<leader>fg", ":Telescope live_grep<CR>")
u.map("n", "<leader>fm", ":Telescope media_files<CR>")
u.map("n", "<leader>fh", ":Telescope help_tags<CR>")
u.map("n", "<leader>fc", ":Telescope colorscheme<CR>")
u.map("n", "<leader>fa", ":lua require('utils.core').search_dotfiles()<CR>")
u.map("n", "<leader>fn", ":lua require('utils.core').search_nvim()<CR>")
u.map("n", "<leader>b", ":Telescope buffers<CR>")

-- LSP
u.map("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")
u.map("n", "gd", ":Telescope lsp_definitions<CR>")
u.map("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>")
u.map("n", "gr", ":Telescope lsp_references<CR>")
u.map("n", "gh", ":lua vim.lsp.buf.hover()<CR>")
u.map("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
u.map("n", "<space>rn", ":lua vim.lsp.buf.rename()<CR>")
u.map("n", "<c-p>", ":lua vim.lsp.diagnostic.goto_prev()<CR>")
u.map("n", "<c-n>", ":lua vim.lsp.diagnostic.goto_next()<CR>")