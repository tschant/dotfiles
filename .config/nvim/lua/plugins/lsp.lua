local utils = require("utils.core")
return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		-- LSP Installer
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"bash-language-server",
				"css-lsp",
				"dockerfile-language-server",
				"emmet-ls",
				-- "eslint_d",
				"biome",
				"eslint-lsp",
				"gofumpt",
				"jdtls",
				"jq",
				"json-lsp",
				"lua-language-server",
				-- "luasnip",
				"prettierd",
				"pyright",
				"shfmt",
				"sql-formatter",
				"sqlls",
				"stylelint-lsp",
				"stylua",
				-- "tailwindcss-language-server",
				"terraform-ls",
				"tflint",
				"typescript-language-server",
				"xmlformatter",
				"yaml-language-server",
				"yq",
				-- LSP
			},
			run_on_start = true,
			start_delay = 3000,
		})

		local lspconfig = require("lspconfig")
		local util = require("lspconfig/util")
		local cmp_lsp = require("cmp_nvim_lsp")

		-- local capabilities = vim.lsp.protocol.make_client_capabilities()
		-- capabilities = cmp_lsp.default_capabilities(capabilities)
		local capabilities = cmp_lsp.default_capabilities()
		capabilities.textDocument.colorProvider = {
			dynamicRegistration = true,
		}

		local servers = {
			bashls = {},
			cssls = {},
			clangd = {},
			dockerls = {},
			eslint = {
				cmd = { "eslint_d" },
			},
			gopls = {
				root_dir = util.root_pattern("go.work", "go.mod", ".git"),
				flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
				settings = {
					gopls = {
						analyses = {
							nilness = true,
							shadow = true,
							unusewrites = true,
							unusedparams = true,
							unreachable = true,
						},
						codelenses = {
							generate = true,
							gc_details = true,
							test = true,
							tidy = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						staticcheck = true,
						matcher = "Fuzzy",
						diagnosticsDelay = "500ms",
						experimentalPostfixCompletions = true,
						symbolMatcher = "fuzzy",
						gofumpt = true,
					},
				},
				init_options = {
					usePlaceholders = true,
				},
				filetypes = { "go", "gomod" },
			},
			html = { init_options = { provideFormatter = false } },
			jdtls = {},
			jsonls = {
				init_options = { provideFormatter = false },
				settings = {
					json = {
						validate = { enable = true },
					},
				},
			},
			pyright = {},
			rust_analyzer = {},
			stylelint_lsp = { autostart = false },
			lua_ls = {
				cmd = { "lua-language-server" },
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							path = { "lua/?.lua", "lua/?/init.lua" },
						},
						completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
						diagnostics = {
							enable = true,
							globals = {
								"vim",
								"describe",
								"it",
								"before_each",
								"after_each",
								"teardown",
								"pending",
								"use",
							},
							workspace = {
								library = {
									[vim.fn.expand("$VIMRUNTIME/lua")] = true,
									[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
								},
								maxPreload = 100000,
								preloadFileSize = 10000,
							},
						},
					},
				},
			},
			svelte = {},
			tailwindcss = {
				cmd = { "tailwindcss-language-server", "--stdio" },
			},
			terraform_lsp = {},
			tflint = {},
			biome = {},
			ts_ls = {
				cmd = { "typescript-language-server", "--stdio" },
				settings = {
					javascript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
					typescript = {
						inlayHints = {
							includeInlayEnumMemberValueHints = true,
							includeInlayFunctionLikeReturnTypeHints = true,
							includeInlayFunctionParameterTypeHints = true,
							includeInlayParameterNameHints = "all",
							includeInlayParameterNameHintsWhenArgumentMatchesName = true,
							includeInlayPropertyDeclarationTypeHints = true,
							includeInlayVariableTypeHints = true,
						},
					},
				},
			},
			yamlls = {},
		}

		local setup_server = function(server, config)
			config = vim.tbl_deep_extend("force", {
				on_attach = on_attach,
				capabilities = capabilities,
				flags = { debounce_text_changes = 150 },
			}, config)

			lspconfig[server].setup(config)
		end

		for server, config in pairs(servers) do
			setup_server(server, config)
		end

		-- Stop lsp diagnostics from showing virtual text
		vim.diagnostic.config({
			virtual_text = false, -- {spacing = 6, severity = "error"},
			update_in_insert = false,
			underline = true,
			signs = true,
		})

		local icons = require("utils.icons")
		vim.fn.sign_define("DiagnosticSignError", {
			texthl = "DiagnosticSignError",
			text = icons.error,
			numhl = "DiagnosticSignError",
		})
		vim.fn.sign_define("DiagnosticSignWarn", {
			texthl = "DiagnosticSignWarn",
			text = icons.warn,
			numhl = "DiagnosticSignWarn",
		})
		vim.fn.sign_define("DiagnosticSignInfo", {
			texthl = "DiagnosticSignInfo",
			text = icons.info,
			numhl = "DiagnosticSignInfo",
		})
		vim.fn.sign_define("DiagnosticSignHint", {
			texthl = "DiagnosticSignHint",
			text = icons.hint,
			numhl = "DiagnosticSignHint",
		})

		-- suppress error messages from lang servers
		-- vim.notify = function(msg, log_level, _)
		-- 	if msg:match("exit code") then
		-- 		return
		-- 	end
		-- 	if log_level == vim.log.levels.ERROR then
		-- 		vim.api.nvim_err_writeln(msg)
		-- 	else
		-- 		vim.api.nvim_echo({ { msg } }, true, {})
		-- 	end
		-- end
	end,
}
