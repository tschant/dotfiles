local M = {
	{
		"rmagatti/session-lens",
		-- event = "VeryLazy",
		config = {
			theme_conf = {
				prompt_title = 'Sessions',
				previewer = false,
				borderchars = {
					prompt = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
					results = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
				}
			},
		}
	},
	{
		"rmagatti/auto-session",
		-- event = "VimEnter",
		cmd = "RestoreSession",
		config = {
			log_level = 'info',
			auto_restore_enabled = false,
			auto_session_use_git_branch = true,
			auto_session_suppress_dirs = {'~/', '~/git', '~/Downloads'}
		}
	}
}

return M
