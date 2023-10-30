local function ts_disable(buf)
	local max_filesize = 100 * 1024 -- 100 KB
	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
	if ok and stats and stats.size > max_filesize then
		return true
	end
end

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
		opts = {
			auto_install = true,
			ensure_installed = {
				"bash",
				"html",
				"css",
				-- "comment",
				"dockerfile",
				"go",
				"graphql",
				"http",
				"scss",
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
				"xml",
			}, -- "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
			ignore_install = {},
			sync_install = true,
			highlight = {
				enable = true,
				use_languagetree = true,
				disable = function(_, buf)
					return ts_disable(buf)
				end,
			},
			indent = {
				enable = true,
				--[[ disable = function(_, buf)
					return ts_disable(buf)
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
					return ts_disable(buf)
				end, ]]
			},
			autotag = {
				enable = true,
				--[[ disable = function(_, buf)
					return ts_disable(buf)
				end, ]]
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"p00f/nvim-ts-rainbow",
			"ziontee113/syntax-tree-surfer",
			"windwp/nvim-ts-autotag",
			"peitalin/vim-jsx-typescript",
		},
	},
}
