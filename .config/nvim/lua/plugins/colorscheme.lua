local cmd = vim.cmd

return {
	{
		'kartikp10/noctis.nvim',
		dependencies = { 'rktjmp/lush.nvim' },
		lazy = false,
		priority = 1000,
		config = function()
			cmd("colorscheme noctis")

			-- Use terminal background color instead of colorscheme
			cmd "hi Normal ctermbg=none guibg=none"
			cmd "hi NormalNC ctermbg=none guibg=#262626"

			-- highlights --
			cmd "hi EndOfBuffer guifg=#525252 guibg=NONE"
			cmd "hi gitcommitOverflow guifg=#525252 guibg=NONE"
			cmd "hi gitcommitTrailers guifg=#525252 guibg=NONE"
			cmd "hi Visual guibg=#525252"
			-- cmd "hi Comment guifg=#307050"
			-- cmd "au ColorScheme * hi Comment guifg=#3d4149"
			-- cmd "hi SignColumn guibg=NONE"
			-- cmd "hi EndOfBuffer guifg=#1e222a"
			-- cmd "hi PmenuSel guibg=#98c379"
			-- cmd "hi Pmenu  guibg=#282c34"
			--
			-- -- git signs
			local colors = require("utils.colors")
			cmd("hi DiffAdd guifg=" .. colors.green .. " guibg = none")
			cmd("hi DiffChange guifg =" .. colors.blue .. " guibg = none")
			cmd("hi DiffModified guifg =" .. colors.orange .. " guibg = none")
			cmd("hi DiffDeleted guifg =" .. colors.red .. " guibg = none")
		end
	},
	-- Themes
	--"norcalli/nvim-base16.lua",
	{
		"catppuccin/nvim",
		branch = "main",
		config = function()
			require("catppuccin").setup({
				-- flavour = 'latte',
				flavour = 'mocha',
				transparent_background = true,
				term_colors = true,
				integrations = {
					nvimtree = {
						enabled = false,
						show_root = true,
					},
					barbar = true,
					dashboard = false,
					telescope = true,
					gitsigns = true
				}
			})

			-- cmd("colorscheme catppuccin")
		end
	},
	{
		"shaunsingh/oxocarbon.nvim",
		branch = "fennel",
		-- config = function()
		-- 	cmd("colorscheme oxocarbon")
		-- end
	},
	{
		'LunarVim/horizon.nvim'
		-- config = function()
		-- 	cmd("colorscheme horizon")
		-- end
	},
}
