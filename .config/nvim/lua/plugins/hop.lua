return {
	"phaazon/hop.nvim",
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
	},
}
