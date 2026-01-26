-- Enhanced claudecode.nvim configuration with layout switching
-- Adapted from alex35mil's config

local CCProvider = nil

local function get_provider()
	if not CCProvider then
		CCProvider = require("plugins.ai.claudecode-provider").init({
			layout = {
				default = "side",
				side = {
					position = "right",
					width = 0.3,
				},
				float = {
					width = 0.6,
					height = 0.8,
					backdrop = false,
					border = "rounded",
				},
				common = {
					wo = {
						winbar = "",
						winhighlight = "Normal:Normal",
					},
				},
			},
		})
	end
	return CCProvider
end

---Helper to execute diff action and return focus to Claude
---@param action string The ClaudeCode command to run
local function diff_action_with_focus(action)
	vim.cmd(action)
	vim.defer_fn(function()
		get_provider().focus()
	end, 50)
end

return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	event = "VeryLazy",
	opts = function()
		return {
			terminal = {
				provider = get_provider(),
			},
			diff_opts = {
				auto_close_on_accept = true,
			},
		}
	end,
	keys = {
		-- Group
		{ "<leader>a", nil, desc = "AI/Claude Code" },

		-- Toggle Claude (side panel)
		{
			"<leader>ac",
			function()
				get_provider().open_on_side()
			end,
			mode = { "n", "i", "t", "v" },
			desc = "Toggle Claude (side)",
		},

		-- Toggle Claude (float)
		{
			"<leader>aF",
			function()
				get_provider().open_float()
			end,
			mode = { "n", "i", "t", "v" },
			desc = "Toggle Claude (float)",
		},

		-- Toggle layout while Claude is open
		{
			"<M-c>",
			function()
				get_provider().toggle_layout()
			end,
			mode = { "n", "i", "t", "v" },
			desc = "Toggle Claude layout",
		},

		-- Focus Claude
		{
			"<leader>af",
			function()
				get_provider().focus()
			end,
			desc = "Focus Claude",
		},

		-- Session management - continue
		{
			"<leader>aC",
			function()
				get_provider().open_on_side("continue")
			end,
			desc = "Continue session (side)",
		},

		-- Session management - resume
		{
			"<leader>ar",
			function()
				get_provider().open_on_side("resume")
			end,
			desc = "Resume session (side)",
		},

		-- Model selection
		{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select model" },

		-- Buffer/file operations
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
		{
			"<leader>as",
			"<cmd>ClaudeCodeTreeAdd<cr>",
			desc = "Add file",
			ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
		},

		-- Diff management with auto-focus back to Claude
		{
			"<leader>aa",
			function()
				diff_action_with_focus("ClaudeCodeDiffAccept")
			end,
			desc = "Accept diff",
		},
		{
			"<leader>ad",
			function()
				diff_action_with_focus("ClaudeCodeDiffDeny")
			end,
			desc = "Deny diff",
		},
	},
}
