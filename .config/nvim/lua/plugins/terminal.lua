return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = true,
	keys = {
		{
			"<F2>",
			'<C-\\><C-n><cmd>lua require("toggleterm").toggle()<CR>',
			desc = "Toggle floating terminal",
			mode = "t",
		},
		{ "<F2>", '<cmd>lua require("toggleterm").toggle()<CR>', desc = "Toggle floating terminal" },
		{
			"<F3>",
			function()
				local term = require("toggleterm.terminal").Terminal
				local lazygit = term:new({
					ft = "term_lazygit",
					cmd = "lazygit",
					direction = "float",
					on_open = function(term)
						vim.cmd("startinsert!")
						vim.api.nvim_buf_set_keymap(
							term.bufnr,
							"n",
							"q",
							"<cmd>close<CR>",
							{ noremap = true, silent = true }
						)
					end,
					-- function to run on closing the terminal
					on_close = function(term)
						vim.cmd("startinsert!")
					end,
				})

				lazygit:toggle()
			end,
			desc = "Lazy git",
		},
		{
			"<F4>",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				local btop = Terminal:new({
					ft = "term_btop",
					cmd = '[ -x "$(command -v btop)" ] && btop || htop',
					close_on_exit = true,
					direction = "float",
				})

				btop:toggle()
			end,
			desc = "Open htop",
		},
	},
}
