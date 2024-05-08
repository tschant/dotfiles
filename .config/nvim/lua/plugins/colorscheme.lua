local cmd = vim.cmd
local u = require("utils.colorscheme")
local autocmd = vim.api.nvim_create_autocmd

local Theme = "papercolor"
function config_load()
	u.setColorScheme(Theme)

	autocmd("BufEnter", {
		pattern = { '*' },
		callback = function()
			u.setColorScheme(Theme)
		end,
	})
end

return {
	{
		lazy = false,
		priority = 1000,
		"NLKNguyen/papercolor-theme",
		keys = {{"<leader>fx" }},
		config = function ()
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
		end,
	},
	{
		--[[ lazy = false,
		priority = 1000, ]]
		"kartikp10/noctis.nvim",
		keys = {{"<leader>fx" }},
		dependencies = { "rktjmp/lush.nvim" },
		config = config_load,
	},
	{
		--[[ lazy = false,
		priority = 1000, ]]
		"nyoom-engineering/oxocarbon.nvim",
		keys = {{"<leader>fx"}},
		config = config_load,
	},
	{
		--[[ lazy = false,
		priority = 1000, ]]
		"LunarVim/horizon.nvim",
		keys = {{"<leader>fx"}},
		-- ft = {"sql"},
		config = config_load,
	},
	--[[ {
		"shaunsingh/solarized.nvim",
		keys = {"<leader>fx"},
		config = config_load,
	}, ]]
	{
		--[[ lazy = false,
		priority = 1000, ]]
		"dasupradyumna/midnight.nvim",
		keys = {{"<leader>fx" }},
		config = config_load,
	},
	{
		"marko-cerovac/material.nvim",
		keys = {{"<leader>fx" }},
		config = config_load,
	},
	{
		--[[ lazy = false,
		priority = 1000, ]]
		"ellisonleao/gruvbox.nvim",
		keys = {{"<leader>fx" }},
		config = function ()
			require("gruvbox").setup({
				terminal_colors = true,
				invert_selection = false,
				invert_signs = false,
				invert_tabline = false,
				invert_intend_guides = false,
				inverse = true,
				contrast = "hard", -- can be "hard", "soft" or empty string
				palette_overrides = {},
				overrides = {},
				dim_inactive = false,
				transparent_mode = true,
			})
			config_load()
		end,
	}
}
