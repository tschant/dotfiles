local u = require("utils.core")

local autocmds = {
	filetypes = {
		{"BufNewFile,BufRead", "*.ejs", "set filetype=html"},
		{"FileType", "markdown", "setlocal wrap"},
		{"FileType", "markdown", "setlocal spell"},
		{"FileType", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"},
		{"FileType", "toggleterm", "setlocal nonumber norelativenumber"},
		{"FileType", "sql,mysql,plsql", "lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })"},
	},
	-- cursor = {
	-- 	{"CursorHold", "*", "lua vim.diagnostic.open_float(0, {scope=line, focusable = false})"},
	-- 	{"CursorHoldI", "*", "silent! lua vim.lsp.buf.signature_help({focusable = false})"}
	-- },
	packer_user_config = {
		{"BufWritePost", "plugins.lua", "source <afile> | PackerSync"}
	}
}

local hl_yank = {
	{"TextYankPost", "*", 'lua require"vim.highlight".on_yank()'}
}

local jump_last = {
	{"BufReadPost", "*", [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]}
}

local format = {
	{
		"BufWritePre",
		"*",
		[[try | undojoin | Neoformat | catch /^Vim\%((\a\+)\)\=:E790/ | finally | silent Neoformat | endtry]]
	}
}

local trim_whitespaces = {
	{"BufWritePre", "*", [[%s/\s\+$//e]]},
	{"BufWritePre", "*", [[%s/\n\+\%$//e]]}
}

-- insert tables if true or nil
if Opts.jump_last_pos == true or Opts.jump_last_pos == nil then
	table.insert(autocmds, jump_last)
end

if Opts.highlight_yank == true or Opts.highlight_yank == nil then
	table.insert(autocmds, hl_yank)
end

if Formatting.format_on_save == true or Formatting.format_on_save == nil then
	table.insert(autocmds, format)
end

if Formatting.trim_trailing_space == true or Formatting.trim_trailing_space == nil then
	table.insert(autocmds, trim_whitespaces)
end

u.define_augroups(autocmds)
