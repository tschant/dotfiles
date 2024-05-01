local color = require('wezterm').color
local oxo = {
	background= '#161616',
	foreground= '#dde1e6',
	normal={
		black= '#393939',
		red= '#ee5396',
		green= '#42be65',
		yellow= '#F9E2AF',
		blue= '#78a9ff',
		magenta= '#be95ff',
		cyan= '#33b1ff',
		white= '#dde1e6',
	},
	bright={
		black= '#393939',
		red= '#ee5396',
		green= '#42be65',
		yellow= '#F9E2AF',
		blue= '#78a9ff',
		magenta= '#be95ff',
		cyan= '#33b1ff',
		white= '#dde1e6',
	},
}

oxo.ansi = {
	oxo.normal.black,
	oxo.normal.red,
	oxo.normal.green,
	oxo.normal.yellow,
	oxo.normal.blue,
	oxo.normal.magenta,
	oxo.normal.cyan,
	oxo.normal.white,
}
oxo.brights = {
	oxo.bright.black,
	oxo.bright.red,
	oxo.bright.green,
	oxo.bright.yellow,
	oxo.bright.blue,
	oxo.bright.magenta,
	oxo.bright.cyan,
	oxo.bright.white,
}

-- Custom colors
oxo.inactive_bg = color.parse('#161616')
oxo.active_bg = oxo.inactive_bg:lighten(0.2)
oxo.selection_bg = oxo.inactive_bg:lighten(0.4)
oxo.overlay = oxo.inactive_bg:lighten(0.5)
oxo.inactive_text = oxo.inactive_bg:lighten(0.8)
oxo.text = oxo.inactive_bg:lighten(0.9)

return oxo
