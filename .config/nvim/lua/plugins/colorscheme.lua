local u = require("utils.colorscheme")

function config_load(theme)
	u.setColorScheme(theme)
end

return {
	--[[ {
		"eldritch-theme/eldritch.nvim",
		lazy = false,
		priority = 1000,
		keys = { { "<leader>fx" } },
		config = function()
			require("eldritch").setup({
				transparent = true,
				styles = {
					functions = { bold = true },
				},
			})
			config_load()
		end,
	}, ]]

	--[[ {
		lazy = false,
		priority = 1000,
		"nuvic/flexoki-nvim",
		keys = { { "<leader>fx" } },
		config = function()
			require("flexoki").setup({
				styles = {
					transparency = true,
				},
			})
			config_load()
		end,
	}, ]]
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
		lazy = false,
		priority = 1000,
		"zenbones-theme/zenbones.nvim",
		dependencies = { "rktjmp/lush.nvim", branch = "main" },
		config = function()
			local colors_name = "rosebones"
			-- vim.g[colors_name .. "_compat"] = 1
			vim.g[colors_name] = {
				-- darkness = "stark",
				-- lightness = "bright",
				-- dim_noncurrent_window = true,
				-- solid_vert_split = true,
				solid_line_nr = true,
				-- darken_non_text = 30,
				-- italic_comments = false,
				-- transparent_background = true,
				-- lighten_cursor_line = 20,
				-- darken_cursor_line = 20,
				-- colorize_diagnostic_underline_text = true,
			}
			config_load(colors_name)
		end,
	},
	-- unused
	--[[ {
		lazy = false,
		priority = 1000,
		"kartikp10/noctis.nvim",
		keys = { { "<leader>fx" } },
		dependencies = { "rktjmp/lush.nvim" },
		config = config_load,
	}, ]]
	--[[ {
		lazy = false,
		priority = 1000,
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
	}, ]]
	--[[ {
		lazy = false,
		priority = 1000,
		"NLKNguyen/papercolor-theme",
		keys = { { "<leader>fx" } },
		config = function()
			local cmd = vim.cmd
			cmd("set termguicolors")
			cmd("set background=dark")
			vim.g.PaperColor_Theme_Options = {
				theme = {
					default = {
						allow_bold = 1,
					},
					["default.dark"] = {
						transparent_background = 1,
					},
				},
			}
			config_load()
		end,
	}, ]]
	--[[ {
		lazy = false,
		priority = 1000,
		"folke/tokyonight.nvim",
		keys = { "<leader>fx" },
		config = function()
			require("tokyonight").setup({
				style = "night",
				transparent = true,
				styles = {
					functions = { bold = true },
				},
			})
			config_load()
		end,
	}, ]]
}
