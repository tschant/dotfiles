return {
	capabilities = require("servers.utils").capabilities(),
	settings = {
		pyright = {
			-- Using Ruff's import organizer
			disableOrganizeImports = true,
		},
		basedpyright = {
			disableOrganizeImports = true,
			analysis = {
				-- pythonPath = os.getenv('HOME') .. "/.pyenv/shims/python",
				diagnosticMode = "openFilesOnly",
				useTypingExtensions = true,
				typeCheckingMode = "basic",
				inlayHints = {
					callArgumentNames = true,
				},
			},
		},
	},
}
