local utils = require("utils.extra")
local servers = require("servers")

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

		local lspconfig = require("lspconfig")
		for server, config in pairs(servers) do
			lspconfig[server].setup(config)
		end
	end,
}
