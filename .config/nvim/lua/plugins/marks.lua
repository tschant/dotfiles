local function save_mark()
	local char = vim.fn.getcharstr()
	-- Handle ESC, Ctrl-C, etc.
	if char == "" or vim.startswith(char, "<") then
		return
	end
	local grapple = require("grapple")
	local filepath = vim.api.nvim_buf_get_name(0)
	local filename = vim.fn.fnamemodify(filepath, ":t")
	if grapple.exists({ name = char, buffer = 0 }) then
		grapple.untag({ name = char })
		vim.notify("Unmarked " .. filename .. " as " .. char)
	else
		grapple.tag({ name = char })
		vim.notify("Marked " .. filename .. " as " .. char)
	end
end

local function open_mark()
	local char = vim.fn.getcharstr()
	-- Handle ESC, Ctrl-C, etc.
	if char == "" or vim.startswith(char, "<") then
		return
	end
	local grapple = require("grapple")
	if char == "'" then
		grapple.toggle_tags()
		return
	end
	grapple.select({ name = char })
end

return {
	{
		"cbochs/grapple.nvim",
		keys = {
			{ "m", save_mark, noremap = true, silent = true },
			{ "'", open_mark, noremap = true, silent = true },
		},
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
