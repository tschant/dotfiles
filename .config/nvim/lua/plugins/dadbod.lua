return {
	{
		'tpope/vim-dotenv',
		cmd = 'Dotenv',
	},
	{
		'pbogut/vim-dadbod-ssh',
		event = "BufRead *.sql",
		-- cmd = {
		-- 	'DB',
		-- 	'DBUIToggle'
		-- },
	},
	{
		'tpope/vim-dadbod',
		event = "BufRead *.sql",
		cmd = {
			'DB',
			'DBUIAddConnection',
			'DBUIToggle',
		},
	},
	{
		'kristijanhusak/vim-dadbod-ui',
		event = "BufRead *.sql",
		cmd = {
			'DB',
			'DBUIAddConnection',
			'DBUIToggle',
		},
		dependencies = {
			'tpope/vim-dadbod'
		},
		config = function ()
			local g = vim.g
			g.db_ui_default_query = 'select * from "{table}" limit 50'
			g.db_ui_table_helpers = {
				mysql = {
					Count = 'select count(*) from `{dbname}`.`{table}`;',
					List = 'select * from `{dbname}`.`{table}` limit 50\\G',
				},
			}
			g.db_ui_save_location = '~/Documents/queries/db_ui_queries'
			g.db_ui_debug = 1
			g.db_async = 1
			vim.cmd('set previewheight=25')
		end
	},
	{
		'napisani/nvim-dadbod-bg',
		build = './install.sh',
		event = "BufRead *.sql",
		-- (optional) the default port is 4546
		-- (optional) the log file will be created in the system's temp directory 
		config = function()
			vim.cmd([[
			let g:nvim_dadbod_bg_port = '4546'
			let g:nvim_dadbod_bg_log_file = '/tmp/nvim-dadbod-bg.log'
			]])
		end
	}
}
