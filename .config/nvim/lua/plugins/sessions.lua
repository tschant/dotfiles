local M = {
	{
		"GnikDroy/projections.nvim",
		event = "VeryLazy",
		config = function()
			require("projections").setup({
				workspaces = {
					{ "~/git", { ".git" } },
					{ "~/Notes", {} },
				},
				-- patterns = { ".git", ".svn", ".hg" },      -- Default patterns to use if none were specified. These are NOT regexps.
				-- store_hooks = { pre = nil, post = nil },   -- pre and post hooks for store_session, callable | nil
				-- restore_hooks = { pre = nil, post = nil }, -- pre and post hooks for restore_session, callable | nil
				-- workspaces_file = "path/to/file",          -- Path to workspaces json file
				-- sessions_directory = "path/to/dir",        -- Directory where sessions are stored
			})
		end
	},
	{
		"rmagatti/session-lens",
		event = "VeryLazy"
	},
	{
		"rmagatti/auto-session",
		event = "VimEnter"
	}
}

M.config = function()
	-- sesions stuff
	require('auto-session').setup {
		log_level = 'info',
		auto_restore_enabled = true,
		auto_session_use_git_branch = true,
		auto_session_suppress_dirs = {'~/', '~/git', '~/Downloads'}
	}
	require('session-lens').setup({
		theme_conf = {
			prompt_title = 'Sessions',
			previewer = false,
			borderchars = {
				prompt = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
				results = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
			}
		},
	})
end

return M
