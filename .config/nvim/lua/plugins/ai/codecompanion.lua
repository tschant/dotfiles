-- codecompanion.nvim configuration (disabled)

return {
	enabled = false,
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
		"nvim-telescope/telescope.nvim",
	},
	opts = {
		strategies = {
			chat = {
				adapter = "claude",
			},
			inline = {
				adapter = "claude",
			},
			agent = {
				adapter = "claude",
			},
		},
		adapters = {
			acp = {
				claude_cli = function()
					return require("codecompanion.adapters").extend("claude_cli", {
						defaults = {
							auth_method = "oauth-personal",
						},
						env = {
							GEMINI_API_KEY = "cmd:op read op://personal/Gemini_API/credential --no-newline",
						},
					})
				end,
			},
			ollama = function()
				return require("codecompanion.adapters").extend("ollama", {
					env = {
						url = "http://192.168.86.48:7869",
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
	keys = {
		{ "<leader>m", group = "Code Companion" },
		{ "<leader>mc", "<cmd>CodeCompanionToggle<cr>", desc = "Toggle Code Companion" },
		{ "<leader>ma", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions prompt" },
	},
}
