return {
	capabilities = require("servers.utils").capabilities(true),
	on_init = function(client, _)
		if client.server_capabilities then
			-- Disable ruff hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
			-- Disable ruff formatting in favor of Conform (ruff_format)
			-- NOTE: ruff-lsp's formatting is a bit buggy, doesn't respect indent_size
			client.server_capabilities.documentFormattingProvider = false
		end
	end,
	init_options = {
		settings = {
			lineLength = 100,
			configurationPreference = "editorFirst",
			organizeImports = false,
			showSyntaxErrors = true,
			logLevel = "info",
			fixAll = true,
			codeAction = {
				lint = {
					enable = true,
					preview = true,
				},
			},
			args = {
				"--preview", -- Use experimental features
				"--ignore",
				table.concat({
					"E111", -- indentation-with-invalid-multiple
					"E114", -- indentation-with-invalid-multiple-comment
					"E402", -- module-import-not-at-top-of-file
					"E501", -- line-too-long
					"E702", -- multiple-statements-on-one-line-semicolon
					"E731", -- lambda-assignment
					"F401", -- unused-import  (note: should be handled by pyright as 'hint')
				}, ","),
			},
		},
	},
}
