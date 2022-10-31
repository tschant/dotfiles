-- Single Line Configs
-- require("kommentary.config").use_extended_mappings()
require('Comment').setup()
require("neoscroll").setup()
require("nvim-autopairs").setup()
require("focus").setup()
-- require('leap').add_default_mappings()

-- Illuminate
vim.g.Illuminate_ftblacklist = {"NvimTree"}
vim.g.Illuminate_highlightUnderCursor = 0
vim.g.Illuminate_delay = 500

-- Scrollbar
local color = require("colors").dark
require("scrollbar").setup({
	handle = {
		color = color.bg2
	},
	marks = {
		Error = { color = color.error },
		Warn = { color = color.warning },
		Info = { color = color.info },
		Hint = { color = color.comments },
		Search = { color = color.DarkGoldenrod2 },
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
		require('scrollbar').search_handler.show(plist.start_pos)
	end
})

-- Project.nvim
require("project_nvim").setup({
	manual_mode = true,
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "docker-compose.yaml" },
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
require("hlslens").setup({
	calm_down = true
})

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

-- Indent Guides
require("indent_guides").setup(
	{
		indent_levels = 30,
		indent_guide_size = 1,
		indent_start_level = 1,
		indent_space_guides = true,
		indent_tab_guides = true,
		indent_soft_pattern = "\\s",
		exclude_filetypes = {"help", "dashboard", "startify", "NvimTree", "vista", "sagahover"},
		even_colors = {fg = "#2a383477", bg = "#332b36"},
		odd_colors = {fg = "#332b3677", bg = "#2a3834"}
	}
)

require("indent_blankline").setup {
	space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	filetype_exclude = {"help", "dashboard", "startify", "NvimTree", "vista", "sagahover"},
}
