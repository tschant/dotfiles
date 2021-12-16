Opts = {
	jump_last_pos = true,
	highlight_yank = true,
	relativenumber = true,
	scrolloff = 10,
	wrap = false,
	cursorline = true,
	listchars = true
}

Formatting = {
	-- if format_on_save is enable it will always trim trailing white spaces
	format_on_save = false,
	trim_trailing_space = false,
	indent_size = 2
}

Statusline = {
	-- hide, show on specific filetypes
	hidden = {
		"help",
		"dashboard",
		"NvimTree",
		"terminal",
	},
	shown = {},
	-- truncate statusline on small screens
	shortline = true,
	style = "block", -- default, round , slant , block , arrow
}
