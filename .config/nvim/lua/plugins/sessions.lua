local M = {
	{
		"rmagatti/session-lens",
		-- event = "VeryLazy",
		config = function()
			-- sesions stuff
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
	},
	{
		"rmagatti/auto-session",
		-- event = "VimEnter",
		cmd = "RestoreSession",
		config = function()
			require('auto-session').setup {
				log_level = 'info',
				auto_restore_enabled = false,
				auto_session_use_git_branch = true,
				auto_session_suppress_dirs = {'~/', '~/git', '~/Downloads'}
			}
		end
	}
}

return M
