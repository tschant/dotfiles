local wezterm = require('wezterm')
local cs = require('colorscheme')

local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

return {
   colors = cs.colors,
   animation_fps = 60,
   max_fps = 60,
   front_end = 'WebGpu',
   webgpu_power_preference = 'HighPerformance',
	 font = wezterm.font_with_fallback({
		 { family = "CaskaydiaCove Nerd Font",       scale = 0.9, weight = "Light", },
		 { family = "Hasklug Nerd Font", scale = 1, },
	 }),

   -- color scheme

   -- background
   background = {
      --[[ {
				source = { File = wezterm.GLOBAL.background },
      }, ]]
      {
         source = { Color = cs.colors.background },
         height = '100%',
         width = '100%',
         opacity = 0.96,
      },
   },

   -- scrollbar
   enable_scroll_bar = true,

   -- tab bar
   enable_tab_bar = true,
   hide_tab_bar_if_only_one_tab = false,
   use_fancy_tab_bar = false,
	 tab_bar_at_bottom = false,
   tab_max_width = 25,
   show_tab_index_in_tab_bar = false,
   switch_to_last_active_tab_when_closing_tab = true,

   -- window
   window_padding = {
      left = 5,
      right = 10,
      top = 12,
      bottom = 7,
   },
	 window_decorations = "RESIZE",
	 window_close_confirmation = "AlwaysPrompt",
   -- window_close_confirmation = 'NeverPrompt',
   window_frame = {
      active_titlebar_bg = '#090909',
      -- font = fonts.font,
      -- font_size = fonts.font_size,
   },
	 inactive_pane_hsb = {
		 saturation = 0.24,
		 brightness = 0.5
	 },
}

--[[ Appearance setting for when I need to take pretty screenshots
config.enable_tab_bar = false
config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.5cell',
  bottom = '0cell',

}
--]]
