return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
		-- Only one of these is needed.
		"nvim-telescope/telescope.nvim", -- optional
	},
	keys = {
		-- {'<leader>gnc', '<cmd>lua require("neogit").open({"commit"})<CR>', 'Neogit commit'},
		{'<leader>gn', '<cmd>lua require("neogit").open()<CR>', 'Neogit open split'},
		{'<leader>gg', '<cmd>lua require("neogit").open({kind = "floating"})<CR>', 'Neogit open'},
	}
}
