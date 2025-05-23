--- wezterm.lua
--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---
--- My Wezterm config file
local Config = require("config")

require("events.status").setup()
require("events.sessions").setup()
require("events.tab_title").setup()

local config = Config:init()
	:append(require("config.appearance"))
	:append(require("config.keybinds"))
	:append(require("config.general")).options

require("config.plugins").setup(config)

return config
