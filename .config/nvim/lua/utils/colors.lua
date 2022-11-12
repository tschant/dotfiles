--local d2d = require("Dusk-til-Dawn")
local mocha = require("catppuccin.palettes").get_palette "mocha"
local latte = require("catppuccin.palettes").get_palette "latte"

M = {}
M.dark = {
	bg = mocha.crust,
	bg2 = mocha.mantle,
	base = mocha.base,
	black = mocha.mantle,
	yellow = mocha.yellow,
	cyan = mocha.sky,
	green = mocha.green,
	orange = mocha.peach,
	purple = mocha.lavender, --act2
	magenta = mocha.mauve,
	grey = mocha.overlay0,
	gray = mocha.overlay1, -- visual
	blue = mocha.blue,
	lightblue = mocha.sapphire, -- modified
	red = mocha.red,
	white = mocha.text,
	-- custom colors
	comments = "#2aa1ae",
	error = "#FC5C94",
	warning = "#F3EA98",
	info = "#8DE6F7"
}

M.light = {
	bg = latte.surface0,
	bg2 = latte.surface1,
	base = latte.base,
	yellow = latte.yellow,
	cyan = latte.sky,
	green = latte.green,
	orange = latte.peach,
	purple = latte.lavender, --act2
	magenta = latte.mauve,
	grey = latte.overlay0,
	gray = latte.overlay1, -- visual
	blue = latte.blue,
	lightblue = latte.sapphire, -- modified
	red = latte.red,
	white = mocha.text,
	-- custom colors
	comments = "#2aa1ae",
	error = "#FC5C94",
	warning = "#F3EA98",
	info = "#8DE6F7"
}

-- function M.Color(val)
--     return function()
--         local dark = M.dark
--         local light = M.light
--
--         if vim.o.background ~= nil and vim.o.background == "light" then
--             if light[val] ~= nil then
--                 return light[val]
--             else
--                 return light.error
--             end
--         elseif vim.o.background ~= nil and vim.o.background == "dark" then
--             if dark[val] ~= nil then
--                 return dark[val]
--             else
--                 return dark.error
--             end
--         end
--     end
-- end

return M[Opts.color_mode]
