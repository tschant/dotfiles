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
					kulala = {
						command = "kulala-fmt",
						args = { "format", "$FILENAME" },
						stdin = false,
					},
				},
				formatters_by_ft = {
					lua = { "stylua" },
					http = { "kulala" },
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
						formatter_opts["ruff_format"] = { cwd = py_root }
						formatter_opts["ruff_organize_imports"] = { cwd = py_root }
						return { "ruff_organize_imports", "ruff_format" }
					end)(),
					-- python = { "black", "isort", "docformatter" },
					css = { "biome", "prettierd", "prettier", stop_after_first = true },
					scss = { "prettierd", "prettier", stop_after_first = true },
					less = { "prettierd", "prettier", stop_after_first = true },
					html = { "prettierd", "prettier", stop_after_first = true },
					markdown = { "prettierd", "prettier", stop_after_first = true },
					javascript = {
						-- "biome",
						"eslint",
						-- "eslint_d",
						"prettierd",
						"prettier",
					},
					typescript = {
						-- "biome",
						"eslint",
						-- "eslint_d",
						"prettierd",
						"prettier",
					},
					typescriptreact = {
						-- "biome",
						"eslint",
						-- "eslint_d",
						"prettierd",
						"prettier",
					},
					-- go = { "gofumpt" },
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
}
