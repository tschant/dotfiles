--local d2d = require("Dusk-til-Dawn")
M = {}

M.dark = {
	bg = "#181825",
	bg2 = "#313244",
	bg3 = "#45475a",
	black = "#181825",
	yellow = "#f9e2af",
	cyan = "#89dceb",
	lightblue = "#74c7ec",
	blue = "#89b4fa",
	green = "#a6e3a1",
	orange = "#fab387",
	purple = "#b4befe",
	magenta = "#cba6f7",
	red = "#f38ba8",
	grey = "#6c7086",
	lightgrey = "#a6adc8",
	white = "#cdd6f4",
	-- custom colors
	comments = "#2aa1ae",
	error = "#FC5C94",
	warning = "#F3EA98",
	info = "#8DE6F7",
	hint = "#6c7086",
	-- bg = "#161616",
	-- bg2 = "#181825",
	-- bg3 = "#181825",
	-- black = "#131313",
	-- yellow = "#d5971a",
	-- cyan = "#16a3b6",
	-- lightblue = "#49d6e9",
	-- blue = "#49ace9",
	-- green = "#16b673",
	-- orange = "#e66533",
	-- purple = "#7060eb",
	-- magenta = "#7f659a",
	-- red = "#df769b",
	-- grey = "#525252",
	-- lightgrey = mocha.subtext0,
	-- white = "#dde1e6",
	-- -- custom colors
	-- comments = "#2aa1ae",
	-- error = "#FC5C94",
	-- warning = "#e4b781",
	-- info = "#8DE6F7"
}

M.light = {
	bg = "#ccd9da",
	bg2 = "#bcc0cc",
	bg3 = "#acb0be",
	yellow = "#df8e1d",
	cyan = "#04a5e5",
	green = "#40a02b",
	orange = "#fe640b",
	purple = "#7287fd",
	magenta = "#8839ef",
	grey = "#9ca0b0",
	blue = "#1e66f5",
	lightblue = "#209fb5",
	red = "#d20f39",
	white = "#4c4f69",
	-- custom colors
	comments = "#2aa1ae",
	error = "#FC5C94",
	warning = "#F3EA98",
	info = "#8DE6F7",
	hint = "#9ca0b0"
}

return M[Opts.color_mode]
