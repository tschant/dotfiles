local M = {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		-- LSP Installer
		"williamboman/mason.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
}

M.config = function()
	require('mason').setup()
	require('mason-tool-installer').setup({
		ensure_installed = {
			"tflint",
			"stylelint-lsp",
			-- LSP
			"bash-language-server",
			"typescript-language-server",
			"tailwindcss-language-server",
			"css-lsp",
			"pyright",
			"json-lsp",
			"terraform-ls",
			"yaml-language-server",
			"jdtls",
			"sqlls",
			"emmet-ls",
			"dockerfile-language-server",
		},
		run_on_start = true,
		start_delay = 3000,
	})

	local lspconfig = require("lspconfig")
	local cmp_lsp = require("cmp_nvim_lsp")

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = cmp_lsp.default_capabilities(capabilities)
	capabilities.textDocument.colorProvider = {
		dynamicRegistration = true,
	}

	local servers = {
		bashls = {},
		cssls = {},
		clangd = {},
		dockerls = {},
		eslint = {},
		gopls = {
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
					experimentalWatchedFileDelay = "100ms",
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
		stylelint_lsp = { autostart = false, },
		sumneko_lua = {
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
		tailwindcss = {},
		terraform_lsp = {},
		tflint = {},
		tsserver = {},
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
		virtual_text = {spacing = 6, severity = "error"}, -- = false,
		update_in_insert = false,
		underline = true,
		signs = true,
		update_in_insert = false
	})
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false, border = "single" })
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { focusable = false, border = "single" })

	vim.fn.sign_define(
		"LspDiagnosticsSignError",
		{
			texthl = "LspDiagnosticsSignError",
			text = "",
			numhl = "LspDiagnosticsSignError"
		}
	)
	vim.fn.sign_define(
		"LspDiagnosticsSignWarning",
		{
			texthl = "LspDiagnosticsSignWarning",
			text = "",
			numhl = "LspDiagnosticsSignWarning"
		}
	)
	vim.fn.sign_define(
		"LspDiagnosticsSignInformation",
		{
			texthl = "LspDiagnosticsSignInformation",
			text = "",
			numhl = "LspDiagnosticsSignInformation"
		}
	)
	vim.fn.sign_define(
		"LspDiagnosticsSignHint",
		{
			texthl = "LspDiagnosticsSignHint",
			text = "",
			numhl = "LspDiagnosticsSignHint"
		}
	)

	-- suppress error messages from lang servers
	vim.notify = function(msg, log_level, _)
		if msg:match("exit code") then
			return
		end
		if log_level == vim.log.levels.ERROR then
			vim.api.nvim_err_writeln(msg)
		else
			vim.api.nvim_echo({ { msg } }, true, {})
		end
	end
end

return M
