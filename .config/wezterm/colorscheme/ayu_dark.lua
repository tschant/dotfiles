local color = require('wezterm').color
local ayu_dark= {
	background= '#0A0E14',
	foreground= '#CBCCC6',
	normal={
		black=   '#1D202F',
		red=     '#FF3333',
		green=   '#C2D94C',
		yellow=  '#E6B450',
		blue=    '#39BAE6',
		magenta= '#A37ACC',
		cyan=    '#59C2FF',
		white=   '#B3B1AD',
	},
	bright= {
		black=   '#414868',
		red=     '#FF3333',
		green=   '#C2D94C',
		yellow=  '#E6B450',
		blue=    '#39BAE6',
		magenta= '#A37ACC',
		cyan=    '#59C2FF',
		white=   '#CBCCC6',
	},
}

ayu_dark.ansi = {
	ayu_dark.normal.black,
	ayu_dark.normal.red,
	ayu_dark.normal.green,
	ayu_dark.normal.yellow,
	ayu_dark.normal.blue,
	ayu_dark.normal.magenta,
	ayu_dark.normal.cyan,
	ayu_dark.normal.white,
}
ayu_dark.brights = {
	ayu_dark.bright.black,
	ayu_dark.bright.red,
	ayu_dark.bright.green,
	ayu_dark.bright.yellow,
	ayu_dark.bright.blue,
	ayu_dark.bright.magenta,
	ayu_dark.bright.cyan,
	ayu_dark.bright.white,
}

-- Custom colors
ayu_dark.mantle = color.parse('#181825')
ayu_dark.base = ayu_dark.mantle:lighten(0.1)
ayu_dark.surface0 = ayu_dark.mantle:lighten(0.2)
ayu_dark.surface1 = ayu_dark.mantle:lighten(0.3)
ayu_dark.overlay = ayu_dark.mantle:lighten(0.4)
ayu_dark.subtext = ayu_dark.mantle:lighten(0.8)
ayu_dark.text = ayu_dark.mantle:lighten(0.9)

return ayu_dark
