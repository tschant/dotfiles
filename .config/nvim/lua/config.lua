Opts = {
	jump_last_pos = true,
	highlight_yank = true,
	relativenumber = true,
	scrolloff = 10,
	wrap = false,
	cursorline = true,
	listchars = true,
	language = "en,cjk",
	winbar = "%{%v:lua.require'winbar'.eval()%}"
}

Formatting = {
	-- if format_on_save is enable it will always trim trailing white spaces
	format_on_save = false,
	trim_trailing_space = false,
	indent_size = 2
}
