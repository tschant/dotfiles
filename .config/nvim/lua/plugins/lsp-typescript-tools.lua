return {
	"pmizio/typescript-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig",
	},
	event = "BufReadPre",
	enabled = false,
	opts = {
		settings = {
			-- code_lens = "references_only",
			expose_as_code_action = {
				"fix_all",
				"add_missing_imports",
				"remove_unused",
			},
			publish_diagnostic_on = "insert_leave",
			tsserver_plugins = {
				"@styled/typescript-styled-plugin",
			},
			tsserver_file_preferences = {
				includeInlayParameterNameHints = "all",
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
	},
}
