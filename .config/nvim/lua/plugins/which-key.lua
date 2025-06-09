local extra = require("utils.extra")
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")
		wk.setup({
			plugins = {
				marks = true, -- shows a list of your marks on ' and `
				registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
				presets = {
					operators = true, -- adds help for operators like d, y, ...
					motions = true, -- adds help for motions
					text_objects = true, -- help for text objects triggered after entering an operator
					windows = true, -- default bindings on <c-w>
					nav = true, -- misc bindings to work with windows
					z = true, -- bindings for folds, spelling and others prefixed with z
					g = true, -- bindings for prefixed with g
				},
				spelling = { enabled = true, suggestions = 20 },
			},
			icons = {
				breadcrumb = "»",
				separator = "—",
				group = " ",
			},
			expand = 3,
		})

		wk.add({
			{ "<leader>f", group = "Telescope" },
			{ "<leader>ga", group = "GitSigns" },
			{ "<leader>e", group = "NeoTree" },
			{ "<leader>g", group = "Git" },
			{ "<leader>p", group = "Precognition Virtual Text" },
			{ "<leader>c", group = "MultiCursor" },
			{ "<leader>/", group = "Search" },
			{ "<leader>'", group = "Harpoon+Portal" },
			{ "<leader>b", group = "Buffers" },

			{ "<leader>h", group = "Git signs" },
			{ "<leader>hD", desc = "Diff this -" },
			{ "<leader>hR", desc = "Reset buffer" },
			{ "<leader>hS", desc = "Stage buffer" },
			{ "<leader>hd", desc = "Diff this" },
			{ "<leader>hp", desc = "Preview hunk" },
			{ "<leader>hr", desc = "Reset hunk" },
			{ "<leader>hs", desc = "Stage hunk" },
			{ "<leader>hu", desc = "Undo stage hunk" },
		})

		wk.add({
			{ "Q", "<Nop>", desc = "no-op", mode = "n" },
			{ "jk", "<esc>", desc = "Escape insert mode", mode = "i" },
			{ "n", "nzz", desc = "Next + center", mode = "n" },
			{ "N", "Nzz", desc = "Prev + center", mode = "n" },
			{ "<CR>", "<CR>", desc = "<CR>", hidden = true, mode = "n" },
			{ "<TAB>", ":bn<CR>", desc = "Next buffer", mode = "n" },
			{ "<S-TAB>", ":bp<CR>", desc = "Prev buffer", mode = "n" },
			{
				"<f10>",
				[[<Cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>]],
				desc = "Output the current syntax/highlight group",
				mode = "n",
			},
			{ "<leader>y'", ":let @+=expand('%')<CR>", desc = "Copy file path from PWD", mode = "n" },
			{ "y", '"+y', desc = "Copy to OS buffer", mode = { "x" } },
			{ "<leader>pp", '"0p', desc = "Paste from yank register", mode = { "n", "x" } },

			-- Window split
			{ "<leader>H", ":sp<CR>", desc = "Horizontal Split", mode = "n" },
			{ "<leader>V", ":vs<CR>", desc = "Vertical Split", mode = "n" },

			-- Visual mode move lines
			{ "J", ":move '>+1<CR>gv-gv", desc = "Move line down", mode = { "x" } },
			{ "K", ":move '<-2<CR>gv-gv", desc = "Move line up", mode = { "x" } },

			-- Fold Methods
			{ "<leader>si", ":setlocal foldmethod=indent<CR>", desc = "Fold Indent/Whitespace" },
			{ "<leader>ss", ":setlocal foldmethod=expr<CR>", desc = "Fold Expression/Syntax" },

			-- Buffer
			{ "<leader>bn", "<cmd>tabnew<CR>", desc = "New buffer" },
			{
				"<leader>q",
				function()
					extra.close_win_or_buffer()
				end,
				desc = "Close buffer",
			},
			{
				"<leader>Q",
				function()
					extra.close_win_or_buffer(true)
				end,
				desc = "Force close buffer",
			},
		})

		-- LSP Based key-maps
		wk.add({
			{ "gD", ":lua vim.lsp.buf.declaration()<CR>", desc = "Declarations" },
			{ "gF", ":lua vim.diagnostic.open_float()<CR>", desc = "Diagnostic" },
			{ "gH", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", desc = "Inlay hints" },
			{ "gI", ":lua vim.lsp.buf.implementation()<CR>", desc = "Implementation" },
			{ "gP", ":lua vim.diagnostic.goto_next()<CR>", desc = "Goto Prev" },
			{ "gca", ":lua vim.lsp.buf.code_action()<CR>", desc = "Run code actions (fix thigs)" },
			{ "gh", ":lua vim.lsp.buf.hover()<CR>", desc = "Hover details" },
			{ "gp", ":lua vim.diagnostic.goto_prev()<CR>", desc = "Goto Next" },
			{ "gr", ":lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
			{ "gt", ":lua vim.lsp.buf.type_definition()<CR>", desc = "Type Defs" },
		})
	end,
}
