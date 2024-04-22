-- local tmux = {}
-- if wezterm.target_triple == "aarch64-apple-darwin" then
-- 	tmux = { "/opt/homebrew/bin/tmux", "new", "-As0" }
-- else
-- 	tmux = { "tmux", "new", "-As0" }
-- end

local config = {
	default_workspace = "main",
	default_prog = {"/bin/zsh"},
	scrollback_lines = 3000,
	status_update_interval = 1000,
	hyperlink_rules = {
		-- Matches: a URL in parens: (URL)
		{
			regex = '\\((\\w+://\\S+)\\)',
			format = '$1',
			highlight = 1,
		},
		-- Matches: a URL in brackets: [URL]
		{
			regex = '\\[(\\w+://\\S+)\\]',
			format = '$1',
			highlight = 1,
		},
		-- Matches: a URL in curly braces: {URL}
		{
			regex = '\\{(\\w+://\\S+)\\}',
			format = '$1',
			highlight = 1,
		},
		-- Matches: a URL in angle brackets: <URL>
		{
			regex = '<(\\w+://\\S+)>',
			format = '$1',
			highlight = 1,
		},
		-- Then handle URLs not wrapped in brackets
		{
			regex = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
			format = '$0',
		},
		-- implicit mailto link
		{
			regex = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
			format = 'mailto:$0',
		},
	},
}

return config
