return {
	{
		"otavioschwanck/arrow.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {
			show_icons = true,
			buffer_leader_key = "<leader>m",
		},
		keys = {
			{ ";",         ":lua require('arrow.ui').openMenu()<CR>",        { noremap = true, silent = true, nowait = true, desc = "Arrow File Mappings" } },
			{ "<leader>m", ":lua require('arrow.buffer_ui').openMenu()<CR>", { noremap = true, silent = true, nowait = true, desc = "Arrow Buffer Mappings" } }
		}
	},
	{
		"cbochs/portal.nvim",
		dependencies = {
			"cbochs/grapple.nvim",
		},
		config = true,
		opts = {
			max_results = 8,
			labels = {
				"h",
				"j",
				"k",
				"l",
				"a",
				"s",
				"d",
				"f",
			},
			window_options = {
				relative = "cursor",
				width = 80,
				height = 5,
				col = 2,
				focusable = false,
				border = "single",
				noautocmd = true,
			},
		},
		keys = {

			{
				"<leader>i",
				':lua require("portal.builtin").jumplist.tunnel({direction = "forward"})<CR>',
				desc = "Portal Forward",
			},
			{
				"<leader>o",
				':lua require("portal.builtin").jumplist.tunnel({direction = "backward"})<CR>',
				desc = "Portal Back",
			},
			{
				"<leader>'c",
				':lua require("portal.builtin").changelist.tunnel({direction = "backward"})<CR>',
				desc = "Portal Changelist",
			},
			{
				"<leader>'C",
				':lua require("portal.builtin").changelist.tunnel({direction = "forward"})<CR>',
				desc = "Portal Changelist",
			},
			{
				"<C-i>",
				':lua require("portal.builtin").jumplist.tunnel({direction = "forward"})<CR>',
				desc = "Portal Forward",
			},
			{
				"<C-o>",
				':lua require("portal.builtin").jumplist.tunnel({direction = "backward"})<CR>',
				desc = "Portal Back",
			},
			{ "<leader>'q", ':lua require("portal.builtin").quickfix.tunnel({})<CR>', desc = "Portal Quickfix" },
		},
	},
	{
		"leath-dub/snipe.nvim",
		opts = {
			hints = {
				-- Charaters to use for hints
				-- make sure they don't collide with the navigation keymaps
				-- If you remove `j` and `k` from below, you can navigate in the plugin
				-- dictionary = "sadflewcmpghio",
				-- dictionary = "asfghl;wertyuiop",
				dictionary = "12345",
			},
			navigate = {
				cancel_snipe = { "<esc>", "q" },
				close_buffer = "D",
			},
			ui = {
				persist_tags = false,
			},
			-- If you want the letters not to change, leave the sorting at default
			sort = "last",
		},
		config = true,
		keys = {
			{
				"<C-Space>",
				function()
					require("snipe").open_buffer_menu()
				end,
				desc = "Open Snipe buffer menu",
			},
		},
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
