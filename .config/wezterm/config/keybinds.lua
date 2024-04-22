local wezterm = require("wezterm")
local platform = require('utils.platform')()
local act = wezterm.action

local mod = {}

if platform.is_mac then
   mod.SUPER = 'SUPER'
   mod.SUPER_REV = 'SUPER|CTRL'
elseif platform.is_win or platform.is_linux then
   mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
   mod.SUPER_REV = 'ALT|CTRL'
end

local leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
local keys = {
  -- Send C-b when pressing C-b twice
  { key = "b",          mods = "LEADER|CTRL", action = act.SendKey { key = "b", mods = "CTRL" } },
  { key = "phys:Space", mods = "LEADER",      action = act.ActivateCommandPalette },

   -- misc/useful --
   { key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
   { key = 'H', mods = 'CTRL|SHIFT', action = 'ActivateCopyMode' }, -- TMUX port
   { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
   { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
   { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
   {
      key = 'F5',
      mods = 'NONE',
      action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
   },

   
   { key = 'c', mods = 'CTRL|SHIFT',  action = act.CopyTo('Clipboard') },
   { key = 'v', mods = 'CTRL|SHIFT',  action = act.PasteFrom('Clipboard') },
   -- toggle fullscreen
   { key = 'F11', mods = 'NONE',    action = act.ToggleFullScreen },
   { key = 'F12', mods = 'NONE',    action = act.ShowDebugOverlay },
   { key = 'f',   mods = mod.SUPER, action = act.Search({ CaseInSensitiveString = '' }) },

  -- Pane keybindings
  { key = "q",          mods = "LEADER",      action = act.CloseCurrentPane { confirm = true } },
  { key = "W",          mods = "CTRL|SHIFT",      action = act.CloseCurrentPane { confirm = true } }, -- TMUX port
  { key = "o",          mods = "LEADER",      action = act.RotatePanes "Clockwise" },
  -- We can make separate keybindings for resizing panes
  -- But Wezterm offers custom "mode" in the name of "KeyTable"
  { key = "r",          mods = "LEADER",      action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

  -- window --
  -- spawn windows
  { key = 'n', mods = mod.SUPER,     action = act.SpawnWindow },

  -- Tab keybindings
  { key = "t",          mods = "LEADER",      action = act.SpawnTab("CurrentPaneDomain") },
  { key = "{",          mods = "CTRL|SHIFT",      action = act.ActivateTabRelative(-1) },
  { key = "}",          mods = "CTRL|SHIFT",      action = act.ActivateTabRelative(1) },
  { key = "n",          mods = "LEADER",      action = act.ShowTabNavigator },
  {
    key = "e",
    mods = "LEADER",
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Fuchsia" } },
        { Text = "Renaming Tab Title...:" },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end)
    }
  },
  -- Key table for moving tabs around
  { key = "m", mods = "LEADER",       action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
  { key = 'LeftArrow', mods = 'CTRL', action = act.ActivatePaneDirection 'Left', },
  { key = 'LeftArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { "Left", 1 } },
  { key = 'RightArrow', mods = 'CTRL', action = act.ActivatePaneDirection 'Right', },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { "Right", 1 }, },
  { key = 'UpArrow', mods = 'CTRL', action = act.ActivatePaneDirection 'Up', },
  { key = 'UpArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { "Up", 1 }, },
  { key = 'DownArrow', mods = 'CTRL', action = act.ActivatePaneDirection 'Down', },
  { key = 'DownArrow', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { "Down", 1 }, },
  {
    key = '\\',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  }, -- TMUX port
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  }, -- TMUX port

  { key = 'l', mods = 'ALT',    action = wezterm.action.ShowLauncher },
  { key = 'S', mods = 'CTRL|SHIFT', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES' } },
  { key = 'T', mods = 'LEADER', action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS' } },
  {
    key = 'J', -- TMUX port
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      local home = wezterm.home_dir
      local workspaces = {}
      local n = os.tmpname()
      os.execute("zoxide query -l > " .. n)
      for line in io.lines(n) do
        table.insert(workspaces, {id = line, label = line:gsub(home, "~")})
      end
      os.execute('grep "Host .*" "$HOME/.ssh/config" > ' .. n)
      for line in io.lines(n) do
        table.insert(workspaces, {id = "SSH:" .. line:gsub("Host ", ""), label = line})
      end
      os.remove(n)

      window:perform_action(
      act.InputSelector {
        action = wezterm.action_callback(
        function(inner_window, inner_pane, id, label)
          if not id and not label then
            wezterm.log_info 'cancelled'
          else
            wezterm.log_info('id = ' .. id)
            wezterm.log_info('label = ' .. label)
            if string.match(label, "Host ") then
              inner_window:perform_action(
              act.SwitchToWorkspace {
                name = label,
                spawn = {
                  label = 'Workspace: ' .. label,
                  domain = { DomainName = id },
                },
              },
              inner_pane
              )
            else
              inner_window:perform_action(
              act.SwitchToWorkspace {
                name = label,
                spawn = {
                  label = 'Workspace: ' .. label,
                  cwd = id,
                },
              },
              inner_pane
              )
            end
          end
        end
        ),
        title = 'Choose Workspace',
        choices = workspaces,
        fuzzy = true,
        fuzzy_description = 'Fuzzy find and/or make a workspace: ',
      },
      pane
      )
    end),
  },

  {
    key = 'w',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(
          act.SwitchToWorkspace {
            name = line,
          },
          pane
          )
        end
      end),
    },
  },

  {
    key = 'Enter',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },

  { key = 'S', mods = 'LEADER', action = wezterm.action { EmitEvent = 'save_session' } },
  { key = 'L', mods = 'LEADER', action = wezterm.action { EmitEvent = 'load_session' } },
  { key = 'R', mods = 'LEADER', action = wezterm.action { EmitEvent = 'restore_session' } },

}

-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
  table.insert(keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1)
  })
end

local key_tables = {
  resize_pane = {
    { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
    { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
    { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
    { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  },
  move_tab = {
    { key = "h",      action = act.MoveTabRelative(-1) },
    { key = "j",      action = act.MoveTabRelative(-1) },
    { key = "k",      action = act.MoveTabRelative(1) },
    { key = "l",      action = act.MoveTabRelative(1) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  }
}

local mouse_bindings = {
   -- Ctrl-click will open the link under the mouse cursor
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
   },
   --[[ {
      event = { Down = { streak = 3, button = 'Left' } },
      mods = 'NONE',
      action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
   }, ]]
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CopyTo('Clipboard'),
   },
   {
      event = { Down = { streak = 1, button = 'Right' } },
      mods = 'NONE',
      action = act.PasteFrom('Clipboard'),
   },
}

return {
  disable_default_key_bindings = true,
  leader = leader,
  keys = keys,
  key_tables = key_tables,
  mouse_bindings = mouse_bindings,
}

