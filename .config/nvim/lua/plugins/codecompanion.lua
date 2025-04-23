return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	opts = {
		-- add any opts here
		-- for example
		provider = "ollama",
		ollama = {
			__inherited_from = "openai",
			api_key_name = "",
			endpoint = "http://192.168.86.48:7869",
			model = "qwen2.5-coder:7b",
			timeout = 30000,
			disable_tools = true,
		},
	},
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
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
--[[ return {
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
} ]]
