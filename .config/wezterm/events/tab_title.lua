local wezterm = require('wezterm')

-- Inspired by https://github.com/wez/wezterm/discussions/628#discussioncomment-1874614

local LEFT_TAB_ICON = '' -- '' -- nf.ple_left_half_circle_thick
local RIGHT_TAB_ICON = '' -- '' -- nf.ple_right_half_cirlce_thick
local GLYPH_CIRCLE = '' -- nf.fa_circle

local M = {}

local __cells__ = {}

local cs = require('colorscheme')
local colors = {
   default = { bg = cs.colors.tab_bar.inactive_tab.bg_color, fg = cs.colors.tab_bar.inactive_tab.fg_color, },
   is_active = { bg = cs.colors.tab_bar.active_tab.bg_color, fg = cs.colors.tab_bar.active_tab.fg_color, },
   hover = { bg = cs.colors.tab_bar.inactive_tab_hover.bg_color, fg = cs.colors.tab_bar.inactive_tab_hover.fg_color, },
}

local _set_process_name = function(s)
   local a = string.gsub(s, '(.*[/\\])(.*)', '%2')
   return a:gsub('%.exe$', '')
end

local _set_title = function(process_name, base_title, max_width)
   local title
   local inset = 0

   if process_name:len() > 0 then
      title = process_name .. ' ~ ' .. base_title
   else
      title = base_title
   end

   if title:len() > max_width - inset then
      local diff = title:len() - max_width + inset
      title = wezterm.truncate_right(title, title:len() - diff)
   end

   return title
end

---@param fg string
---@param bg string
---@param attribute table
---@param text string
local _push = function(bg, fg, attribute, text)
   table.insert(__cells__, { Background = { Color = bg } })
   table.insert(__cells__, { Foreground = { Color = fg } })
   table.insert(__cells__, { Attribute = attribute })
   table.insert(__cells__, { Text = text })
end

M.setup = function()
   wezterm.on('format-tab-title', function(tab, _tabs, _panes, _config, hover, max_width)
      __cells__ = {}

      local bg
      local fg
      local process_name = _set_process_name(tab.active_pane.foreground_process_name)
      local title = _set_title(process_name, (tab.tab_title ~= '' and tab.tab_title or tab.active_pane.title), max_width)

      if tab.is_active then
         bg = colors.is_active.bg
         fg = colors.is_active.fg
      elseif hover then
         bg = colors.hover.bg
         fg = colors.hover.fg
      else
         bg = colors.default.bg
         fg = colors.default.fg
      end

      local has_unseen_output = false
      for _, pane in ipairs(tab.panes) do
         if pane.has_unseen_output then
            has_unseen_output = true
            break
         end
      end

      -- Left semi-circle
      _push(fg, bg, { Intensity = 'Bold' }, LEFT_TAB_ICON)

      -- Title
      _push(bg, fg, { Intensity = 'Bold' }, ' ' .. title)

      -- Unseen output alert
      if has_unseen_output then
         _push(bg, cs.base.normal.yellow, { Intensity = 'Bold' }, ' ' .. GLYPH_CIRCLE)
      end

      -- Right padding
      _push(bg, fg, { Intensity = 'Bold' }, ' ')

      -- Right semi-circle
      _push(fg, bg, { Intensity = 'Bold' }, RIGHT_TAB_ICON)

      return __cells__
   end)
end

return M
