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

-- kommentary
-- vim.g.kommentary_create_default_mappings = false
require("kommentary.config").use_extended_mappings()

require("neoscroll").setup()

-- Autopairs
require("nvim-autopairs").setup()

-- Illuminate
vim.g.Illuminate_ftblacklist = {"NvimTree"}
vim.g.Illuminate_highlightUnderCursor = 0
vim.g.Illuminate_delay = 500

-- Git signs
require("gitsigns").setup {
	signs = {
		add = {hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
		change = {hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"},
		delete = {hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
		topdelete = {hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
		changedelete = {hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}
	},
	numhl = false,
	linehl = false,
	watch_index = {
		interval = 1000
	},
	sign_priority = 6,
	update_debounce = 200,
	status_formatter = nil, -- Use default
	use_decoration_api = false
}

-- CoC
-- vim.cmd('CocInstal coc-json coc-tsserver coc-html')
-- vim.g.coc_global_extensions={'coc-json','coc-tsserver','coc-html','coc-css','coc-spell-checker'}
vim.g.coc_global_extensions={'coc-spell-checker'}


-- Project.nvim
-- require'telescope'.load_extension('project')
require("project_nvim").setup({
	patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "docker-compose.yaml" },
})
