Opts = {
	color_mode = "dark",
	jump_last_pos = true,
	highlight_yank = true,
	relativenumber = true,
	cursor_hold = true,
	scrolloff = 10,
	wrap = false,
	cursorline = true,
	list = true,
	listchars = true,
	language = "en,cjk",
	winbar = "%{%v:lua.require'config.winbar'.eval()%}",
	encoding = "utf-8",
}

Formatting = {
	-- if format_on_save is enable it will always trim trailing white spaces
	format_on_save = { "js", "ts", "tsx", "jsx", "py", "lua" }, -- array of file suffixes
	-- format_on_save = true, -- ALL files
	trim_trailing_space = false,
	indent_size = 2,
}
