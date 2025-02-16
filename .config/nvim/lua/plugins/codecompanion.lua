return {
  "olimorris/codecompanion.nvim",
	cmd = {
		"CodeCompanion",
		"CodeCompanionChat",
		"CodeCompanionToggle",
		"CodeCompanionActions",
		"CodeCompanionAdd",
	},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- Optional
  },
	opts = {
		strategies = {
			chat = {
				adapter = "ollama",
			},
			inline = {
				adapter = "ollama",
			},
			agent = {
				adapter = "ollama",
			},
		},
		adapters = {
			ollama = function()
				return require("codecompanion.adapters").extend("ollama", {
					env = {
						-- url = "http://192.168.86.37:7869"
						url = "http://192.168.86.48:7869"
					},
					name = "dolphin-mistral",
					schema = {
						model = {
							default = "dolphin-mistral:latest",
						},
						num_ctx = {
							default = 16384,
						},
						num_predict = {
							default = -1,
						},
					},
				})
			end,
		},
	},
}
