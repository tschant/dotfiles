local wezterm = require("wezterm")
local session_manager = require("wezterm-session-manager/session-manager")

local M = {
	setup = function()
		wezterm.on("save_session", function(window) session_manager.save_state(window) end)
		wezterm.on("load_session", function(window) session_manager.load_state(window) end)
		wezterm.on("restore_session", function(window) session_manager.restore_state(window) end)
	end
}

return M
