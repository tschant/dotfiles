local color = require('wezterm').color
local base = require('colorscheme.ayu_dark')
local colors = base.dark

local colorscheme = {
   foreground = colors.foreground,
   background = colors.background,
   cursor_bg = colors.text,
   cursor_border = colors.text,
   cursor_fg = colors.text,
   selection_bg = colors.selection_bg,
   selection_fg = colors.text,
   ansi = base.ansi,
   brights = base.brights,
   tab_bar = {
      background = color.parse(colors.background):lighten(0.03),
      active_tab = {
         bg_color = colors.text,
         fg_color = colors.active_bg,
      },
      inactive_tab = {
         bg_color = colors.inactive_bg,
         fg_color = colors.inactive_text,
      },
      inactive_tab_hover = {
         bg_color = colors.active_bg,
         fg_color = colors.text,
         italic = true,
      },
      new_tab = {
         bg_color = colors.inactive_bg,
         fg_color = colors.text,
      },
      new_tab_hover = {
         bg_color = colors.active_bg,
         fg_color = colors.text,
         italic = true,
      },
   },
   visual_bell = colors.inactive_text,
   indexed = {
      [16] = colors.blue,
      [17] = colors.cyan,
   },
   scrollbar_thumb = colors.active_bg,
   split = colors.overlay,
   compose_cursor = colors.red, -- nightbuild only
}

return {
  colors = colorscheme,
  base = base,
}

--[[
  -- TODO: Convert to lua
  schemes:
    horizon_dark: &horizon_dark
      primary:
        background: '#0A0E14'
        foreground: '#CBCCC6'
        # background: '0x1c1e26'
        # foreground: '0xe0e0e0'
      normal:
        black: '0x16161c'
        red: '0xe95678'
        green: '0x29d398'
        yellow: '0xfab795'
        blue: '0x26bbd9'
        magenta: '0xee64ac'
        cyan: '0x59e1e3'
        white: '0xd5d8da'
      bright:
        black: '0x5b5858'
        red: '0xec6a88'
        green: '0x3fdaa4'
        yellow: '0xfbc3a7'
        blue: '0x3fc4de'
        magenta: '0xf075b5'
        cyan: '0x6be4e6'
        white: '0xd5d8da'

    kaolin: &kaolin
      primary:
        background: '#18181B'
        foreground: '#E4E4E8'
      normal:
        black:    '#4B5254'
        red:      '#CD5C60'
        green:    '#6FB593'
        yellow:   '#DBAC66'
        blue:     '#91B9C7'
        magenta:  '#845A84'
        cyan:     '#4D9391'
        white:    '#E4E4E8'
      bright:
        black:    '#879193'
        red:      '#C93237'
        green:    '#35BF88'
        yellow:   '#EED891'
        blue:     '#3B84CC'
        magenta:  '#D24B83'
        cyan:     '#68F3CA'
        white:    '#EFEFF1'

    amarena: &amarena
      primary:
        background: '#0A0E14'
        foreground: '#CBCCC6'
        # background:	'#1A2026'
        # foreground:	'#FFFFFF'
      normal: 
        black:	  '#242D35'
        red:	    '#FB6396'
        green:	  '#94CF95'
        yellow:	  '#F692B2'
        blue:	    '#6EC1D6'
        magenta:	'#CD84C8'
        cyan:	    '#7FE4D2'
        white:	  '#FFFFFF'
      bright:
        black:	  '#526170'
        red:	    '#F92D72'
        green:	  '#6CCB6E'
        yellow:   '#F26190'
        blue:	    '#4CB9D6'
        magenta:	'#C269BC'
        cyan:	    '#58D6BF'
        white:	  '#F4F5F2'
]]
