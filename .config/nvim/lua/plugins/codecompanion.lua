-- local function read_system_prompt(filepath)
--   local lines = vim.fn.readfile(filepath)
--   return table.concat(lines, "\n")
-- end
-- local system_prompt_path = vim.fn.expand("~/.config/nvim/prompts/avante_system_prompt.txt")
-- local system_prompt = read_system_prompt(system_prompt_path)

return {
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
	keys = {
		{ "<leader>m", group = "Code Companion" },
		{ "<leader>mc", "<cmd>CodeCompanionToggle<cr>", desc = "Toggle Code Companion" },
		{ "<leader>ma", "<cmd>CodeCompanionActions<cr>", desc = "Code Companion Actions prompt" },
	}
} ]]
