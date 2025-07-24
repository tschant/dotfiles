local function format(opts)
	-- always show first and second label
	return {
		{ opts.match.label1, "FlashMatch" },
		{ opts.match.label2, "FlashLabel" },
	}
end

return {
	{
		"MagicDuck/grug-far.nvim",
		-- Note (lazy loading): grug-far.lua defers all it's requires so it's lazy by default
		-- additional lazy config to defer loading is not really needed...
		opts = {
			showCompactInputs = true,
			showInputsTopPadding = true,
			showInputsBottomPadding = true,
		},
		config = true,
		keys = {
			{
				"<leader>/r",
				"<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>",
				desc = "Search/Replace",
				mode = { "n" },
			},
			{
				"<leader>/r",
				"<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>'),  paths = vim.fn.expand('%') }  })<cr>",
				desc = "Search/Replace",
				mode = { "x" },
			},
		},
	},
	{
		"folke/flash.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {
			modes = { search = { enabled = true } },
		},
		keys = {
			{
				"<C-s>",
				function()
					local Flash = require("flash")
					Flash.jump({
						search = { mode = "search", forward = true },
						label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
						pattern = [[\<]],
						action = function(match, state)
							state:hide()
							Flash.jump({
								search = { max_length = 0 },
								highlight = { matches = false },
								label = { format = format },
								matcher = function(win)
									-- limit matches to the current label
									return vim.tbl_filter(function(m)
										return m.label == match.label and m.win == win
									end, state.results)
								end,
								labeler = function(matches)
									for _, m in ipairs(matches) do
										m.label = m.label2 -- use the second label
									end
								end,
							})
						end,
						labeler = function(matches, state)
							local labels = state:labels()
							for m, match in ipairs(matches) do
								match.label1 = labels[math.floor((m - 1) / #labels) + 1]
								match.label2 = labels[(m - 1) % #labels + 1]
								match.label = match.label1
							end
						end,
					})
				end,
				desc = "Jump words",
			},
			{
				"s",
				function()
					require("flash").jump({ search = { forward = true, wrap = false, multi_window = false } })
				end,
				desc = "Jump 2 chars forward",
			},
			{
				"S",
				function()
					require("flash").jump({ search = { forward = false, wrap = false, multi_window = false } })
				end,
				desc = "Jump 2 chars backward",
			},
			{
				"f",
				function()
					require("flash").jump({
						search = { forward = true },
						modes = { char = { jump_labels = true } },
						label = { after = { 0, 0 }, before = false },
					})
				end,
				desc = "Jump to char forward",
			},
			{
				"F",
				function()
					require("flash").jump({
						search = { forward = false },
						modes = { char = { jump_labels = true } },
						label = { after = { 0, 0 }, before = false },
					})
				end,
				desc = "Jump to char backward",
			},
			{
				"t",
				function()
					require("flash").jump({
						search = { forward = true },
						modes = { char = { jump_labels = true } },
						label = { before = true, after = false },
					})
				end,
				desc = "Jump to char forward (before char)",
			},
			{
				"T",
				function()
					require("flash").jump({
						search = { forward = false },
						modes = { char = { jump_labels = true } },
						label = { before = true, after = false },
					})
				end,
				desc = "Jump to char backward (after char)",
			},
			{
				"<leader>/t",
				function()
					require("flash").toggle()
				end,
				desc = "Search current word",
			},
			{
				"<leader>/*",
				function()
					require("flash").jump({
						pattern = vim.fn.expand("<cword>"),
					})
				end,
				desc = "Search current word",
			},
		},
	},
	{
		"smoka7/hop.nvim",
		config = true,
		keys = {
			{
				"<C-s>",
				function()
					require("hop").hint_words({})
				end,
				desc = "Jump words",
			},
			{
				"s",
				function()
					require("hop").hint_char2({ direction = require("hop.hint").HintDirection.AFTER_CURSOR })
				end,
				desc = "Hop 2 chars forward",
			},
			{
				"S",
				function()
					require("hop").hint_char2({ direction = require("hop.hint").HintDirection.BEFORE_CURSOr })
				end,
				desc = "Hop 2 chars backward",
			},
			{
				"f",
				function()
					require("hop").hint_char1({
						direction = require("hop.hint").HintDirection.AFTER_CURSOR,
						current_line_only = true,
					})
				end,
				desc = "Hop to char forward",
			},
			{
				"F",
				function()
					require("hop").hint_char1({
						direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
						current_line_only = true,
					})
				end,
				desc = "Hop to char backward",
			},
			{
				"t",
				function()
					require("hop").hint_char1({
						direction = require("hop.hint").HintDirection.AFTER_CURSOR,
						current_line_only = true,
						hint_offset = -1,
					})
				end,
				desc = "Hop to char forward (before char)",
			},
			{
				"T",
				function()
					require("hop").hint_char1({
						direction = require("hop.hint").HintDirection.BEFORE_CURSOR,
						current_line_only = true,
						hint_offset = 1,
					})
				end,
				desc = "Hop to char backward (after char)",
			},
			{
				"<leader>//",
				function()
					require("hop").hint_patterns()
				end,
				desc = "Hop based on pattern",
			},
			{
				"<leader>/*",
				function()
					require("hop").hint_patterns({}, vim.fn.expand("<cword>"))
				end,
				desc = "Hop to word under cursor",
			},
		},
	},
}
