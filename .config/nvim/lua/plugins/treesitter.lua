local M = {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	dependencies = {
		"p00f/nvim-ts-rainbow",
		"ziontee113/syntax-tree-surfer",
		"windwp/nvim-ts-autotag",
	},
	event = "BufReadPost",
}

M.config = function()
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
end

return M
