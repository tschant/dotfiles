local util = require("utils.core")
local extra = require("utils.extra")
local M = {
	"folke/which-key.nvim",
	event = "VeryLazy",
	--[[ keys = {
		"<tab>",
		"<S-tab>",
		"<leader>",
		"<F2>", -- toggle term
		"<F3>", -- lazygit
		"<F4>", -- btop
		"<C-q>", -- close
	}, ]]
}

M.config = function()
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
			spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
		},
		icons = {
			breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
			separator = "—", -- symbol used between a key and it's label
			group = " ", -- symbol prepended to a group
		},
		expand = 3,
		--[[ hidden = {
			"<silent>",
			"<cmd>",
			"<Cmd>",
			"<cr>",
			"<CR>",
			"<Cr>",
			"call",
			"lua",
			"^:",
			"^ ",
		}, ]]
	})

	-- Random key-maps
	wk.add({
		{ "Q", "<Nop>", desc = "no-op" },
		{ "n", "nzz", desc = "Next + center" },
		{ "N", "Nzz", desc = "Prev + center" },
		{ "<CR>", "<CR>", desc = "<CR>", hidden = true },
		{ "<TAB>", ":bn<CR>", desc = "Next buffer" },
		{ "<S-TAB>", ":bp<CR>", desc = "Prev buffer" },
		{
			"<f10>",
			[[<Cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>]],
			desc = "Output the current syntax/highlight group",
		},
		{ "<M-Up>", ":call vm#commands#add_cursor_up(0, v:count1)<cr>", desc = "Select next line up (vm)" },
		{ "<M-Down>", ":call vm#commands#add_cursor_down(0, v:count1)<cr>", desc = "Select next line down (vm)" },

		{ "<leader><Home>", ":lua Snacks.dashboard()<CR>", desc = "Dashboard" },
		{ "<leader>H", ":sp<CR>", desc = "Horizontal Split" },
		{ "<leader>V", ":vs<CR>", desc = "Vertical Split" },
		{ "<leader>cc", ":let @+=expand('%')<CR>", desc = "Copy file path from PWD" },
	}, { mode = "n" })

	wk.add({
		{ "jk", "<esc>", desc = "Escape insert mode", mode = "i" },
	})

	-- LSP Based key-maps
	wk.add({
		{ "gD", ":lua vim.lsp.buf.declaration()<CR>", desc = "Declarations" },
		{ "gF", ":lua vim.diagnostic.open_float()<CR>", desc = "Diagnostic" },
		{ "gH", ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", desc = "Inlay hints" },
		{ "gI", ":lua vim.lsp.buf.implementation()<CR>", desc = "Implementation" },
		{ "gN", ":lua require('syntax-tree-surfer').filtered_jump('default', false)<CR>", desc = "Filter Jump Prev" },
		{ "gP", ":lua vim.diagnostic.goto_next()<CR>", desc = "Goto Prev" },
		{
			"gR",
			"<cmd>lua require('telescope.builtin').lsp_references({ show_line = false })<CR>",
			desc = "References",
		},
		{ "gca", ":lua vim.lsp.buf.code_action()<CR>", desc = "Run code actions (fix thigs)" },
		{ "gd", ":Telescope lsp_definitions<CR>", desc = "Definitions" },
		{ "gf", ":lua require('conform').format({ async = true, lsp_fallback = true })<CR>", desc = "LSP Format file" },
		{ "gh", ":lua vim.lsp.buf.hover()<CR>", desc = "Hover details" },
		-- Syntax Tree Surfer - treesitter smart selection
		{
			"gj",
			function()
				require("syntax-tree-surfer").targeted_jump({
					"variable_declaration",
					"function",
					"if_statement",
					"else_clause",
					"else_statement",
					"elseif_statement",
					"for_statement",
					"while_statement",
					"switch_statement",
				})
			end,
			desc = "Jump ALL",
		},
		{ "gn", ":lua require('syntax-tree-surfer').filtered_jump('default', true)<CR>", desc = "Filter Jump Next" },
		{ "gp", ":lua vim.diagnostic.goto_prev()<CR>", desc = "Goto Next" },
		{ "gr", ":lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
		{
			"gs",
			util.telescope("lsp_document_symbols", {
				symbols = {
					"Class",
					"Function",
					"Method",
					"Constructor",
					"Interface",
					"Module",
					"Struct",
					"Trait",
					"Field",
					"Property",
				},
			}),
			desc = "Goto Symbol",
		},
		{ "gt", ":lua vim.lsp.buf.type_definition()<CR>", desc = "Type Defs" },
		{ "vd", '<cmd>lua require("syntax-tree-surfer").move("n", false)<cr>', desc = "Move Up (syntax)" },
		{ "vn", '<cmd>lua require("syntax-tree-surfer").select_current_node()<cr>', desc = "Select current node" },
		{ "vu", '<cmd>lua require("syntax-tree-surfer").move("n", true)<cr>', desc = "Move Down (syntax)" },
		{ "vx", '<cmd>lua require("syntax-tree-surfer").select()<cr>', desc = "Select block/line" },
	})

	wk.add({
		{
			mode = { "x" },
			{
				"<c-_>",
				':lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>',
				desc = "Comment line",
			},
			{ "H", '<cmd>lua require("syntax-tree-surfer").surf("parent", "visual")<cr>', desc = "Syntax Surfer prev" },
			{ "J", ":move '>+1<CR>gv-gv", desc = "Move line down" },
			{ "K", ":move '<-2<CR>gv-gv", desc = "Move line up" },
			{ "L", '<cmd>lua require("syntax-tree-surfer").surf("child", "visual")<cr>', desc = "Syntax surfer next" },
			{ "y", '"+y', desc = "Copy to OS buffer" },
		},
	})

	-- Ctrl key-maps
	wk.add({
		-- comments
		{ "<C-_>", ':lua require("Comment.api").toggle_current_linewise()<CR>', desc = "ctrl-/" },
		{ "<C-p>", util.telescope("find_files", { cwd = false }), desc = "find files (cwd)" },
		{ "<C-S-p>", "<cmd>Telescope commands<cr>", desc = "show command prompt" },
	})

	-- codewindow
	-- wk.add({
	-- 	{ "<leader>nm", "<cmd>lua require('codewindow').toggle_minimap()<cr>", desc = "Toggle scrollbar"},
	-- 	{ "<leader>nf", "<cmd>lua require('codewindow').toggle_focus()<cr>", desc = "Toggle scrollbar focus"},
	-- })

	-- Hop motions
	wk.add({
		{
			"<C-s>",
			function()
				require("hop").hint_words({})
			end,
			desc = "Jump words",
		},
		{
			"s",
			function()
				require("hop").hint_char2({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
			end,
			desc = "Hop 2 chars forward",
		},
		{
			"S",
			function()
				require("hop").hint_char2({ direction = require("hop.hint").HintDirection.BEFORE_CURSOr })
			end,
			desc = "Hop 2 chars backward",
		},
		{
			"f",
			function()
				require("hop").hint_char1({
					direction = require("hop.hint").HintDirection.AFTER_CURSOR,
					current_line_only = true,
				})
			end,
			desc = "Hop to char forward",
		},
		{
			"F",
			function()
				require("hop").hint_char1({
					direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
					current_line_only = true,
				})
			end,
			desc = "Hop to char backward",
		},
		{
			"t",
			function()
				require("hop").hint_char1({
					direction = require("hop.hint").HintDirection.AFTER_CURSOR,
					current_line_only = true,
					hint_offset = -1,
				})
			end,
			desc = "Hop to char forward (before char)",
		},
		{
			"T",
			function()
				require("hop").hint_char1({
					direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
					current_line_only = true,
					hint_offset = 1,
				})
			end,
			desc = "Hop to char backward (after char)",
		},
	})

	-- Terminal toggle
	wk.add({
		{
			"<F2>",
			'<C-\\><C-n><cmd>lua require("toggleterm").toggle()<CR>',
			desc = "Toggle floating terminal",
			mode = "t",
		},
	})
	wk.add({
		{ "<F2>", '<cmd>lua require("toggleterm").toggle()<CR>', desc = "Toggle floating terminal" },
		{
			"<F3>",
			function()
				local term = require("toggleterm.terminal").Terminal
				local lazygit = term:new({
					ft = "term_lazygit",
					cmd = "lazygit",
					direction = "float",
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							"n",
							"q",
							"<cmd>close<CR>",
							{ noremap = true, silent = true }
						)
					end,
					-- function to run on closing the terminal
					on_close = function(term)
						vim.cmd("startinsert!")
					end,
				})

				lazygit:toggle()
			end,
			desc = "Lazy git",
		},
		{
			"<F4>",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local btop = Terminal:new({
					ft = "term_btop",
					cmd = '[ -x "$(command -v btop)" ] && btop || htop',
					close_on_exit = true,
					direction = "float",
				})

				btop:toggle()
			end,
			desc = "Open htop",
		},
	})

	-- Window keybinds
	wk.add({
		{ "<C-h>", ":lua require('smart-splits').move_cursor_left()<CR>", desc = "Window left" },
		{ "<C-j>", ":lua require('smart-splits').move_cursor_down()<CR>", desc = "Window down" },
		{ "<C-k>", ":lua require('smart-splits').move_cursor_up()<CR>", desc = "Window up" },
		{ "<C-l>", ":lua require('smart-splits').move_cursor_right()<CR>", desc = "Window right" },
		{
			"<C-q>",
			function()
				Snacks.bufdelete.delete()
			end,
			desc = "Close buffer",
		},
		{ "<leader>wH", ":lua require('smart-splits').start_resize_mode()<CR>", desc = "start resize mode" },
		{ "<leader>wJ", ":lua require('smart-splits').start_resize_mode()<CR>", desc = "start resize mode" },
		{ "<leader>wK", ":lua require('smart-splits').start_resize_mode()<CR>", desc = "start resize mode" },
		{ "<leader>wL", ":lua require('smart-splits').start_resize_mode()<CR>", desc = "start resize mode" },
		{ "<C-w>z", ":lua require('windows.commands').maximize()<CR>", desc = "maximize windows" },
		{ "<C-w>=", ":lua require('windows.commands').equalize()<CR>", desc = "equalize windows" },
	})

	-- Buffer
	wk.add({
		{ "<leader>b", group = "Buffers" },
		{
			"<leader>bb",
			-- "<cmd>Telescope buffers<CR>",
			":lua require('neo-tree.command').execute({action = 'focus', source = 'buffers', reveal = true, position = 'float', toggle = true})<CR>",
			desc = "List Buffer",
		},
		{ "<leader>bq", "<cmd>BufDel<CR>", desc = "Close Buffer" },
		{ "<leader>bn", "<cmd>tabnew<CR>", desc = "New buffer" },
		{ "<leader>bp", "<cmd>e #<CR>", desc = "Buffer Previous" },
	})

	-- Telescope keybinds
	wk.add({
		{ "<leader>f", group = "Telescope" },
		{ "<leader>fF", util.telescope("files"), desc = "find files (root dir)" },
		{ "<leader>ff", util.telescope("find_files", { cwd = false }), desc = "find files (cwd)" },
		{ "<leader>fG", util.telescope("live_grep", { grep_open_files = true }), desc = "grep open files" },
		{
			"<leader>fg",
			util.telescope("live_grep", { cwd = false }),
			desc = "grep files (cwd)",
		},
		{ "<leader>fW", util.telescope("grep_string"), desc = "search word (root dir)" },
		{ "<leader>fw", util.telescope("grep_string", { cwd = false }), desc = "search word (cwd)" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "list buffers" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "show recently opened files" },
		{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "show jumplist" },
		{ "<leader>fh", "<cmd>Telescope harpoon marks<cr>", desc = "show harpoon" },
		{ "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "show vim help" },
		{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "show marks" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "show keymaps" },
		{ "<leader>fO", "<cmd>Telescope vim_options<cr>", desc = "show vim opts" },
		{ "<leader>fr", "<cmd>Telescope registers<cr>", desc = "show copy registers" },
		{ "<leader>fs", "<cmd>Telescope possession only_cwd=true<cr>", desc = "show sessions" },
		{ "<leader>fS", "<cmd>Telescope spell_suggest<cr>", desc = "show spell suggest" },
		{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "search in file" },
		{ "<leader>f?", "<cmd>Telescope search_history<cr>", desc = "search history" },
		{ "<leader>fC", "<cmd>Telescope command_history<cr>", desc = "show command-line history" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "show command prompt" },
		{ "<leader>fx", util.telescope("colorscheme", { enable_preview = true }), desc = "show colorscheme picker" },
		{ "<leader>fu", "<cmd>silent! %foldopen! | UndotreeToggle<cr>", desc = "show undotree" },
		{ "<leader>fds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "show doc symbols" },
		{ "<leader>fdS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "show workspace symbols" },
		{ "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "show treesitter" },
	})

	-- GitSigns
	wk.add({
		{ "<leader>ga", group = "GitSigns" },
		{
			"<leader>gaJ",
			function()
				local gitsigns = require("gitsigns")
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gitsigns.next_hunk()
				end)
				return "<Ignore>"
			end,
			desc = "next hunk",
		},
		{
			"<leader>gaK",
			function()
				local gitsigns = require("gitsigns")
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gitsigns.prev_hunk()
				end)
				return "<Ignore>"
			end,
			desc = "prev hunk",
		},
		{ "<leader>gas", ":Gitsigns stage_hunk<CR>", desc = "Stage hunk" },
		{ "<leader>gau", ":Gitsigns undo_stage_hunk<CR>", desc = "Undo stage" },
		{ "<leader>gaS", ":Gitsigns stage_buffer<CR>", desc = "Stage all file" },
		{ "<leader>gap", ":Gitsigns preview_hunk<CR>", desc = "Preview changes" },
		{ "<leader>gad", ":Gitsigns toggle_deleted<CR>", desc = "Show deleted" },
		{ "<leader>gab", ":Gitsigns blame_line<CR>", desc = "Blame line" },
		{
			"<leader>gaB",
			function()
				local gitsigns = require("gitsigns")
				gitsigns.blame_line({ full = true })
			end,
			desc = "Blame line",
		},
		{ "<leader>ga/", ":Gitsigns show<cr>", desc = "show the base of the file" },
		{
			"<leader>ga<Enter>",
			function()
				local fterm = require("FTerm")
				local lazygit = fterm:new({
					ft = "fterm_lazygit",
					cmd = "lazygit",
				})

				lazygit:toggle()
			end,
			desc = "Show lazygit",
		},
	})

	-- Leader key-maps
	wk.add({
		{
			"<leader>ck",
			function()
				local nullls = require("null-ls")
				local spell = vim.o.spell
				if spell then
					nullls.disable({ "cspell", "codespell" })
					vim.o.spell = false
				else
					nullls.enable({ "cspell", "codespell" })
					vim.o.spell = true
				end
			end,
			desc = "Toggle spell check",
		},

		{ "<leader>e", group = "NeoTree" },
		{
			"<leader>eb",
			":lua require('neo-tree.command').execute({action = 'focus', source = 'buffers', reveal = true, position = 'float', toggle = true})<CR>",
			desc = "Buffers tree",
		},
		{
			"<leader>ec",
			":lua require('neo-tree.command').execute({action = 'close'})<CR>",
			desc = "Close all neo-tree",
		},
		{ "<leader>ed", ":DBUIToggle<CR>", desc = "Open DBUI" },
		{
			"<leader>ee",
			":lua require('neo-tree.command').execute({action = 'focus', source = 'filesystem', reveal = true, position = 'float', toggle = true})<CR>",
			desc = "File tree",
		},
		{
			"<leader>eg",
			":lua require('neo-tree.command').execute({action = 'show', source = 'git_status', reveal = true, position = 'bottom', toggle = true})<CR>",
			desc = "Git Status",
		},
		{ "<leader>et", ":lua require('toggleterm').toggle()<CR>", desc = "Terminal" },
		{
			"<leader>ex",
			":lua require('neo-tree.command').execute({action = 'focus', source = 'diagnostics', reveal = true, position = 'bottom', toggle = true})<CR>",
			desc = "LSP/Diag",
		},

		{ "<leader>g", group = "Git" },
		{ "<leader>gb", ":Telescope git_branches<CR>", desc = "git branches" },
		{ "<leader>gc", ":Telescope git_commits<CR>", desc = "git commits" },
		{ "<leader>gf", ":Telescope git_files<CR>", desc = "git files" },
		{
			"<leader>gg",
			function()
				local term = require("toggleterm.terminal").Terminal
				local lazygit = term:new({
					ft = "term_lazygit",
					cmd = "lazygit",
					direction = "float",
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							"n",
							"q",
							"<cmd>close<CR>",
							{ noremap = true, silent = true }
						)
					end,
					-- function to run on closing the terminal
					on_close = function(term)
						vim.cmd("startinsert!")
					end,
				})

				lazygit:toggle()
			end,
			desc = "Lazy git",
		},
		{ "<leader>gs", ":Telescope git_status<CR>", desc = "git status" },

		{ "<leader>h", group = "Git signs" },
		{ "<leader>hD", desc = "Diff this -" },
		{ "<leader>hR", desc = "Reset buffer" },
		{ "<leader>hS", desc = "Stage buffer" },
		{ "<leader>hd", desc = "Diff this" },
		{ "<leader>hp", desc = "Preview hunk" },
		{ "<leader>hr", desc = "Reset hunk" },
		{ "<leader>hs", desc = "Stage hunk" },
		{ "<leader>hu", desc = "Undo stage hunk" },

		{
			"<leader>i",
			':lua require("portal.builtin").jumplist.tunnel({direction = "forward"})<CR>',
			desc = "Portal Forward",
		},
		{ "<leader>nd", ":lua require('noice').cmd('dismiss')<cr>", desc = "Dismiss notifications" },
		{ "<leader>nh", ":lua require('noice').cmd('telescope')<cr>", desc = "History notifications" },
		{ "<leader>nl", ":lua require('noice').cmd('last')<cr>", desc = "Last notifications" },
		{
			"<leader>o",
			':lua require("portal.builtin").jumplist.tunnel({direction = "backward"})<CR>',
			desc = "Portal Back",
		},
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

		{ "<leader>sh", ":lua require'focus'.split_command('h')<CR>", desc = "Focus Left" },
		{ "<leader>si", ":setlocal foldmethod=indent<CR>", desc = "Fold Indent/Whitespace" },
		{ "<leader>sj", ":lua require'focus'.split_command('j')<CR>", desc = "Focus Down" },
		{ "<leader>sk", ":lua require'focus'.split_command('k')<CR>", desc = "Focus Up" },
		{ "<leader>sl", ":lua require'focus'.split_command('l')<CR>", desc = "Focus Right" },
		{ "<leader>sp", ":lua require('spectre').open()<cr>", desc = "Spectre open" },
		{ "<leader>ss", ":setlocal foldmethod=expr<CR>", desc = "Fold Expression/Syntax" },
		{ "<leader>sr", ":PossessionLoad<CR>", desc = "Restore Session" },
		{ "<leader>sv", ":PossessionSaveGit<cr>", desc = "Save Session (per branch)" },
		{ "<leader>sw", ":lua require('spectre').open_visual()<cr>", desc = "Spectre open visual" },

		{ "<leader>td", desc = "Toggle deleted (git signs)" },
		{ "<leader>u", ":UndotreeToggle<CR>", desc = "undo tree" },
		{ "<leader>pp", '"0p', desc = "Paste from yank register", mode = { "n", "x" } },
	})

	wk.add({
		{ "<leader>m", group = "Code Companion" },
		{ "<leader>mc", "<cmd>CodeCompanionToggle<cr>", desc = "Toggle Code Companion" },
		{ "<leader>ma", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions prompt" },
	})

	wk.add({
		{ "<leader>p", group = "Precognition Virtual Text" },
		{
			"<leader>pt",
			function()
				if require("precognition").toggle() then
					vim.notify("Precognition helper on")
				else
					vim.notify("Precognition helper off")
				end
			end,
			desc = "Precognition Toggle",
		},
	})

	wk.add({
		{ "<leader>c", group = "MultiCursor" },
		{
			"<leader>ca",
			function()
				require("multicursor-nvim").alignCursors()
			end,
			desc = "Align cursors",
			mode = "n",
		},
		{
			"<leader>cA",
			function()
				require("multicursor-nvim").matchAllAddCursors()
			end,
			desc = "Match all",
		},
		{
			"<c-leftmouse>",
			function()
				require("multicursor-nvim").handleMouse()
			end,
			desc = "MultiCursor left-click",
		},
		{
			"<C-n>",
			function()
				require("multicursor-nvim").matchAddCursor(1)
			end,
			desc = "Match next cursor",
			mode = { "n", "v" },
		},
		{
			"<C-S-N>",
			function()
				require("multicursor-nvim").matchAddCursor(-1)
			end,
			desc = "Match prev cursor",
			mode = { "n", "v" },
		},
		{
			"<esc>",
			function()
				local mc = require("multicursor-nvim")
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				else
					-- Default <esc> handler.
				end
			end,
			desc = "Esc",
		},
	})

	wk.add({
		{ "<leader>/", group = "Search" },
		{
			"<leader>//",
			function()
				require("kaleidosearch").prompt_and_search()
			end,
			desc = "Search word",
			mode = "n",
		},
		{
			"<leader>/n",
			function()
				require("kaleidosearch").prompt_and_search()
			end,
			desc = "Search word",
			mode = "n",
		},
		{
			"<leader>/*",
			function()
				require("kaleidosearch").add_word_under_cursor()
			end,
			desc = "Search word under cursor",
			mode = "n",
		},
		{
			"<leader>/c",
			function()
				require("kaleidosearch").clear_all_highlights()
				vim.api.nvim_command("set hlsearch")
				vim.api.nvim_command("nohl")
			end,
			desc = "Clear search",
			mode = "n",
		},
	})

	-- Harpoon + Portal
	wk.add({
		{ "<leader>'", group = "Harpoon+Portal" },
		{
			"<leader>'D",
			function()
				require("harpoon"):list():clear()
			end,
			desc = "Clear list",
		},
		{
			"<leader>'m",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add file",
		},
		{
			"<leader>'n",
			function()
				require("harpoon"):list():remove()
			end,
			desc = "Remove file",
		},
		{
			"<leader>''",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Quick menu",
		},
		{
			"<leader>'l",
			function()
				local harpoon = require("harpoon")
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end,
			desc = "Quick menu",
		},
		{
			"<leader>'c",
			':lua require("portal.builtin").changelist.tunnel({direction = "backward"})<CR>',
			desc = "Portal Changelist",
		},
		{
			"<leader>'C",
			':lua require("portal.builtin").changelist.tunnel({direction = "forward"})<CR>',
			desc = "Portal Changelist",
		},
		{
			"<C-i>",
			':lua require("portal.builtin").jumplist.tunnel({direction = "forward"})<CR>',
			desc = "Portal Forward",
		},
		{
			"<C-o>",
			':lua require("portal.builtin").jumplist.tunnel({direction = "backward"})<CR>',
			desc = "Portal Back",
		},
		--[[ {
			"<leader>'i",
			':lua require("portal.builtin").jumplist.tunnel({direction = "forward"})<CR>',
			desc = "Portal Forward",
		},
		{
			"<leader>'o",
			':lua require("portal.builtin").jumplist.tunnel({direction = "backward"})<CR>',
			desc = "Portal Back",
		}, ]]
		{ "<leader>'q", ':lua require("portal.builtin").quickfix.tunnel({})<CR>', desc = "Portal Quickfix" },
		{
			"<C-Space>",
			function()
				require("snipe").open_buffer_menu()
			end,
			desc = "Open Snipe buffer menu",
		},
	})
	for c = 1, 5 do
		print(c)
		wk.add({
			{
				"<C-" .. c .. ">",
				function()
					require("harpoon"):list():select(c)
				end,
				desc = "Harpoon " .. c,
			},
		})
	end
end

--[[ -- Prevent delete/cut/change to overwrite paste if empty/blank
local function smart_delete(key)
	local l = vim.api.nvim_win_get_cursor(0)[1] -- Get the current cursor line number
	local line = vim.api.nvim_buf_get_lines(0, l - 1, l, true)[1] -- Get the content of the current line
	return (line:match("^%s*$") and '"_' or "") .. key -- If the line is empty or contains only whitespace, use the black hole register
end
local keys = { "d", "dd", "x", "c", "s", "C", "S", "X" } -- Define a list of keys to apply the smart delete functionality

-- Set keymaps for both normal and visual modes
for _, key in pairs(keys) do
	vim.keymap.set({ "n", "v" }, key, function()
		return smart_delete(key)
	end, { noremap = true, expr = true, desc = "Smart delete" })
end ]]

return M
