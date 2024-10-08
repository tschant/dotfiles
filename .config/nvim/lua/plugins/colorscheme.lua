local cmd = vim.cmd
local u = require("utils.colorscheme")
local autocmd = vim.api.nvim_create_autocmd

local Theme = "eldritch"
function config_load()
	u.setColorScheme(Theme)
end

function set_papercolor_theme()
	cmd("set termguicolors")
	cmd("set background=dark")
	vim.g.PaperColor_Theme_Options = {
		theme = {
			default = {
				allow_bold = 1,
			},
			['default.dark'] = {
				transparent_background= 1,
			},
		}
	}
	config_load()
end

--[[ autocmd("BufEnter", {
	pattern = { '*' },
	callback = function()
		-- u.setColorScheme(Theme)
		set_papercolor_theme()
	end,
}) ]]

return {
	{
		-- lazy = false,
		-- priority = 1000,
		"folke/tokyonight.nvim",
		keys = {"<leader>fx"},
		config = function ()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				styles = {
					functions = { bold = true }
				}
			})
			config_load()
		end,
	},
	{
		"eldritch-theme/eldritch.nvim",
		lazy = false,
		priority = 1000,
		config = function ()
			require("eldritch").setup({
				transparent = true,
				styles = {
					functions = { bold = true }
				}
			})
			config_load()
		end,
	},
	{
		--[[ lazy = false,
		priority = 1000, ]]
		"NLKNguyen/papercolor-theme",
		keys = {{"<leader>fx" }},
		config = set_papercolor_theme,
	},
	-- unused
	-- {
	-- 	--[[ lazy = false,
	-- 	priority = 1000, ]]
	-- 	"kartikp10/noctis.nvim",
	-- 	keys = {{"<leader>fx" }},
	-- 	dependencies = { "rktjmp/lush.nvim" },
	-- 	config = config_load,
	-- },
	-- {
	-- 	--[[ lazy = false,
	-- 	priority = 1000, ]]
	-- 	"nyoom-engineering/oxocarbon.nvim",
	-- 	keys = {{"<leader>fx"}},
	-- 	config = config_load,
	-- },
	-- {
	-- 	--[[ lazy = false,
	-- 	priority = 1000, ]]
	-- 	"LunarVim/horizon.nvim",
	-- 	keys = {{"<leader>fx"}},
	-- 	-- ft = {"sql"},
	-- 	config = config_load,
	-- },
	-- {
	-- 	--[[ lazy = false,
	-- 	priority = 1000, ]]
	-- 	"dasupradyumna/midnight.nvim",
	-- 	keys = {{"<leader>fx" }},
	-- 	config = config_load,
	-- },
	-- {
	-- 	"marko-cerovac/material.nvim",
	-- 	keys = {{"<leader>fx" }},
	-- 	config = config_load,
	-- },
	-- {
	-- 	--[[ lazy = false,
	-- 	priority = 1000, ]]
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	keys = {{"<leader>fx" }},
	-- 	config = function ()
	-- 		require("gruvbox").setup({
	-- 			terminal_colors = true,
	-- 			invert_selection = false,
	-- 			invert_signs = false,
	-- 			invert_tabline = false,
	-- 			invert_intend_guides = false,
	-- 			inverse = true,
	-- 			contrast = "hard", -- can be "hard", "soft" or empty string
	-- 			palette_overrides = {},
	-- 			overrides = {},
	-- 			dim_inactive = false,
	-- 			transparent_mode = true,
	-- 		})
	-- 		config_load()
	-- 	end,
	-- }
}
