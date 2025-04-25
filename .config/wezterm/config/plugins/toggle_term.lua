local wezterm = require("wezterm")
return {
	setup = function(config)
		local toggle_terminal = wezterm.plugin.require("https://github.com/zsh-sage/toggle_terminal.wez")
		toggle_terminal.apply_to_config(config, {
			key = ";", -- Key for the toggle action
			mods = "CTRL", -- Modifier keys for the toggle action
			direction = "Down", -- Direction to split the pane
			size = { Percent = 20 }, -- Size of the split pane
			change_invoker_id_everytime = false, -- Change invoker pane on every toggle
			zoom = {
				auto_zoom_toggle_terminal = false, -- Automatically zoom toggle terminal pane
				auto_zoom_invoker_pane = true, -- Automatically zoom invoker pane
				remember_zoomed = true, -- Automatically re-zoom the toggle pane if it was zoomed before switching away
			},
		})
	end,
}
