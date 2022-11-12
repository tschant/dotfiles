local wk = require("which-key")
require('legendary').setup({
	which_key = {
		auto_register = true
	}
})

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

wk.register({
	["<ESC>"] = {"<C-\\><C-n>", ""},
}, {mode = "t"})

-- LSP Based key-maps
wk.register({
	g = {
		-- LSP
		D = {":lua vim.lsp.buf.declaration()<CR>", "Declarations"},
		d = {":Telescope lsp_definitions<CR>", "Definitions"},
		t = {":lua vim.lsp.buf.type_definition()<CR>", "Type Defs"},
		r = {":Telescope lsp_references<CR>", "References"},
		h = {":lua vim.lsp.buf.hover()<CR>", "Hover details"},
		I = {":lua vim.lsp.buf.implementation()<CR>", "Implementation"},
		rn = {":lua vim.lsp.buf.rename()<CR>", "Rename"},
		p = {":lua vim.diagnostic.goto_prev()<CR>", "Goto Next"}, 
		P = {":lua vim.diagnostic.goto_next()<CR>", "Goto Prev"}, 
		-- Syntax Tree Surfer - treesitter smart selection
		v  = {":lua require('syntax-tree-surfer').targeted_jump({'variable_declaration'})<CR>", "Jump Var declaration"},
		fu = {":lua require('syntax-tree-surfer').targeted_jump({'function'})<CR>", "Jump Funct declaration"},
		i = {f = {":lua require('syntax-tree-surfer').targeted_jump({'if_statement'})<CR>", "Jump If"}},
		j  = {":lua require('syntax-tree-surfer').targeted_jump({'function', 'if_statement', 'else_clause', 'else_statement', 'elseif_statement', 'for_statement', 'while_statement', 'switch_statement'})<CR>", "Jump ALL"},
		n  = {":lua require('syntax-tree-surfer').filtered_jump('default', true)<CR>", "Filter Jump Next"},
		N  = {":lua require('syntax-tree-surfer').filtered_jump('default', false)<CR>", "Filter Jump Prev"},
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
	-- Better window navigation
	["h>"] = {"<C-w>h", "Window left"},
	["j>"] = {"<C-w>j", "Window down"},
	["k>"] = {"<C-w>k", "Window up"},
	["l>"] = {"<C-w>l", 'Window right'},
	-- buffer navigation BarBar
	["q>"] = {":BufferClose<CR>", 'Close buffer'},
	-- Comment
	['_>'] = {':lua require("Comment.api").toggle_current_linewise()<CR>', "ctrl-/"},
	['p>'] = {require('legendary').find, 'Search keybinds and commands'}
}, {prefix = "<C-", mode = "n"})

-- Leader key-maps
wk.register({
-- u.map("n", "<leader>sv", ":source $MYVIMRC<CR>")
	q = {":BufferClose<CR>", "Close buffer"},
	cc = {
		":let @+=expand('%')<CR>", "Copy file path from PWD"
	},
	s = {
		name = "Fold Method",
		i = {":setlocal foldmethod=indent<CR>", "Indent"},
		s = {":setlocal foldmethod=expr<CR>", "Expression/Syntax"},
	},
	V = {":vs<CR>", "Vertical Split"},
	H = {":sp<CR>", "Horizontal Split"},
	w = {":update<CR>", "Save file"},
	-- Portal
	o = {':lua require("portal").jump_backward()<CR>', "Portal Back"},
	i = {':lua require("portal").jump_forward()<CR>', "Portal Forward"},
	m = {':lua require("portal.tag").toggle()<CR>', "Portal toggle"},

	-- h = { ":FocusSplitLeft<CR>", "Focus Left"},
	-- j = { ":FocusSplitDown<CR>", "Focus Down"},
	k = { ":FocusSplitUp<CR>", "Focus Up"},
	l = { ":FocusSplitRight<CR>", "Focus Right"},
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
	e = {":Neotree filesystem reveal left toggle=true<CR>", "File tree"},
	gs = {":Neotree git_status reveal bottom toggle=true<CR>", "Git status"},
	xx = {":Neotree diagnostics reveal bottom toggle=true<cr>", "LSP/Diag"},
	-- Session + Dashboard
	["<Home>"] = {":Dashboard<cr>", "Dashboard"},
	nn = {":DashboardNewFile<cr>", "New file dashboard"},
	sv = {":SaveSession<cr>", "Save Session"},
	sr = {":RestoreSession<cr>", "Restore Session"},
	-- 
	c = {
		k = {":set spell!<cr>", "Toggle spell check"},
		m = {":Neoformat<cr>", "Format file"},
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


