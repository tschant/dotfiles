local M = {
	"vimwiki/vimwiki",
	event = "VeryLazy"
}

M.config = function()
	-- global wiki settings
	vim.g.vimwiki_auto_header = 1
	vim.g.vimwiki_conceal_onechar_markers = 0
	vim.g.vimwiki_dir_link = 'index'
	vim.g.vimwiki_folding = 'expr'
	vim.g.vimwiki_use_calendar = 0

	wiki_prime = {
		auto_diary_index = 1,
		auto_generate_links = 1,
		auto_generate_tags = 1,
		auto_tags = 1,
		auto_toc = 1,
		automatic_nested_syntaxes = 1,
		diary_caption_level = 2,
		list_margin = 0,
		name = 'Notes',
		nested_syntaxes = {
			python = "python",
			lua = "lua"
		},
		path = '~/Notes',
		syntax = 'markdown',
		ext = '.md'
	}

	vim.g.vimwiki_list = {wiki_prime}
end

return M
