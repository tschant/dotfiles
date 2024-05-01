local color = require('wezterm').color
local nord = {
	background= '#0A0E14',
	foreground= '#CBCCC6',
	dim_foreground= '#a5abb6',
	text= '#d8dee9',
	selection_background= '#4c566a',
	normal= {
		black= '#3b4252',
		red= '#bf616a',
		green= '#a3be8c',
		yellow= '#ebcb8b',
		blue= '#81a1c1',
		magenta= '#b48ead',
		cyan= '#88c0d0',
		white= '#e5e9f0',
	},
	bright= {
		black= '#4c566a',
		red= '#bf616a',
		green= '#a3be8c',
		yellow= '#ebcb8b',
		blue= '#81a1c1',
		magenta= '#b48ead',
		cyan= '#8fbcbb',
		white= '#eceff4',
	},
	dim= {
		black= '#373e4d',
		red= '#94545d',
		green= '#809575',
		yellow= '#b29e75',
		blue= '#68809a',
		magenta= '#8c738c',
		cyan= '#6d96a5',
		white= '#aeb3bb',
	},
}

nord.ansi = {
	nord.dim.black,
	nord.dim.red,
	nord.dim.green,
	nord.dim.yellow,
	nord.dim.blue,
	nord.dim.magenta,
	nord.dim.cyan,
	nord.dim.white,
}
nord.brights = {
	nord.bright.black,
	nord.bright.red,
	nord.bright.green,
	nord.bright.yellow,
	nord.bright.blue,
	nord.bright.magenta,
	nord.bright.cyan,
	nord.bright.white,
}

-- Custom colors
nord.inactive_bg = color.parse('#181825')
nord.active_bg = nord.inactive_bg:lighten(0.1)
nord.selection_bg = nord.selection_background
nord.overlay = nord.inactive_bg:lighten(0.4)
nord.inactive_text = nord.inactive_bg:lighten(0.8)
nord.text = nord.text

return nord
