local color = require('wezterm').color
local ayu_dark= {
	dark={
		background= '#0A0E14',
		foreground= '#CBCCC6',
		black=   '#1D202F',
		red=     '#FF3333',
		green=   '#C2D94C',
		yellow=  '#E6B450',
		blue=    '#39BAE6',
		magenta= '#A37ACC',
		cyan=    '#59C2FF',
		white=   '#B3B1AD',
	},
	light= {
		background= '#CBCCC6',
		foreground= '#0A0E14',
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
	ayu_dark.dark.black,
	ayu_dark.dark.red,
	ayu_dark.dark.green,
	ayu_dark.dark.yellow,
	ayu_dark.dark.blue,
	ayu_dark.dark.magenta,
	ayu_dark.dark.cyan,
	ayu_dark.dark.white,
}
ayu_dark.brights = {
	ayu_dark.light.black,
	ayu_dark.light.red,
	ayu_dark.light.green,
	ayu_dark.light.yellow,
	ayu_dark.light.blue,
	ayu_dark.light.magenta,
	ayu_dark.light.cyan,
	ayu_dark.light.white,
}

-- Custom colors
ayu_dark.dark.inactive_bg = color.parse('#181825')
ayu_dark.dark.active_bg = ayu_dark.dark.inactive_bg:lighten(0.1)
ayu_dark.dark.selection_bg = ayu_dark.dark.inactive_bg:lighten(0.3)
ayu_dark.dark.overlay = ayu_dark.dark.inactive_bg:lighten(0.4)
ayu_dark.dark.inactive_text = ayu_dark.dark.inactive_bg:lighten(0.8)
ayu_dark.dark.text = ayu_dark.dark.inactive_bg:lighten(0.9)

ayu_dark.light.inactive_bg = color.parse('#CBCCC6')
ayu_dark.light.active_bg = ayu_dark.light.inactive_bg:darken(0.1)
ayu_dark.light.selection_bg = ayu_dark.light.inactive_bg:darken(0.3)
ayu_dark.light.overlay = ayu_dark.light.inactive_bg:darken(0.4)
ayu_dark.light.inactive_text = ayu_dark.light.inactive_bg:darken(0.8)
ayu_dark.light.text = ayu_dark.light.inactive_bg:darken(1)

return ayu_dark
