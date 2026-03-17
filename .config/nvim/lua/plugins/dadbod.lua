return {
	{
		'tpope/vim-dotenv',
		cmd = 'Dotenv',
	},
	{
		"joryeugene/dadbod-grip.nvim",
		version = "v1.7.0",
		event = "BufRead *.sql",
		keys = {
			{ "<leader>ed", ":GripConnect<CR>", "Open Grip connection" },
		},
		opts = { picker = "snacks", completion = false },
	},
}
