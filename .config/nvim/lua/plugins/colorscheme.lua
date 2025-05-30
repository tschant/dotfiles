local u = require("utils.colorscheme")

function config_load(theme)
	u.setColorScheme(theme)
end

return {

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
			local colors_name = "forestbones"
			-- vim.g[colors_name .. "_compat"] = 1
			vim.g[colors_name] = {
				darkness = "stark",
				-- dim_noncurrent_window = true,
				-- solid_vert_split = true,
				solid_line_nr = true,
				-- darken_non_text = 30,
				-- italic_comments = false,
				transparent_background = true,
				-- lighten_cursor_line = 20,
				-- darken_cursor_line = 20,
				-- colorize_diagnostic_underline_text = true,
			}
			config_load(colors_name)
		end,
	},
	-- unused
}
