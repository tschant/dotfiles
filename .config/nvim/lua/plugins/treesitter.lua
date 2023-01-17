local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"p00f/nvim-ts-rainbow",
		"ziontee113/syntax-tree-surfer",
		"windwp/nvim-ts-autotag",
		"ckolkey/ts-node-action",
	},
	-- event = "BufReadPost",
}

M.config = function()
	-- Treesitter
	require "nvim-treesitter.configs".setup {
		ensure_installed = {
			"bash",
			"html",
			"css",
			"comment",
			"dockerfile",
			"go",
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
			"tsx",
			"typescript",
			"vim",
			"yaml",
		},-- "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
		ignore_install = {},
		sync_install = true,
		highlight = {
			enable = true,
			use_languagetree = true,
		},
		indent = {enable = true},
		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false -- Whether the query persists across vim sessions
		},
		rainbow = {enable = true, max_file_lines = 2000},
		autotag = {enable = true}
	}
end

return M