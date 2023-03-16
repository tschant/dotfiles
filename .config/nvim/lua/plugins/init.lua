return {
	-- Window splitting
	"beauwilliams/focus.nvim",

	-- Markdown
	{"iamcco/markdown-preview.nvim", build = "cd app && yarn install", event = "BufRead *.md"},

	-- JS/html
	{"ryym/vim-riot", ft = {"javascript", "tag"}},

	-- Terraform
	{'hashivim/vim-terraform', event = "BufReadPre *.tf"},
	{'juliosueiras/vim-terraform-completion', event = "BufRead *.tf"},

	-- General plugins
	{
		"cbochs/portal.nvim",
	},
	{
		"NMAC427/guess-indent.nvim",
		config = true,
		event = "BufReadPre"
	},
	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		config = true
	},
	{
		"karb94/neoscroll.nvim",
		event = "BufReadPre",
		config = true
	},
	{
		"kylechui/nvim-surround",
		event = "BufReadPre",
		config = function()
			require("nvim-surround").setup()
		end
	},
	{"ggandor/lightspeed.nvim", event = "BufReadPre"},

	-- Multi-line plugins
	{
		"anuvyklack/pretty-fold.nvim",
		event = "BufRead",
		dependencies = 'anuvyklack/nvim-keymap-amend',
		config = function()
			require("pretty-fold").setup({
				keep_indentation = false,
				fill_char = '━',
				sections = {
					left = {
						function() return string.rep('>', vim.v.foldlevel) end,
						' ', 'number_of_folded_lines', ':', 'content', 'percentage', ' ┣━━',
					},
					right = {
						'┫'
					}
				}
			})
		end
	},
	{
		"anuvyklack/fold-preview.nvim",
		event = "BufReadPre",
		dependencies = 'anuvyklack/nvim-keymap-amend',
		config = true
	},
	{
		"mg979/vim-visual-multi",
		event = "BufRead",
		config = function()
			vim.g.VM_silent_exit = 1
		end
	},
	{
		"kevinhwang91/nvim-hlslens",
		event = "BufReadPre",
		config = function()
			require("hlslens").setup({
				build_position_cb = function(plist, bufnr, changedtick, pattern)
					-- require('scrollbar.handlers.search').handler.show(plist.start_pos)
					require('scrollbar').search_handler.show(plist.start_pos)
				end
			})
		end
	},
	{
		"petertriho/nvim-scrollbar",
		event = "BufReadPost",
		config = function()
			local icons = require('utils.icons')
			local color = require("utils.colors")
			require("scrollbar").setup({
				show = true,
				handle = {
					color = color.bg2
				},
				marks = {
					Error     = { text = {icons.error, icons.error}, color = color.error },
					Warn      = { text = {icons.warn, icons.warn}, color = color.warning },
					Info      = { text = {icons.info, icons.info}, color = color.info },
					Hint      = { text = {icons.hint, icons.hint}, color = color.comments },
					Search    = { text = "", color = color.white },
					GitAdd    = { text = icons.git_add, color = color.green },
					GitChange = { text = icons.git_change, color = color.blue },
					GitDelete = { text = icons.git_delete, color = color.red },
				}
			})
		end
	},
	{
		"ojroques/nvim-bufdel",
		cmd = {"BufDel"},
		event = "BufAdd",
		config = {
			next = 'cycle',  -- or 'alternate'
			quit = true,
		}
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require "colorizer".setup(
				{"*"},
				{
					RGB = true, -- #RGB hex codes
					RRGGBB = true, -- #RRGGBB hex codes
					RRGGBBAA = true, -- #RRGGBBAA hex codes
					rgb_fn = true, -- CSS rgb() and rgba() functions
					hsl_fn = true, -- CSS hsl() and hsla() functions
					css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					css_fn = true -- Enable all CSS *functions*: rgb_fn, hsl_fn
				}
			)
		end
	},
	{
		"mrjones2014/smart-splits.nvim",
		config = true,
	},
	{
		"numToStr/FTerm.nvim",
	},
	
	-- Measure startuptime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
}
