local utils = require("utils.core")

return {
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufReadPre",
		enabled = true,
		opts = {
			mode = "cursor",
			max_lines = "15%",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		dependencies = {
			"ziontee113/syntax-tree-surfer",
			"peitalin/vim-jsx-typescript",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
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
					enable = false,
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
			})
		end,
		keys = {
			-- Syntax Tree Surfer - treesitter smart selection
			{
				"L",
				'<cmd>lua require("syntax-tree-surfer").surf("child", "visual")<cr>',
				desc = "Syntax surfer next",
				mode = { "x" },
			},
			{
				"H",
				'<cmd>lua require("syntax-tree-surfer").surf("parent", "visual")<cr>',
				desc = "Syntax Surfer prev",
				mode = { "x" },
			},
			{
				"gn",
				":lua require('syntax-tree-surfer').filtered_jump('default', true)<CR>",
				desc = "Filter Jump Next",
			},
			{
				"gN",
				":lua require('syntax-tree-surfer').filtered_jump('default', false)<CR>",
				desc = "Filter Jump Prev",
			},
			{
				"gj",
				function()
					require("syntax-tree-surfer").targeted_jump({
						"variable_declaration",
						"function",
						"if_statement",
						"else_clause",
						"else_statement",
						"elseif_statement",
						"for_statement",
						"while_statement",
						"switch_statement",
					})
				end,
				desc = "Jump ALL",
			},
			{ "vd", '<cmd>lua require("syntax-tree-surfer").move("n", false)<cr>', desc = "Move Up (syntax)" },
			{ "vn", '<cmd>lua require("syntax-tree-surfer").select_current_node()<cr>', desc = "Select current node" },
			{ "vu", '<cmd>lua require("syntax-tree-surfer").move("n", true)<cr>', desc = "Move Down (syntax)" },
			{ "vx", '<cmd>lua require("syntax-tree-surfer").select()<cr>', desc = "Select block/line" },
		},
	},
	{
		"windwp/nvim-ts-autotag",
		opts = {
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
			aliases = {
				["htmlangular"] = "html",
			},
		},
		ft = { "html", "htmlangular", "typescript", "typescriptreact", "vue" },
		main = "nvim-ts-autotag",
		event = "BufRead",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
}
