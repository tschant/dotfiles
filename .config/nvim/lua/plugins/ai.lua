-- local function read_system_prompt(filepath)
--   local lines = vim.fn.readfile(filepath)
--   return table.concat(lines, "\n")
-- end
-- local system_prompt_path = vim.fn.expand("~/.config/nvim/prompts/avante_system_prompt.txt")
-- local system_prompt = read_system_prompt(system_prompt_path)

return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		config = true,
		keys = {
			{ "<leader>a", nil, desc = "AI/Claude Code" },
			{ "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
			{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
			{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>as",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file",
				ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
			},
			-- Diff management
			{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		},
	},
	{
		enabled = false,
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Never set this value to "*"! Never!
		opts = {
			-- add any opts here
			-- for example
			provider = "ollama",
			providers = {
				ollama = {
					api_key_name = "",
					endpoint = "http://192.168.86.48:7869",
					-- model = "qwen2.5-coder:7b",
					model = "codellama:7b",
					timeout = 30000,
					disable_tools = true,
				},
				--[[ claude = {
					endpoint = "https://api.anthropic.com",
					model = "claude-sonnet-4-20250514",
					timeout = 30000, -- Timeout in milliseconds
					extra_request_body = {
						temperature = 0.75,
						max_tokens = 20480,
					},
				}, ]]
			},
			-- system_prompt = system_prompt,
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
	},
	{
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
			"nvim-telescope/telescope.nvim", -- Optional
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
								auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
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
							-- url = "http://192.168.86.37:7869"
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
	},
}
--[[ return  ]]
