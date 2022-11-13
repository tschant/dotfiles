--local d2d = require("Dusk-til-Dawn")
local mocha = require("catppuccin.palettes").get_palette "mocha"
local latte = require("catppuccin.palettes").get_palette "latte"

M = {}
M.dark = {
	bg = mocha.mantle,
	bg2 = mocha.surface0,
	bg3 = mocha.surface1,
	black = mocha.mantle,
	yellow = mocha.yellow,
	cyan = mocha.sky,
	lightblue = mocha.sapphire,
	blue = mocha.blue,
	green = mocha.green,
	orange = mocha.peach,
	purple = mocha.lavender,
	magenta = mocha.mauve,
	red = mocha.red,
	grey = mocha.overlay0,
	lightgrey = mocha.subtext0,
	white = mocha.text,
	-- custom colors
	comments = "#2aa1ae",
	error = "#FC5C94",
	warning = "#F3EA98",
	info = "#8DE6F7"
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
	bg = latte.surface0,
	bg2 = latte.surface1,
	bg3 = latte.surface2,
	yellow = latte.yellow,
	cyan = latte.sky,
	green = latte.green,
	orange = latte.peach,
	purple = latte.lavender,
	magenta = latte.mauve,
	grey = latte.overlay0,
	blue = latte.blue,
	lightblue = latte.sapphire,
	red = latte.red,
	white = mocha.text,
	-- custom colors
	comments = "#2aa1ae",
	error = "#FC5C94",
	warning = "#F3EA98",
	info = "#8DE6F7"
}

return M[Opts.color_mode]
