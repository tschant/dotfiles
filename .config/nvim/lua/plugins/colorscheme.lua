local u = require("utils.colorscheme")

function config_load(theme)
	u.setColorScheme(theme)
end

return {
	{
		"vague-theme/vague.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other plugins
		config = function()
			-- NOTE: you do not need to call setup if you don't want to.
			require("vague").setup({
				-- optional configuration here
				transparent = true,
			})
			config_load("vague")
		end,
	},
	{
		--[[ lazy = false,
		priority = 1000, ]]
		"oskarnurm/koda.nvim",
		config = function()
			require("koda").setup({
				transparent = true,
				colors = {},
			})
			config_load("koda")
		end,
	},
	{
		--[[ lazy = false,
		priority = 1000, ]]
		"KijitoraFinch/nanode.nvim",
		config = function()
			require("nanode").setup({
				transparent = true,
			})
			config_load("nanode")
		end,
	},
	{
		--[[ lazy = false,
		priority = 1000, ]]
		"rebelot/kanagawa.nvim",
		config = function()
			local colors_name = "rosebones"
			require("kanagawa").setup({
				transparent = true,
				theme = "wave",
			})
			config_load(colors_name)
		end,
	},
	{
		--[[ lazy = false,
		priority = 1000, ]]
		"jesseleite/nvim-noirbuddy",
		dependencies = {
			{ "tjdevries/colorbuddy.nvim", branch = "master" },
		},
		opts = {
			preset = "slate",
			colors = {
				primary = "#6EE2FF",
				secondary = "#76b5c5",
			},
		},
		config = function(_, opts)
			require("noirbuddy").setup(opts)
			config_load(--[[ "noirbuddy" ]])
		end,
	},
	-- unused
}
