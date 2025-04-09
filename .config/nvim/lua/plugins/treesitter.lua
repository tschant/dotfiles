local utils = require("utils.core")

return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		enabled = true,
		opts = { mode = "cursor" },
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPre",
		dependencies = {
			"p00f/nvim-ts-rainbow",
			"ziontee113/syntax-tree-surfer",
			"windwp/nvim-ts-autotag",
			"peitalin/vim-jsx-typescript",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				ensure_installed = {
					"bash",
					"css",
					"csv",
					"comment",
					"dockerfile",
					"git_config",
					"gitcommit",
					"gitignore",
					"go",
					"graphql",
					"html",
					"http",
					"scss",
					"java",
					"javascript",
					"jq",
					"json",
					"json5",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"regex",
					"ruby",
					"rust",
					"scss",
					"sql",
					"terraform",
					"tsx",
					"typescript",
					"vim",
					"yaml",
					"xml",
				},
				ignore_install = {},
				sync_install = true,
				highlight = {
					enable = true,
					use_languagetree = true,
					disable = function(_, buf)
						return utils.disable_filesize_limit(buf)
					end,
				},
				indent = {
					enable = true,
					--[[ disable = function(_, buf)
					return utils.disable_filesize_limit(buf)
				end, ]]
				},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
				},
				rainbow = {
					enable = true,
					--[[ disable = function(_, buf)
					return utils.disable_filesize_limit(buf)
				end, ]]
				},
				autotag = {
					enable = true,
					--[[ disable = function(_, buf)
					return utils.disable_filesize_limit(buf)
				end, ]]
				},
			})
		end,
	},
}
