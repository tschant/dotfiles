local M = {
	{
		"rmagatti/session-lens",
		-- event = "VeryLazy",
		opts = {
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
		cmd = {"RestoreSession", "SaveSession"},
		opts = {
			log_level = 'info',
			auto_restore_enabled = false,
			auto_save_enabled = true,
			auto_session_use_git_branch = true,
			auto_session_suppress_dirs = {'~/', '~/git', '~/Downloads'}
		}
	}
}

return M
