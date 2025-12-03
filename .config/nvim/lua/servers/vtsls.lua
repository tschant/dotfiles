return {
	settings = {
		vtsls = {
			-- Automatically use workspace version of TypeScript lib on startup
			autoUseWorkspaceTsdk = true,
			experimental = {
				-- Truncate inlay hint
				-- https://github.com/neovim/neovim/issues/27240
				maxInlayHintLength = 40,
				completion = {
					-- Execute fuzzy match of completion items on server side. Enable this
					-- will help filter out useless completion items from tsserver
					enableServerSideFuzzyMatch = true,
					-- entriesLimit = 200,
				},
			},
		},
		javascript = {
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				variableTypes = { enabled = true },
			},
		},
		typescript = {
			inlayHints = {
				enumMemberValues = { enabled = true },
				functionLikeReturnTypes = { enabled = true },
				parameterNames = { enabled = "literals" },
				parameterTypes = { enabled = true },
				propertyDeclarationTypes = { enabled = true },
				variableTypes = { enabled = true },
			},
		},
	},
}
