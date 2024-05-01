local color = require('wezterm').color
local gruv = {
	background= '#0A0E14',
	foreground= '#ebdbb2',
	normal= {
		black=   '#282828',
		red=     '#cc241d',
		green=   '#98971a',
		yellow=  '#d79921',
		blue=    '#458588',
		magenta= '#b16286',
		cyan=    '#689d6a',
		white=   '#a89984',
	},
	bright= {
		black=   '#928374',
		red=     '#fb4934',
		green=   '#b8bb26',
		yellow=  '#fabd2f',
		blue=    '#83a598',
		magenta= '#d3869b',
		cyan=    '#8ec07c',
		white=   '#ebdbb2',
	},
}

gruv.ansi = {
	gruv.normal.black,
	gruv.normal.red,
	gruv.normal.green,
	gruv.normal.yellow,
	gruv.normal.blue,
	gruv.normal.magenta,
	gruv.normal.cyan,
	gruv.normal.white,
}
gruv.brights = {
	gruv.bright.black,
	gruv.bright.red,
	gruv.bright.green,
	gruv.bright.yellow,
	gruv.bright.blue,
	gruv.bright.magenta,
	gruv.bright.cyan,
	gruv.bright.white,
}

-- Custom colors
gruv.inactive_bg = color.parse('#181825')
gruv.active_bg = gruv.inactive_bg:lighten(0.1)
gruv.selection_bg = gruv.inactive_bg:lighten(0.3)
gruv.overlay = gruv.inactive_bg:lighten(0.4)
gruv.inactive_text = gruv.inactive_bg:lighten(0.8)
gruv.text = gruv.inactive_bg:lighten(0.9)

return gruv
