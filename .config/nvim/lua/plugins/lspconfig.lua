local utils = require("utils.extra")
local servers = require("servers")
local kulala_ls = require("servers.kulala_ls")

return {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	dependencies = {
		-- LSP Installer
		"williamboman/mason.nvim",
		-- "hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = utils.get_table_keys(servers),
		})

		-- Custom servers:
		require("lspconfig.configs").kulala_ls = kulala_ls
		servers.kulala_ls = kulala_ls
		for server, config in pairs(servers) do
			vim.lsp.config(server, config)
			vim.lsp.enable(server)
		end
	end,
}
