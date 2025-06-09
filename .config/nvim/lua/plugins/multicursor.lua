return {
	"wurli/visimatch.nvim",
	event = "BufRead",
	opts = {},
	keys = {
		{
			"<leader>ca",
			function()
				require("multicursor-nvim").alignCursors()
			end,
			desc = "Align cursors",
			mode = "n",
		},
		{
			"<leader>cA",
			function()
				require("multicursor-nvim").matchAllAddCursors()
			end,
			desc = "Match all",
		},
		{
			"<c-leftmouse>",
			function()
				require("multicursor-nvim").handleMouse()
			end,
			desc = "MultiCursor left-click",
		},
		{
			"<C-n>",
			function()
				require("multicursor-nvim").matchAddCursor(1)
			end,
			desc = "Match next cursor",
			mode = { "n", "v" },
		},
		{
			"<C-S-N>",
			function()
				require("multicursor-nvim").matchAddCursor(-1)
			end,
			desc = "Match prev cursor",
			mode = { "n", "v" },
		},
		{
			"<esc>",
			function()
				local mc = require("multicursor-nvim")
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				else
					-- Default <esc> handler.
				end
			end,
			desc = "Esc",
		},
	},
}
