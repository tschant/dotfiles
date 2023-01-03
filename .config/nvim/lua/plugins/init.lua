return {
	-- Window splitting
	"beauwilliams/focus.nvim",

	-- Markdown
	{"iamcco/markdown-preview.nvim", build = "cd app && yarn install", event = "BufRead *.md"},

	-- JS/html
	{"scrooloose/syntastic", event = "BufReadPre"},
	{"groenewege/vim-less", event = "BufReadPre *.(js|html|less|css|scss)"},
	{"hail2u/vim-css3-syntax", event = "BufReadPre *.(css|less|scss)"},
	{"maxmellon/vim-jsx-pretty", event = "BufReadPre *.(js|ts)x"},
	{"pangloss/vim-javascript", event = "BufReadPre *.(js|ts)x?"},
	{"ryym/vim-riot", event = "BufReadPre *.(js|tag)"},
	{"mattn/emmet-vim", event = "BufReadPre"},

	-- Terraform
	{'hashivim/vim-terraform', event = "BufReadPre *.tf"},
	{'juliosueiras/vim-terraform-completion', event = "BufRead *.tf"},

	-- General plugins
	{"numToStr/Comment.nvim", tag = "v0.6", event = "BufReadPost"},
	{"cbochs/portal.nvim", event = "VeryLazy"},
	{"karb94/neoscroll.nvim", event = "BufReadPre"},
	{"kylechui/nvim-surround", event = "BufReadPre"},
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
		config = function() 
			require('fold-preview').setup()
		end
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
		event = "VeryLazy",
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
		event = "VeryLazy",
		config = function()
			local color = require("utils.colors")
			require("scrollbar").setup({
				show = true,
				handle = {
					color = color.bg2
				},
				marks = {
					Error     = { color = color.error },
					Warn      = { color = color.warning },
					Info      = { color = color.info },
					Hint      = { color = color.comments },
					Search    = { text = "", color = color.white },
					GitAdd    = { text = "⊕", color = color.green },
					GitChange = { text = "⌾", color = color.blue },
					GitDelete = { text = "⊖", color = color.red },
				}
			})
		end
	},
	{
		"ojroques/nvim-bufdel",
		event = "VimEnter",
		config = function()
			require('bufdel').setup {
				next = 'cycle',  -- or 'alternate'
				quit = true,
			}

		end
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "VimEnter",
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
		"ziontee113/icon-picker.nvim",
		event = "BufReadPost",
		config = function() 
			require("icon-picker").setup({ disable_legacy_commands = true })
		end
	},
}
