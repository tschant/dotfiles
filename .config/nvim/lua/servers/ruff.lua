return {
	capabilities = require("servers.utils").capabilities(true),
	init_options = {
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
}
