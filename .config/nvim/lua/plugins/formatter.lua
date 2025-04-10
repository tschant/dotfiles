return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters = {
				biome = {
					require_cwd = true,
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				css = { "biome", "prettierd", "prettier", stop_after_first = true },
				scss = { "prettierd", "prettier", stop_after_first = true },
				less = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				javascript = {
					"biome",
					"eslint_d",
					"prettierd" --[[ , "prettier", "eslint" ]] --[[ , stop_after_first = true ]],
				},
				typescript = {
					"biome",
					"eslint_d",
					"prettierd" --[[ , "prettier", "eslint" ]] --[[ , stop_after_first = true ]],
				},
				typescriptreact = {
					"biome",
					"eslint_d",
					"prettierd" --[[ , "prettier", "eslint" ]] --[[ , stop_after_first = true ]],
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
		},
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
					-- Code Actions
					-- null_ls.builtins.code_actions.eslint_d,
					-- null_ls.builtins.code_actions.shellcheck,
					-- null_ls.builtins.code_actions.cspell,

					-- Completion
					-- null_ls.builtins.completion.luasnip,
					-- null_ls.builtins.completion.spell,

					-- Formatters
					-- null_ls.builtins.formatting.codespell,
					-- null_ls.builtins.formatting.eslint_d,
					null_ls.builtins.formatting.google_java_format,
					-- null_ls.builtins.formatting.gofumpt,
					-- null_ls.builtins.formatting.jq,
					-- null_ls.builtins.formatting.yq.with({
					-- 	filetypes = { "yaml", "yml", "xml", "csv", "tsv" },
					-- }),
					-- null_ls.builtins.formatting.tidy,
					-- null_ls.builtins.formatting.prettierd.with({
					-- 	filetypes = { "markdown", "css", "scss", "less", "html" },
					-- }),
					-- null_ls.builtins.formatting.shfmt,
					-- null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.formatting.tflint,
					-- null_ls.builtins.formatting.sqlfluff.with({
					-- 	extra_args = {"--dialect", "mysql", "-e", "L003,L059,L063,L013,L016,L006,L048"}
					-- }),
					-- null_ls.builtins.formatting.terraform_fmt,

					-- Linters
					null_ls.builtins.diagnostics.alex,
					-- null_ls.builtins.diagnostics.cspell,
					require("none-ls.diagnostics.eslint_d"),
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.diagnostics.tidy,
					null_ls.builtins.diagnostics.pmd.with({
						extra_args = { "-R", "rulesets/java/quickstart.xml" },
						--"~/.local/bin/pmd-bin-6.53.0/rulesets/eclipse-formatter-settings.xml"}
					}),
					-- null_ls.builtins.diagnostics.luacheck,
					-- null_ls.builtins.diagnostics.shellcheck,
					-- null_ls.builtins.diagnostics.stylelint,
					-- null_ls.builtins.diagnostics.sqlfluff.with({
					-- 	extra_args = {"--dialect", "mysql", "-e", "L003,L059,L063,L013,L006,L048"}
					-- }),
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
