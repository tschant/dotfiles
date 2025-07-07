return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"gf",
				":lua require('conform').format({ async = true, lsp_fallback = true })<CR>",
				desc = "LSP Format file",
			},
		},
		config = function()
			require("conform").setup({
				formatters = {
					biome = {
						require_cwd = true,
					},
				},
				formatters_by_ft = {
					lua = { "stylua" },
					python = (function()
						-- Make sure cwd is always the project root to the file, so that
						-- the right config file (pyproject.toml, .style.yapf, etc.) is picked up
						local formatter_opts = require("conform").formatters
						local py_root = require("conform.util").root_file({
							"setup.py",
							"pyproject.toml",
							".flake8",
							".git",
						})
						formatter_opts["black"] = { cwd = py_root }
						formatter_opts["isort"] = { cwd = py_root }
						formatter_opts["ruff_format"] = { cwd = py_root }
						formatter_opts["ruff_organize_imports"] = { cwd = py_root }
						return { "ruff_organize_imports", "ruff_format" }
					end)(),
					-- python = { "black", "isort", "docformatter" },
					css = { "biome", "prettierd", "prettier", stop_after_first = true },
					scss = { "prettierd", "prettier", stop_after_first = true },
					less = { "prettierd", "prettier", stop_after_first = true },
					html = { "prettierd", "rettier", stop_after_first = true },
					markdown = { "prettierd", "prettier", stop_after_first = true },
					javascript = {
						-- "biome",
						"eslint_d",
						"prettierd",
					},
					typescript = {
						-- "biome",
						"eslint_d",
						"prettierd",
					},
					typescriptreact = {
						-- "biome",
						"eslint_d",
						"prettierd",
					},
					go = { "gofumpt" },
					json = { "biome", "jq" },
					yaml = { "yq" },
					xml = { "xmlformat" },
					csv = { "yq" },
					tsv = { "yq" },
					bash = { "shfmt" },
					zsh = { "shfmt" },
					sql = { "sql_formatter" },
				},
				-- format_on_save = {
				-- 	timeout_ms = 500,
				-- 	lsp_fallback = true,
				-- },
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "williamboman/mason.nvim", "nvimtools/none-ls.nvim" },
	},
	{
		"nvimtools/none-ls.nvim",
		event = "BufReadPre",
		dependencies = {
			"jay-babu/mason-null-ls.nvim",
			"nvimtools/none-ls-extras.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Formatters
					null_ls.builtins.formatting.google_java_format,

					-- Linters
					null_ls.builtins.diagnostics.alex,
					require("none-ls.diagnostics.eslint_d"),
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.diagnostics.tidy,
					null_ls.builtins.diagnostics.pmd.with({
						extra_args = { "-R", "rulesets/java/quickstart.xml" },
						--"~/.local/bin/pmd-bin-6.53.0/rulesets/eclipse-formatter-settings.xml"}
					}),
					null_ls.builtins.diagnostics.yamllint,
				},
			})

			require("mason-null-ls").setup({
				ensure_installed = nil,
				automatic_installation = true,
				automatic_setup = true,
			})
		end,
	},
}
