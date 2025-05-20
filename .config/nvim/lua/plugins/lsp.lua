local utils = require("utils.extra")

local servers = {
	bashls = {},
	cssls = {},
	clangd = {},
	dockerls = {},
	eslint = {
		cmd = { "eslint_d" },
	},
	--[[ gopls = {
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
	}, ]]
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
	pyright = { disableOrganizeImports = true },
	ruff = {
		init_options = {
			configuration = {
				lint = {
					ignore = { "E203", "E266", "E501", "W503", "F403", "F401" },
					select = { "B", "C", "E", "F", "W", "T4", "B9", "T001" },
					mccabe = {
						["max-complexity"] = 18,
					},
				},
			},
			settings = {
				lineLength = 100,
				configurationPreference = "editorFirst",
				organizeImports = true,
				showSyntaxErrors = true,
				logLevel = "info",
				fixAll = true,
				codeAction = {
					lint = {
						enable = true,
						preview = true,
					},
				},
			},
		},
	},
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
	terraformls = {},
	tflint = {},
	biome = {},
	ts_ls = {
		-- cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
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

return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		-- LSP Installer
		"williamboman/mason.nvim",
		-- "hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = utils.get_table_keys(servers),
		})

		local lspconfig = require("lspconfig")
		-- local util = require("lspconfig/util")
		-- local cmp_lsp = require("cmp_nvim_lsp")
		-- servers.gopls.root_dir = util.root_pattern("go.work", "go.mod", ".git")

		-- local capabilities = cmp_lsp.default_capabilities()
		--[[ capabilities.textDocument.colorProvider = {
			dynamicRegistration = true,
		} ]]

		local setup_server = function(server, config)
			local capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			config = vim.tbl_deep_extend("force", {
				-- on_attach = on_attach,
				capabilities = capabilities,
				flags = { debounce_text_changes = 150 },
			}, config)

			lspconfig[server].setup(config)
		end

		for server, config in pairs(servers) do
			setup_server(server, config)
		end

		-- Stop lsp diagnostics from showing virtual text
		local icons = require("utils.icons")
		vim.diagnostic.config({
			virtual_text = { current_line = true, severity = { min = "WARN", max = "ERROR" } }, -- {spacing = 6, severity = "error"},
			-- virtual_lines = { current_line = true, severity = { min = "ERROR" } },
			update_in_insert = false,
			underline = true,
			signs = {
				active = true,
				text = {
					[vim.diagnostic.severity.ERROR] = icons.error,
					[vim.diagnostic.severity.WARN] = icons.warn,
					[vim.diagnostic.severity.INFO] = icons.info,
					[vim.diagnostic.severity.HINT] = icons.hint,
				},
				texthl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
				},
			},
		})

		-- vim.fn.sign_define("DiagnosticSignError", {
		-- 	texthl = "DiagnosticSignError",
		-- 	text = icons.error,
		-- 	numhl = "DiagnosticSignError",
		-- })
		-- vim.fn.sign_define("DiagnosticSignWarn", {
		-- 	texthl = "DiagnosticSignWarn",
		-- 	text = icons.warn,
		-- 	numhl = "DiagnosticSignWarn",
		-- })
		-- vim.fn.sign_define("DiagnosticSignInfo", {
		-- 	texthl = "DiagnosticSignInfo",
		-- 	text = icons.info,
		-- 	numhl = "DiagnosticSignInfo",
		-- })
		-- vim.fn.sign_define("DiagnosticSignHint", {
		-- 	texthl = "DiagnosticSignHint",
		-- 	text = icons.hint,
		-- 	numhl = "DiagnosticSignHint",
		-- })

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
