vim.g.mapleader = ","
local ok, nest = pcall(require, 'nest')
if not ok then
	error("Key maps not loaded, nest not available")
end

nest.applyKeymaps {
	{mode = "i", {
		{"jk", "<ESC>"},
	}},
	{mode = "n", {
		{"<TAB>", ":BufferLineCycleNext<CR>"},
		{"<S-TAB>", ":BufferLineCyclePrev<CR>"},
		{"<space>rn", ":lua vim.lsp.buf.rename()<CR>"},
		-- leader + key binds
		{"<leader>", {
			-- Basics
			{"w", ":update<CR>"},
			{"V", ":vs<CR>"},
			{"H", ":sp<CR>"},
			{"sv", ":source $MYVIMRC<CR>"},
			{"c", ":let @+=expand('%:p')<CR>"},
			{"Q", "<Nop>"},
			{"n", "nzz"},
			{"N", "Nzz"},
			{"q", ":bp<CR>:bd#<CR>"},
			{"bb", ":Telescope buffers<CR>"},
			-- Undotree
			-- {"u", ":UndotreeToggle<CR>"},
			-- Floaterm
			{"tk", ":FloatermKill<CR>"},
			-- Dashboard
			{"<Home>", [[<Cmd> Dashboard<CR>]]},
			{"fn", [[<Cmd> DashboardNewFile<CR>]]},
			{"bm", [[<Cmd> DashboardJumpMarks<CR>]]},
			{"sl", [[<Cmd> SessionLoad<CR>]]},
			{"ss", [[<Cmd> SessionSave<CR>]]},
			-- Trouble
			{"xx", "<cmd>TroubleToggle<cr>", {silent = true, noremap = true}},
			-- Spell checker
			{"ck", ":set spell!<cr>"},
			-- File manager
			{"e", ":NvimTreeToggle<CR>"},
			-- Git
			{"g", {
				{"g", ":FloatermNew lazygit<CR>"},
				{"f", ":Telescope git_files<CR>"},
				{"c", ":Telescope git_commits<CR>"},
				{"b", ":Telescope git_branches<CR>"},
				{"s", ":Telescope git_status<CR>"},
			}},
			-- Bufferline/Buffers
			{"b", {
				{"1", ":BufferLineGoToBuffer 1<CR>"},
				{"2", ":BufferLineGoToBuffer 2<CR>"},
				{"3", ":BufferLineGoToBuffer 3<CR>"},
				{"4", ":BufferLineGoToBuffer 4<CR>"},
				{"5", ":BufferLineGoToBuffer 5<CR>"},
				{"6", ":BufferLineGoToBuffer 6<CR>"},
				{"7", ":BufferLineGoToBuffer 7<CR>"},
				{"8", ":BufferLineGoToBuffer 8<CR>"},
				{"9", ":BufferLineGoToBuffer 9<CR>"},
				{"p", ":BufferLinePick<CR>"},
			}},
			{"f", {
				-- Set fold method
				{"i", ":setlocal foldmethod=indent<CR>"},
				{"s", ":setlocal foldmethod=expr<CR>"},
				-- Telescope
				{"f", ":Telescope find_files<CR>"},
				{"g", ":Telescope live_grep<CR>"},
				{"h", ":Telescope help_tags<CR>"},
				{"c", ":Telescope colorscheme<CR>"},
				{"a", ":lua require('utils.core').search_dotfiles()<CR>"},
				{"n", ":lua require('utils.core').search_nvim()<CR>"},
				{"o", [[<Cmd>Telescope oldfiles<CR>]]},
				{"p", ":Telescope projects<CR>"},
				-- format code
				{"m", [[<Cmd> Neoformat<CR>]], {}},
				{"r", ":NvimTreeRefresh<CR>"},
			}},
		}},
		-- ctrl + key binds
		{"<C-", {
			{"p>", ":lua vim.diagnostic.goto_prev()<CR>"},
			{"n>", ":lua vim.diagnostic.goto_next()<CR>"},
			-- Better window navigation
			{"h>", "<C-w>h"},
			{"j>", "<C-w>j"},
			{"k>", "<C-w>k"},
			{"l>", "<C-w>l"},
			{"w>", ":bp<CR>:bd#<CR>"},
			-- Comment
			{'_>', ':lua require("Comment.api").toggle_current_linewise()<CR>'},
		}},
		-- Shift + key binds
		{"<S-", {
			-- Resize windows
			{"k>", ":resize -2<CR>"},
			{"j>", ":resize +2<CR>"},
			{"h>", ":vertical resize -2<CR>"},
			{"l>", ":vertical resize +2<CR>"},
		}},
		-- LSP
		{"g", {
			{"D", ":lua vim.lsp.buf.declaration()<CR>"},
			{"d", ":Telescope lsp_definitions<CR>"},
			{"t", ":lua vim.lsp.buf.type_definition()<CR>"},
			{"r", ":Telescope lsp_references<CR>"},
			{"h", ":lua vim.lsp.buf.hover()<CR>"},
			{"i", ":lua vim.lsp.buf.implementation()<CR>"},
		}},
	}},
	{mode = "x", {
		{"<leader>y", "\"+y"},
		{'<c-_>', ':lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>'},
		-- Move selected line / block of text in visual mode
		{"K", ":move '<-2<CR>gv-gv"},
		{"J", ":move '>+1<CR>gv-gv"}
	}},
}

