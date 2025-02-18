return {
	{
		"jedrzejboczar/possession.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		lazy = false,
		-- cmd = { "PossessionLoadCwd", "PossessionLoad" },
		-- event = "VeryLazy",
		config = function()
			vim.o.sessionoptions="blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
			require("possession").setup({
				commands = {
					save = "PossessionSave",
					load = "PossessionLoad",
					save_cwd = "PossessionSaveCwd",
					load_cwd = "PossessionLoadCwd",
					rename = "PossessionRename",
					close = "PossessionClose",
					delete = "PossessionDelete",
					show = "PossessionShow",
					list = "PossessionList",
					list_cwd = "PossessionListCwd",
					migrate = "PossessionMigrate",
				},
				plugins = {
					delete_hidden_buffers = {
						hooks = {
							"before_load",
						},
						force = true, -- or fun(buf): boolean
					},
				},
			})
		end,
	},
}
