local lazygit
local terminal
local btop
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup()
		local Terminal = require("toggleterm.terminal").Terminal
		lazygit = Terminal:new({
			ft = "term_lazygit",
			cmd = "lazygit",
			direction = "float",
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
			end,
			-- function to run on closing the terminal
			on_close = function()
				vim.cmd("startinsert!")
			end,
		})
		terminal = Terminal:new({
			on_open = function()
				vim.cmd("startinsert!")
			end,
		})
		btop = Terminal:new({
			ft = "term_btop",
			cmd = '[ -x "$(command -v btop)" ] && btop || htop',
			close_on_exit = true,
			direction = "float",
		})
	end,
	keys = {
		-- { "<esc>", [[<C-\><C-n>]], desc = "Escape insert mode", mode = "t" },
		{ "jk", [[<C-\><C-n>]], desc = "Escape insert mode", mode = "t" },
		{ "<C-h>", [[<Cmd>wincmd h<CR>]], mode = "t", buffer = 0 },
		{ "<C-j>", [[<Cmd>wincmd j<CR>]], mode = "t", buffer = 0 },
		{ "<C-k>", [[<Cmd>wincmd k<CR>]], mode = "t", buffer = 0 },
		{ "<C-l>", [[<Cmd>wincmd l<CR>]], mode = "t", buffer = 0 },
		{
			"<C-w><C-o>",
			function()
				terminal:toggle()
				if terminal.direction == "horizontal" then
					terminal:toggle(20, "float")
				else
					terminal:toggle(20, "horizontal")
				end
			end,
			desc = "Toggle float or horizontal",
			mode = "t",
		},
		{
			"<F2>",
			'<C-\\><C-n><cmd>lua require("toggleterm").toggle()<CR>',
			function()
				terminal:toggle()
			end,
			desc = "Toggle floating terminal",
			mode = "t",
		},
		{
			"<F2>",
			function()
				terminal:toggle()
			end,
			desc = "Toggle floating terminal",
		},
		{
			"<F3>",
			function()
				lazygit:toggle()
			end,
			desc = "Lazy git",
		},
		{
			"<F4>",
			function()
				btop:toggle()
			end,
			desc = "Open htop",
		},
		--[[ {
			"<leader>gg",
			function()
				lazygit:toggle()
			end,
			desc = "Lazy git",
		}, ]]
	},
}
