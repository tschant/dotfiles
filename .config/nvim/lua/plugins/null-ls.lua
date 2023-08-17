local M = {
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {"williamboman/mason.nvim", "jose-elias-alvarez/null-ls.nvim"},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = {
			"jay-babu/mason-null-ls.nvim"
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					-- Code Actions
					null_ls.builtins.code_actions.eslint_d,
					null_ls.builtins.code_actions.shellcheck,
					-- null_ls.builtins.code_actions.cspell,
					-- Completion
					null_ls.builtins.completion.luasnip,
					-- null_ls.builtins.completion.spell,
					-- Formatters
					-- null_ls.builtins.formatting.codespell,
					null_ls.builtins.formatting.eslint_d,
					null_ls.builtins.formatting.google_java_format,
					null_ls.builtins.formatting.gofumpt,
					null_ls.builtins.formatting.jq,
					null_ls.builtins.formatting.yq.with({
						filetypes = {"yaml", "yml", "xml", "csv", "tsv"}
					}),
					-- null_ls.builtins.formatting.tidy,
					null_ls.builtins.formatting.prettierd.with({
						filetypes = {"markdown", "css", "scss", "less", "html"}
					}),
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.formatting.tflint,
					-- null_ls.builtins.formatting.sqlfluff.with({
					-- 	extra_args = {"--dialect", "mysql", "-e", "L003,L059,L063,L013,L016,L006,L048"}
					-- }),
					null_ls.builtins.formatting.terraform_fmt,
					-- Linters
					null_ls.builtins.diagnostics.alex,
					-- null_ls.builtins.diagnostics.cspell,
					null_ls.builtins.diagnostics.eslint_d,
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.diagnostics.tidy,
					null_ls.builtins.diagnostics.pmd.with({
						extra_args = { "-R", "rulesets/java/quickstart.xml"}
						--"~/.local/bin/pmd-bin-6.53.0/rulesets/eclipse-formatter-settings.xml"}
					}),
					null_ls.builtins.diagnostics.luacheck,
					null_ls.builtins.diagnostics.shellcheck,
					-- null_ls.builtins.diagnostics.stylelint,
					-- null_ls.builtins.diagnostics.sqlfluff.with({
					-- 	extra_args = {"--dialect", "mysql", "-e", "L003,L059,L063,L013,L006,L048"}
					-- }),
					null_ls.builtins.diagnostics.yamllint,
				}
			})

			require("mason-null-ls").setup({
				ensure_installed = nil,
				automatic_installation = true,
				automatic_setup = true,
			})
		end
	},
}

return M
