return {
	capabilities = require("servers.utils").capabilities(true),
	cmd = { "eslint_d" },
	settings = {
		workingDirectory = { mode = "auto" },
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = "separateLine",
			},
			showDocumentation = {
				enable = false, -- <-- this, doesn't apply
			},
		},
		codeActionOnSave = {
			enable = false, -- <-- this either
			mode = "all",
		},
		format = false,
		quiet = true,
		run = "onSave",
	},
	flags = {
		allow_incremental_sync = false,
		debounce_text_changes = 1000,
	},
}
