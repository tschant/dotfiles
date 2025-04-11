-- Autocomplete
-- https://cmp.saghen.dev

local trigger_text = ";"
local DISABLED_FILETYPES = {
	"DiffviewFileHistory",
	"DiffviewFiles",
	"checkhealth",
	"copilot-chat",
	"fugitive",
	"git",
	"gitcommit",
	"help",
	"lspinfo",
	"man",
	"neo-tree",
	"oil",
	"qf",
	"query",
	"scratch",
	"startuptime",
}

return {
	{
		"saghen/blink.compat",
		lazy = true,
		opts = {},
	},
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = {
			"chrisgrieser/cmp-nerdfont",
			"moyiz/blink-emoji.nvim",
			"Kaiser-Yang/blink-cmp-dictionary",
		},
		opts = {
			completion = {
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 100,
					window = {
						border = "single",
						max_height = 20,
						max_width = 50,
					},
				},
				list = {
					selection = {
						auto_insert = false,
					},
				},
				menu = {
					auto_show = false,
					border = "single",
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label" },
							{ "source_name" },
						},
						treesitter = { "lsp" },
					},
				},
				accept = {
					auto_brackets = {
						enabled = true,
						default_brackets = { ";", "" },
						override_brackets_for_filetypes = {
							markdown = { ";", "" },
						},
					},
				},
			},
			enabled = function()
				local buftype = vim.bo.buftype
				local filetype = vim.bo.filetype
				return not (
					buftype == "nofile"
					or buftype == "nowrite"
					or buftype == "prompt"
					or vim.tbl_contains(DISABLED_FILETYPES, filetype)
				)
			end,
			fuzzy = {
				implementation = "prefer_rust",
				sorts = { "exact", "score", "sort_text" },
			},
			keymap = {
				preset = "default",
				["<c-n>"] = { "select_next", "show", "fallback" },
				["<c-p>"] = { "select_prev", "fallback" },
				["<c-y>"] = { "select_and_accept" },
				["<cr>"] = { "select_and_accept", "fallback" },
				["<c-e>"] = { "hide" },
				["<c-]>"] = { "hide" },
				["<c-u>"] = { "scroll_documentation_up", "fallback" },
				["<c-d>"] = { "scroll_documentation_down", "fallback" },
			},
			signature = {
				enabled = true,
				window = {
					border = "single",
					max_height = 20,
					max_width = 50,
				},
			},
			cmdline = {
				enabled = true,
			},
			sources = {
				default = { "lsp", "path", "buffer", "dadbod", "emoji", "nerdfont", "dictionary" },
				providers = {
          nerdfont = {
            name = "nerdfont",
            module = "blink.compat.source",
            score_offset = 90,
          },
					lsp = {
						name = "lsp",
						enabled = true,
						module = "blink.cmp.sources.lsp",
						-- min_keyword_length = 2,
						score_offset = 90,
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 25,
						fallbacks = { "buffer" },
						-- min_keyword_length = 2,
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
							end,
							show_hidden_files_by_default = true,
						},
					},
					buffer = {
						name = "Buffer",
						enabled = true,
						max_items = 3,
						module = "blink.cmp.sources.buffer",
						-- min_keyword_length = 2,
						score_offset = 15,
					},
					-- Example on how to configure dadbod found in the main repo
					-- https://github.com/kristijanhusak/vim-dadbod-completion
					dadbod = {
						name = "Dadbod",
						module = "vim_dadbod_completion.blink",
						-- min_keyword_length = 2,
						score_offset = 85,
					},
					-- https://github.com/moyiz/blink-emoji.nvim
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 93,
						min_keyword_length = 2,
						opts = { insert = true },
					},
					-- https://github.com/Kaiser-Yang/blink-cmp-dictionary
					-- In macOS to get started with a dictionary:
					-- cp /usr/share/dict/words ~/.config/dictionaries/words.txt
					--
					-- NOTE: For the word definitions make sure "wn" is installed
					-- brew install wordnet
					dictionary = {
						module = "blink-cmp-dictionary",
						name = "Dict",
						score_offset = 10,
						enabled = true,
						max_items = 4,
						min_keyword_length = 3,
						opts = {
							dictionary_directories = { vim.fn.expand("~/.config/dictionaries") },
						},
					},
				},
			},
		},

		event = { "InsertEnter", "CmdlineEnter" },
	},
}
