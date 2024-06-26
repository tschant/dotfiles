return {
	dir = "~/.config/nvim/lua/custom/markview.nvim/",
	name = "markview",
	enabled = true,
	ft = 'markdown',

	config = function()
		require("markview").setup()
	end,
}
