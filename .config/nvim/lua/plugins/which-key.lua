local M = {
	"folke/which-key.nvim",
	dependencies = {"mrjones2014/legendary.nvim"},
	-- event = "VimEnter",
	event = "VeryLazy",
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
			group = "+", -- symbol prepended to a group
		},
		hidden = {
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
		},
	})
	require('legendary').setup({
		which_key = {
			auto_register = true
		},
	})
	--
	-- Random key-maps
	wk.register({
		Q = {"<Nop>", "no-op"},
		n = {"nzz", "Next + center"},
		N = {"Nzz", "Prev + center"},
		["<CR>"] = {"<CR>", "<CR>"},
		["<TAB>"] = {":BufferNext<CR>", "Next buffer"},
		["<S-TAB>"] = {":BufferPrev<CR>", "Prev buffer"},
		['<f10>'] = {[[<Cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>]], "Output the current syntax/highlight group"},
		["<M-Up>"] = {":call vm#commands#add_cursor_up(0, v:count1)<cr>", "Select next line up (vm)"},
		["<M-Down>"] = {":call vm#commands#add_cursor_down(0, v:count1)<cr>", "Select next line down (vm)"},
	}, {mode = "n"})

	wk.register({
		jk = {"<esc>", "Escape insert mode"},
	}, {mode = "i"})

	-- LSP Based key-maps
	wk.register({
		g = {
			-- LSP
			D  = {":lua vim.lsp.buf.declaration()<CR>", "Declarations"},
			d  = {":Telescope lsp_definitions<CR>", "Definitions"},
			t  = {":lua vim.lsp.buf.type_definition()<CR>", "Type Defs"},
			r  = {":Telescope lsp_references<CR>", "References"},
			h  = {":lua vim.lsp.buf.hover()<CR>", "Hover details"},
			I  = {":lua vim.lsp.buf.implementation()<CR>", "Implementation"},
			rn = {":lua vim.lsp.buf.rename()<CR>", "Rename"},
			p  = {":lua vim.diagnostic.goto_prev()<CR>", "Goto Next"},
			P  = {":lua vim.diagnostic.goto_next()<CR>", "Goto Prev"},
			-- Syntax Tree Surfer - treesitter smart selection
			v  = {":lua require('syntax-tree-surfer').targeted_jump({'variable_declaration'})<CR>", "Jump Var declaration"},
			fu = {":lua require('syntax-tree-surfer').targeted_jump({'function'})<CR>", "Jump Funct declaration"},
			i  = {f = {":lua require('syntax-tree-surfer').targeted_jump({'if_statement'})<CR>", "Jump If"}},
			j  = {":lua require('syntax-tree-surfer').targeted_jump({'function', 'if_statement', 'else_clause', 'else_statement', 'elseif_statement', 'for_statement', 'while_statement', 'switch_statement'})<CR>", "Jump ALL"},
			n  = {":lua require('syntax-tree-surfer').filtered_jump('default', true)<CR>", "Filter Jump Next"},
			N  = {":lua require('syntax-tree-surfer').filtered_jump('default', false)<CR>", "Filter Jump Prev"},
			K  = {":lua require('ts-node-action').node_action()<CR>", "Trigger node action"}
		},
		v = {
			d = {'<cmd>lua require("syntax-tree-surfer").move("n", false)<cr>', "Move Up (syntax)"},
			u = {'<cmd>lua require("syntax-tree-surfer").move("n", true)<cr>', "Move Down (syntax)"},
			-- .select() will show you what you will be swapping with .move(), you'll get used to .select() and .move() behavior quite soon!
			x = {'<cmd>lua require("syntax-tree-surfer").select()<cr>', "Select block/line"},
			-- .select_current_node() will select the current node at your cursor
			n = {'<cmd>lua require("syntax-tree-surfer").select_current_node()<cr>', "Select current node"},
		}
	}, {mode = "n"})

	wk.register({
		K = {":move '<-2<CR>gv-gv", "Move line up"},
		J = {":move '>+1<CR>gv-gv", "Move line down"},
		y = {"\"+y", "Copy to OS buffer"},
		H = {'<cmd>lua require("syntax-tree-surfer").surf("parent", "visual")<cr>', "Syntax Surfer prev"},
		L = {'<cmd>lua require("syntax-tree-surfer").surf("child", "visual")<cr>', "Syntax surfer next"},
		['<c-_>'] = {':lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', 'Comment line'},
	}, {mode = "x"})

	-- Ctrl key-maps
	wk.register({
		-- Comment
		['_>'] = {':lua require("Comment.api").toggle_current_linewise()<CR>', "ctrl-/"},
		['p>'] = {":lua require('legendary').find()<cr>", 'Search keybinds and commands'}
	}, {prefix = "<C-", mode = "n"})

	-- Window keybinds
	wk.register({
		-- buffer navigation BarBar
		["<C-q>"] = {":BufferClose<CR>", 'Close buffer'},
		-- Better window navigation
		["<C-h>"] = {"<C-w>h", "Window left"},
		["<C-j>"] = {"<C-w>j", "Window down"},
		["<C-k>"] = {"<C-w>k", "Window up"},
		["<C-l>"] = {"<C-w>l", 'Window right'},
		["<C-w>H"] = {"<C-w>3<", "Resize window left"},
		["<C-w>L"] = {"<C-w>3>", "Resize window right"},
		["<C-w>K"] = {"<C-w>2+", "Resize window up"},
		["<C-w>J"] = {"<C-w>2-", "Resize window down"},
		["<C-w>e"] = {"<C-w>=", "Equal window sizes"},
		["<C-w><CR>"] = {":FocusMaxOrEqual<CR>"},
		["<C-w>Q"] = {":q<cr>" },
		["<C-w><C-q>"] = {":q<cr>" },
	})

	-- Buffer
	wk.register({
		d =  {'<cmd>BufferClose<CR>' },
		ca = {'<cmd>BufferCloseAllButCurrentOrPinned<CR>' },
		cl = {'<cmd>BufferCloseBuffersLeft<CR>' },
		cr = {'<cmd>BufferCloseBuffersRight<CR>' },
		b =  {'<cmd>Telescope buffers<CR>' },
		pp = {'<cmd>BufferPin<CR>' },
		n =  {'<cmd>tabnew<CR>' },
		k =  {'<cmd>BufferFirst<CR>' },
		j =  {'<cmd>BufferLast<CR>' },
		h =  {'<cmd>BufferMovePrevious<CR>' },
		l =  {'<cmd>BufferMoveNext<CR>' },
		od = {'<cmd>BufferOrderByDirectory<CR>',    'by directory' },
		on = {'<cmd>BufferOrderByBufferNumber<CR>', 'by buffer number' },
		ow = {'<cmd>BufferOrderByWindowNumber<CR>', 'by window number' },
		['1'] =  {'<cmd>BufferGoto 1<CR>', 'goto buffer 1' },
		['2'] =  {'<cmd>BufferGoto 2<CR>', 'goto buffer 2' },
		['3'] =  {'<cmd>BufferGoto 3<CR>', 'goto buffer 3' },
		['4'] =  {'<cmd>BufferGoto 4<CR>', 'goto buffer 4' },
		['5'] =  {'<cmd>BufferGoto 5<CR>', 'goto buffer 5' },
		['6'] =  {'<cmd>BufferGoto 6<CR>', 'goto buffer 6' },
		['7'] =  {'<cmd>BufferGoto 7<CR>', 'goto buffer 7' },
		['8'] =  {'<cmd>BufferGoto 8<CR>', 'goto buffer 8' },
		['9'] =  {'<cmd>BufferGoto 9<CR>', 'goto buffer 9' },
	}, {prefix = "<leader>b"})

	-- Telescope keybinds
	wk.register({
		f = {'<cmd>Telescope find_files<cr>' },
		g = {'<cmd>Telescope live_grep<cr>' },
		o = {'<cmd>Telescope oldfiles<cr>','recently opened files' },
		h = {'<cmd>Telescope help_tags<cr>', 'vim help' },
		b = {'<cmd>Telescope buffers<cr>' },
		m = {'<cmd>Telescope marks<cr>', 'marks' },
		k = {'<cmd>Telescope keymaps<cr>' },
		O = {'<cmd>Telescope vim_options<cr>' },
		r = {'<cmd>Telescope registers<cr>' },
		s = {'<cmd>Telescope session-lens search_session<cr>', 'sessions' },
		['/'] = {'<cmd>Telescope current_buffer_fuzzy_find<cr>', 'search in file' },
		['?'] = {'<cmd>Telescope search_history<cr>',  'search history' },
		[';'] = {'<cmd>Telescope command_history<cr>', 'command-line history' },
		c = {'<cmd>Telescope spell_suggest<cr>', 'spell suggest' },
		x = {'<cmd>Telescope colorscheme<cr>', 'choose colorscheme' },
		u = {'<cmd>silent! %foldopen! | UndotreeToggle<cr>', 'undotree' },
	}, {prefix = '<leader>f'})

	-- GitSigns 
	wk.register({
		J = {
			function()
				local gitsigns = require('gitsigns')
				if vim.wo.diff then return ']c' end
				vim.schedule(function() gitsigns.next_hunk() end)
				return '<Ignore>'
			end,
			"next hunk"
		},
		K = {
			function()
				local gitsigns = require('gitsigns')
				if vim.wo.diff then return '[c' end
				vim.schedule(function() gitsigns.prev_hunk() end)
				return '<Ignore>'
			end,
			"prev hunk"
		},
		s = {':Gitsigns stage_hunk<CR>', 'Stage hunk'},
		u = {':Gitsigns undo_stage_hunk<CR>', 'Undo stage' },
		S = {':Gitsigns stage_buffer<CR>', 'Stage all file' },
		p = {':Gitsigns preview_hunk<CR>', 'Preview changes' },
		d = {':Gitsigns toggle_deleted<CR>', 'Show deleted' },
		b = {':Gitsigns blame_line<CR>', 'Blame line' },
		B = {
			function()
				local gitsigns = require('gitsigns')
				gitsigns.blame_line{ full = true }
			end,
			"Blame line"
		},
		['/'] = {':Gitsigns show<cr>', "show the base of the file"},
		['<Enter>'] = {':FloatermNew lazygit<CR>', "Show lazygit"},
	}, {prefix = '<leader>ga'})

	-- Leader key-maps
	wk.register({
		 -- u.map("n", "<leader>sv", ":source $MYVIMRC<CR>")
		q = {":BufferClose<CR>", "Close buffer"},
		cc = {
			":let @+=expand('%')<CR>", "Copy file path from PWD"
		},
		s = {
			i = {":setlocal foldmethod=indent<CR>", "Fold Indent/Whitespace"},
			s = {":setlocal foldmethod=expr<CR>", "Fold Expression/Syntax"},
			v = {":SaveSession<cr>", "Save Session"},
			r = {":RestoreSession<cr>", "Restore Session"},
			p = {":AddWorkspace<cr>", "Add Project Workspace"},
			
			h = { ":lua require'focus'.split_command('h')<CR>", "Focus Left"},
			j = { ":lua require'focus'.split_command('j')<CR>", "Focus Down"},
			k = { ":lua require'focus'.split_command('k')<CR>", "Focus Up"},
			l = { ":lua require'focus'.split_command('l')<CR>", "Focus Right"},
		},
		V = {":vs<CR>", "Vertical Split"},
		H = {":sp<CR>", "Horizontal Split"},
		w = {":update<CR>", "Save file"},
		-- Portal
		o = {':lua require("portal").jump_backward()<CR>', "Portal Back"},
		i = {':lua require("portal").jump_forward()<CR>', "Portal Forward"},
		m = {':lua require("portal.tag").toggle()<CR>', "Portal toggle"},

		-- wiki notes
		wn = {":FloatermNew nvim +VimwikiIndex .<CR>", "Open wiki notes"},
		-- Undo tree
		u = {":UndotreeToggle<CR>", "undo tree"},
		-- lazygit
		g = {
			g = {":FloatermNew lazygit<CR>", "Lazy git"},
			-- f = {":Telescope git_files<CR>"},
			-- c = {":Telescope git_commits<CR>"},
			-- b = {":Telescope git_branches<CR>"},
		},
		-- Neotree
		e = {":lua require('neo-tree.command').execute({action = 'focus', source = 'filesystem', reveal =true, position = 'left', toggle = true})<CR>", "File tree"},
		gs = {":lua require('neo-tree.command').execute({action = 'focus', source = 'git_status', reveal =true, position = 'bottom', toggle = true})<CR>", "Git status"},
		xx = {":lua require('neo-tree.command').execute({action = 'focus', source = 'diagnostics', reveal =true, position = 'bottom', toggle = true})<CR>", "LSP/Diag"},
		-- Session + Dashboard
		["<Home>"] = {":Dashboard<cr>", "Dashboard"},
		nn = {":DashboardNewFile<cr>", "New file dashboard"},
		-- 
		c = {
			k = {":set spell!<cr>", "Toggle spell check"},
			m = {":lua vim.lsp.buf.format()<cr>", "Format file"},
		},
		-- Git signs
		h = {
			name = "Git signs",
			s = {"Stage hunk"},
			r = {"Reset hunk"},
			S = {"Stage buffer"},
			u = {"Undo stage hunk"},
			R = {"Reset buffer"},
			p = {"Preview hunk"},
			d = {"Diff this"},
			D = {"Diff this -"},
		},
		td = {"Toggle deleted (git signs)"},
	}, { prefix = "<leader>" })



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


end

return M
