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
	{
		"fnune/recall.nvim",
		opts = {},
		keys = {
			{ "mm", "<cmd>RecallToggle<cr>", mode = "n", silent = true },
			{ "mn", "<cmd>RecallNext<cr>", mode = "n", silent = true },
			{ "mp", "<cmd>RecallPrevious<cr>", mode = "n", silent = true },
			{ "mc", "<cmd>RecallClear<cr>", mode = "n", silent = true },
			{ "ml", "<cmd>Telescope recall<cr>", mode = "n", silent = true },
		},
	},
	-- mx              Set mark x
	-- m,              Set the next available alphabetical (lowercase) mark
	-- m;              Toggle the next available mark at the current line
	-- dmx             Delete mark x
	-- dm-             Delete all marks on the current line
	-- dm<space>       Delete all marks in the current buffer
	-- m]              Move to next mark
	-- m[              Move to previous mark
	-- m:              Preview mark. This will prompt you for a specific mark to
	--                 preview; press <cr> to preview the next mark.
	--
	-- m[0-9]          Add a bookmark from bookmark group[0-9].
	-- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
	-- m}              Move to the next bookmark having the same type as the bookmark under
	--                 the cursor. Works across buffers.
	-- m{              Move to the previous bookmark having the same type as the bookmark under
	--                 the cursor. Works across buffers.
	-- dm=             Delete the bookmark under the cursor.
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
