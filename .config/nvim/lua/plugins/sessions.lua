local M = {
	{"~/git/tschant/tds-projections.nvim", event = "VeryLazy"},
	{"rmagatti/session-lens", event = "VeryLazy"},
	{
		"rmagatti/auto-session",
		lazy = false
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
