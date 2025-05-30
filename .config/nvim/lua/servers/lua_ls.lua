return {
	capabilities = require("servers.utils").capabilities(),
	cmd = { "lua-language-server" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = { "lua/?.lua", "lua/?/init.lua" },
			},
			completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
			diagnostics = {
				enable = true,
				globals = {
					"vim",
					"describe",
					"it",
					"before_each",
					"after_each",
					"teardown",
					"pending",
					"use",
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
			},
		},
	},
}
