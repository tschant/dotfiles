return {
	{
		'tpope/vim-dotenv',
		cmd = 'Dotenv',
	},
	{
		'tpope/vim-dadbod',
		event = "BufRead *.sql",
		cmd = 'DB',
	},
	{
	'kristijanhusak/vim-dadbod-ui',
	event = "BufRead *.sql",
	cmd = {
		'DB',
		'DBUIAddConnection',
	},
	dependencies = {
		'tpope/vim-dadbod'
	},
	config = function ()
		local g = vim.g
		g.db_ui_default_query = 'select * from "{table}" limit 50'
		g.db_ui_save_location = '~/Documents/queries/db_ui_queries'
		g.db_ui_debug = 1
		vim.cmd('set previewheight=25')
	end
}
}
