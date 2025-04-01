local M = {
	"hrsh7th/nvim-cmp",
	branch = "main",
	event = "InsertEnter",
	dependencies = {
		"windwp/nvim-autopairs",
		"onsails/lspkind-nvim",
		-- Completion/Snippets
		"saadparwaiz1/cmp_luasnip",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"f3fora/cmp-spell",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
		"chrisgrieser/cmp-nerdfont",
		"ray-x/cmp-treesitter",
		"jcha0713/cmp-tw2css",
	}
}

M.config = function()
	local icons = {
		Text = "  ",
		Method = " ƒ ",
		Function = "  ",
		Constructor = "  ",
		Variable = "  ",
		Class = "  ",
		TypeParameter = "  ",
		Interface = "  ",
		Module = "  ",
		Property = "  ",
		Unit = "  ",
		Value = "  ",
		Enum = "  ",
		Keyword = "  ",
		Snippet = " ﬌ ",
		Color = "  ",
		File = "  ",
		Folder = "  ",
		EnumMember = "  ",
		Constant = "   ",
		Struct = "   ",
		Event = "  ",
		Operator = "  ",
		Field = " ﰠ ",
		Reference = "  ",
	}

	vim.opt.completeopt = "menuone,noselect"

	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	require("nvim-autopairs").setup({
		check_ts = true,
	})

	local cmp = require("cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	cmp.setup {
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		formatting = {
			format = require("lspkind").cmp_format({
				mode = 'symbol',
				maxwidth = 50,
				ellipsis_char = '...',
				symbol_map = icons,
				menu = {
					nvim_lsp = "[LSP]",
					nvim_lua = "[VIM]",
					luasnip = "[SNIP]",
					buffer = "[BUF]",
					path = "[PATH]",
					emoji = "[EMOJI]",
					spell = "[SP]",
					treesitter = "[TREE]",
					nerdfont = "[NERD]",
					nvim_lsp_signature_help = "[SIG]",
				}
			}),
		},
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, {'i', 's'}),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.expand_or_jump(-1)
				else
					fallback()
				end
			end, {'i', 's'}),
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "treesitter" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "luasnip"--[[ , keyword_length = 3 ]] },
			{ name = "buffer", keyword_length = 3, max_item_count = 4 },
			{ name = "path" },
			{ name = 'cmp-tw2css' },
			{ name = "nvim_lua" },
			{ name = "nerdfont"},
			{ name = "emoji" },
			{ name = "spell", keyword_length = 4, keyword_pattern = [[\w\+]], max_item_count = 4 },
		},
	}

	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	require("luasnip/loaders/from_vscode").lazy_load()

end

return M
