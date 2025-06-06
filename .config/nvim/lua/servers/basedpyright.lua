return {
	capabilities = require("servers.utils").capabilities(),
	disableOrganizeImports = true,
	settings = {
		basedpyright = {
			analysis = {
				diagnosticMode = "openFilesOnly",
				typeCheckingMode = "off",
				extraPaths = {"~/git/api"},
				inlayHints = {
					callArgumentNames = true,
				},
			},
		},
	},
}
