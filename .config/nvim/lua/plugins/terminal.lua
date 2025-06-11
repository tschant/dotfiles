local existing_term
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = true,
	keys = {
		{ "<esc>", [[<C-\><C-n>]], desc = "Escape insert mode", mode = "t" },
		{ "jk", [[<C-\><C-n>]], desc = "Escape insert mode", mode = "t" },
		{ "<C-h>", [[<Cmd>wincmd h<CR>]], mode = "t", buffer = 0 },
		{ "<C-j>", [[<Cmd>wincmd j<CR>]], mode = "t", buffer = 0 },
		{ "<C-k>", [[<Cmd>wincmd k<CR>]], mode = "t", buffer = 0 },
		{ "<C-l>", [[<Cmd>wincmd l<CR>]], mode = "t", buffer = 0 },
		{
			"<C-w><C-o>",
			function()
				if existing_term ~= nil then
					existing_term:toggle()
					if existing_term.direction == "horizontal" then
						existing_term:toggle(20, "float")
					else
						existing_term:toggle(20, "horizontal")
					end
				end
			end,
			desc = "Toggle float or horizontal",
			mode = "t",
		},
		{
			"<F2>",
			'<C-\\><C-n><cmd>lua require("toggleterm").toggle()<CR>',
			function()
				if existing_term ~= nil then
					existing_term:toggle()
				end
			end,
			desc = "Toggle floating terminal",
			mode = "t",
		},
		{
			"<F2>",
			function()
				local Terminal = require("toggleterm.terminal").Terminal
				if existing_term == nil then
					existing_term = Terminal:new({
						on_open = function()
							vim.cmd("startinsert!")
						end,
					})
				end

				existing_term:toggle()
			end,
			desc = "Toggle floating terminal",
		},
		{
			"<F3>",
			function()
				local term = require("toggleterm.terminal").Terminal
				local lazygit = term:new({
					ft = "term_lazygit",
					cmd = "lazygit",
					direction = "float",
					on_open = function()
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
					on_close = function()
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
		{ "<leader>et", ":lua require('toggleterm').toggle()<CR>", desc = "Terminal" },
	},
}
