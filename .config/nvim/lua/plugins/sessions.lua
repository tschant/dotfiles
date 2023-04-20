local M = {
	{
		"rmagatti/session-lens",
		-- event = "VeryLazy",
		config = true,
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
		-- event = "VeryLazy",
		-- cmd = {"RestoreSession", "SaveSession"},
		config = function() 
			require('auto-session').setup({
				log_level = 'info',
				auto_restore_enabled = false,
				auto_save_enabled = true,
				auto_session_use_git_branch = true,
				auto_session_suppress_dirs = {'~/', '~/git', '~/Downloads'}
			})
		end
	}
}

return M
