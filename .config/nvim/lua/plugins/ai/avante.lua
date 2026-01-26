-- avante.nvim configuration (disabled)

return {
	enabled = false,
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		provider = "ollama",
		providers = {
			ollama = {
				api_key_name = "",
				endpoint = "http://192.168.86.48:7869",
				model = "codellama:7b",
				timeout = 30000,
				disable_tools = true,
			},
		},
	},
	build = "make",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"stevearc/dressing.nvim",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
}
