local u = require("utils.extra")
return {
	"jedrzejboczar/possession.nvim",
	requires = { "nvim-lua/plenary.nvim" },
	lazy = false,
	-- cmd = { "PossessionLoadCwd", "PossessionLoad" },
	-- event = "VeryLazy",
	keys = {
		{ "<leader>sr", ":PossessionLoad<CR>", desc = "Restore Session" },
		{ "<leader>sv", ":PossessionSaveGit<cr>", desc = "Save Session (per branch)" },
	},
	config = function()
		vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
		vim.api.nvim_create_user_command("PossessionSaveGit", function()
			local branch = u.get_branch()
			local global_cwd = vim.fn.getcwd(-1, -1)
			local cwd = vim.fn.fnamemodify(global_cwd, ":~")
			if branch then
				branch = branch:gsub("/", "_"):gsub(" ", "")
				local session_name = cwd .. "[branch:" .. branch .. "]"
				require("possession.commands").save(session_name)
			end
		end, { nargs = 0 })

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
}
