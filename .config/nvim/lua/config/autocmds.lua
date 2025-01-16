local u = require("utils.core")
local extra = require("utils.extra")

local autocmds = {
	["filetypes"] = {
		{ { "BufNewFile", "BufRead" }, "*.ejs", "set filetype=html" },
		{ "FileType", "markdown", "setlocal wrap" },
		{ "FileType", "markdown", "setlocal spell" },
		{ "FileType", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
		{ "FileType", "toggleterm", "setlocal nonumber norelativenumber" },
		{
			"FileType",
			"sql,mysql,plsql",
			"lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })",
		},
	},
	-- cursor = {
	-- 	{"CursorHold", "*", "lua vim.diagnostic.open_float(0, {scope=line, focusable = false})"},
	-- 	{"CursorHoldI", "*", "silent! lua vim.lsp.buf.signature_help({focusable = false})"}
	-- },
	["packer_user_config"] = {
		{ "BufWritePost", "plugins.lua", "source <afile> | PackerSync" },
	},
}

local hl_yank = { { "TextYankPost", "*", 'lua require"vim.highlight".on_yank()' } }

local jump_last = {
	{ "BufReadPost", "*", [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]] },
}

local format = {
	{
		"BufWritePre",
		"*",
		function(args)
			require("conform").format({ bufnr = args.buf, async = true, lsp_fallback = true })
		end,
	},
}

local trim_whitespaces = {
	{ "BufWritePre", "*", [[%s/\s\+$//e]] },
	{ "BufWritePre", "*", [[%s/\n\+\%$//e]] },
}

-- insert tables if true or nil
if Opts.jump_last_pos == true or Opts.jump_last_pos == nil then
	autocmds["jump_last"] = jump_last
end

if Opts.highlight_yank == true or Opts.highlight_yank == nil then
	autocmds["hl_yank"] = hl_yank
end

if
	Formatting.format_on_save == true
	or Formatting.format_on_save == nil
	or extra.is_array(Formatting.format_on_save)
then
	if extra.is_array(Formatting.format_on_save) then
		-- Format on save only for certain files defined in `lua/config/defaults.lua`
		autocmds["format"] = {}
		for _, v in ipairs(Formatting.format_on_save) do
			local newFormat = extra.table_shallow_copy(format[1])
			newFormat[2] = newFormat[2] .. "." .. v
			table.insert(autocmds["format"], newFormat)
		end
	else
		autocmds["format"] = format
	end
end

if Formatting.trim_trailing_space == true or Formatting.trim_trailing_space == nil then
	autocmds["trim_whitespaces"] = trim_whitespaces
end

u.define_augroups(autocmds)
