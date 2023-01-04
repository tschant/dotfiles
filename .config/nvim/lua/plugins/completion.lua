local M = {
	"hrsh7th/nvim-cmp",
	event = "BufReadPost",
	dependencies = {
		"windwp/nvim-autopairs",
		-- Completion/Snippets
		"onsails/lspkind-nvim",
		"L3MON4D3/LuaSnip",
		"rafamadriz/friendly-snippets",
		"hrsh7th/cmp-nvim-lua",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"f3fora/cmp-spell",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-emoji",
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

	-- symbols for autocomplete
	-- require("lspkind").init( {
	-- 	mode = 'symbol_text',
	-- 	symbol_map = icons
	-- })

	local present, luasnip = pcall(require, "luasnip")
	if present then
		luasnip.config.set_config {
			history = true,
			updateevents = "TextChanged,TextChangedI",
		}
		luasnip.filetype_extend("javascript", {"react"})
		luasnip.filetype_extend("typescript", {"react-ts"})
	end

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
				mode = 'symbol_text',
				symbol_map = icons,
				menu = {
					nvim_lsp = "[LSP]",
					nvim_lua = "[VIM]",
					luasnip = "[SNIP]",
					buffer = "[BUF]",
					path = "[PATH]",
					emoji = "[EMOJI]",
					spell = "[SP]",
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
			{ name = "nvim_lsp_signature_help", priority = 10 },
			{ name = "nvim_lsp", priority = 9 },
			{ name = "luasnip", priority = 8 },
			{ name = "buffer", priority = 7 },
			{ name = "nvim_lua", priority = 5 },
			{ name = "path", priority = 5 },
			{ name = "emoji", priority = 3 },
			{ name = "spell", priority = 1 },
		},
	}

	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	require("luasnip/loaders/from_vscode").lazy_load()

end

return M
