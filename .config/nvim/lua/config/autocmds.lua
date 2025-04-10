-- Opts is defined in `lua/config/defaults.lua`
local u = require("utils.core")
local extra = require("utils.extra")

local autocmds = {
	["filetypes"] = {
		{ { "BufNewFile", "BufRead" }, "*.ejs", "set filetype=html" },
		{ "FileType", "markdown", "setlocal wrap" },
		{ "FileType", "markdown", "setlocal spell" },
		{ "FileType", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o" },
		{ "FileType", "toggleterm", "setlocal nonumber norelativenumber" },
	},
}

local cursor_hold = { { "CursorHold", "*", "lua vim.diagnostic.open_float(0, {scope=line, focusable = false})" } }

local hl_yank = { { "TextYankPost", "*", 'lua vim.highlight.on_yank()' } }

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

if Opts.cursor_hold == true then
	autocmds["cursor_hold"] = cursor_hold
end

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
		local newFormat = extra.table_shallow_copy(format[1])
		newFormat[2] = {}
		for _, v in ipairs(Formatting.format_on_save) do
			table.insert(newFormat[2], "*." .. v)
		end

		format = { newFormat }
	end

	autocmds["format"] = format
end

if Formatting.trim_trailing_space == true or Formatting.trim_trailing_space == nil then
	autocmds["trim_whitespaces"] = trim_whitespaces
end

u.define_augroups(autocmds)
