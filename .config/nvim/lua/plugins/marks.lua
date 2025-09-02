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
			--[[ {
			"<leader>'i",
			':lua require("portal.builtin").jumplist.tunnel({direction = "forward"})<CR>',
			desc = "Portal Forward",
		},
		{
			"<leader>'o",
			':lua require("portal.builtin").jumplist.tunnel({direction = "backward"})<CR>',
			desc = "Portal Back",
		}, ]]
			{ "<leader>'q", ':lua require("portal.builtin").quickfix.tunnel({})<CR>', desc = "Portal Quickfix" },
		},
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>'D",
				function()
					require("harpoon"):list():clear()
				end,
				desc = "Clear list",
			},
			{
				"<leader>'m",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Add file",
			},
			{
				"<leader>'n",
				function()
					require("harpoon"):list():remove()
				end,
				desc = "Remove file",
			},
			{
				"<leader>''",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Quick menu",
			},
			{
				"<leader>'l",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Quick menu",
			},
		},
		config = function()
			local wk = require("which-key")
			for c = 1, 5 do
				wk.add({
					{
						"<C-" .. c .. ">",
						function()
							require("harpoon"):list():select(c)
						end,
						desc = "Harpoon " .. c,
					},
				})
			end
		end,
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
		"fnune/recall.nvim",
		opts = {},
		keys = {
			{ "mm", "<cmd>RecallToggle<cr>", mode = "n", silent = true },
			{ "mn", "<cmd>RecallNext<cr>", mode = "n", silent = true },
			{ "mp", "<cmd>RecallPrevious<cr>", mode = "n", silent = true },
			{ "mc", "<cmd>RecallClear<cr>", mode = "n", silent = true },
			{ "ml", "<cmd>Telescope recall<cr>", mode = "n", silent = true },
			--[[
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
			--]]
		},
	},
	{
		"chentoast/marks.nvim",
		event = "VeryLazy",
		opts = {},
	},
}
