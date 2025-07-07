return {
	capabilities = require("servers.utils").capabilities(true),
	default_config = {
		cmd = { "hausify" },
		filetypes = { "python" },
		root_markers = {
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"Pipfile",
			"pyrightconfig.json",
			".git",
		},
	},
}
