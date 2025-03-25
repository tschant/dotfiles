return {
	{
		"cbochs/portal.nvim",
		dependencies = {
			"ThePrimeagen/harpoon",
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
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
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
				cancel_snipe = "<esc>",
				close_buffer = "D",
			},
			-- If you want the letters not to change, leave the sorting at default
			sort = "last",
		},
		config = true,
	},
}
