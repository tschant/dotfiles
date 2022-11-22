-- Single Line Configs
-- require("kommentary.config").use_extended_mappings()
require('Comment').setup()
require("neoscroll").setup()
require("nvim-autopairs").setup()
require("focus").setup()
require('portal').setup()
require('session-lens').setup({
	theme_conf = {
		prompt_title = 'Sessions',
		previewer = false,
		borderchars = {
			prompt = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
			results = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
		}
	},
})

require("icon-picker").setup({ disable_legacy_commands = true })

-- Illuminate
vim.g.Illuminate_ftblacklist = {"NvimTree"}
vim.g.Illuminate_highlightUnderCursor = 0
vim.g.Illuminate_delay = 500

-- vim-multi-visual
vim.g.VM_silent_exit = 1
-- vim.g.VM_set_statusline = 0

-- sesions stuff
require('auto-session').setup {
	log_level = 'info',
	auto_restore_enabled = true,
	auto_session_use_git_branch = true,
	auto_session_suppress_dirs = {'~/', '~/git', '~/Downloads'}
}

-- Scrollbar
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

-- Buf delete
require('bufdel').setup {
  next = 'cycle',  -- or 'alternate'
  quit = true,
}

-- hlslens (search function)
require("hlslens").setup({
	build_position_cb = function(plist, bufnr, changedtick, pattern)
		-- require('scrollbar.handlers.search').handler.show(plist.start_pos)
		require('scrollbar').search_handler.show(plist.start_pos)
	end
})

-- Colorizer
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

-- Pretty Fold
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
require('fold-preview').setup()

-- Surround
require("nvim-surround").setup({
	-- Configuration here, or leave empty to use defaults
})

-- Treesitter
require "nvim-treesitter.configs".setup {
	ensure_installed = {
		"bash",
		"html",
		"css",
		"dockerfile",
		"http",
		"java",
		"javascript",
		"json",
		"json5",
		"lua",
		"markdown",
		"python",
		"regex",
		"ruby",
		"rust",
		"typescript",
		"vim",
		"yaml",
	},-- "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	highlight = {
		enable = true -- false will disable the whole extension
	},
	indent = {enable = true},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false -- Whether the query persists across vim sessions
	},
	rainbow = {enable = true},
	autotag = {enable = true}
}

require('dressing').setup({
	select = {
		telescope = {
			layout_config = {
				width = 120,
				height = 25,
			},
		},
	},
})
