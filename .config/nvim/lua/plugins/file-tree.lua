-- local colors = require("utils.colors")
vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

return {
	{ "benomahony/oil-git.nvim", dependencies = { "stevearc/oil.nvim" }, cmd = "Oil", enabled = false },
	{
		"stevearc/oil.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons"--[[ , "benomahony/oil-git.nvim" ]] },

		cmd = "Oil",
		opts = {
			default_file_explorer = true,
			delete_to_trash = true,
			skip_confirm_for_simple_edits = false,
			columns = {
				"icon",
			},
			view_options = {
				show_hidden = true,
				is_always_hidden = function(name, _)
					return name == ".."--[[  or name == ".git" ]]
				end,
			},
			win_options = {
				wrap = true,
				cursorcolumn = false,
			},
			watch_for_changes = true,
			use_default_keymaps = true,
			show_hidden = true,
			keymaps = {
				["g?"] = { "actions.show_help", mode = "n" },
				["<CR>"] = "actions.select",
				["<C-s>"] = { "actions.select", opts = { vertical = true } },
				["<C-h>"] = { "actions.select", opts = { horizontal = true } },
				["<C-t>"] = { "actions.select", opts = { tab = true } },
				["<C-p>"] = "actions.preview",
				["<C-c>"] = { "actions.close", mode = "n" },
				["q"] = { "actions.close", mode = "n" },
				-- ["<ESC>"] = { "actions.close", mode = "n" },
				["<C-l>"] = "actions.refresh",
				["-"] = { "actions.parent", mode = "n" },
				["<BS>"] = { "actions.parent", mode = "n" },
				["_"] = { "actions.open_cwd", mode = "n" },
				["`"] = { "actions.cd", mode = "n" },
				["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
				["gs"] = { "actions.change_sort", mode = "n" },
				["gx"] = "actions.open_external",
				["g."] = { "actions.toggle_hidden", mode = "n" },
				["g\\"] = { "actions.toggle_trash", mode = "n" },
			},
		},
		keys = {
			{ "<leader>ed", ":DBUIToggle<CR>", desc = "Open DBUI" },
			{ "<leader>ee", ":Oil<CR>", desc = "Open filetree" },
		},
	},
}

--[[ return {
	{
		"mrbjarksen/neo-tree-diagnostics.nvim",
		dependencies = { "nvim-neo-tree/neo-tree.nvim" },
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
			{ "MunifTanjim/nui.nvim", branch = "main" },
		},
		keys = {
			{
				"<leader>eb",
				":lua require('neo-tree.command').execute({action = 'focus', source = 'buffers', reveal = true, position = 'float', toggle = true})<CR>",
				desc = "Buffers tree",
			},
			{
				"<leader>ec",
				":lua require('neo-tree.command').execute({action = 'close'})<CR>",
				desc = "Close all neo-tree",
			},
			{ "<leader>ed", ":DBUIToggle<CR>", desc = "Open DBUI" },
			{
				"<leader>ee",
				":lua require('neo-tree.command').execute({action = 'focus', source = 'filesystem', reveal = true, position = 'float', toggle = true})<CR>",
				desc = "File tree",
			},
			{
				"<leader>eg",
				":lua require('neo-tree.command').execute({action = 'show', source = 'git_status', reveal = true, position = 'bottom', toggle = true})<CR>",
				desc = "Git Status",
			},
			{
				"<leader>ex",
				":lua require('neo-tree.command').execute({action = 'focus', source = 'diagnostics', reveal = true, position = 'bottom', toggle = true})<CR>",
				desc = "LSP/Diag",
			},
		},
		opts = {
			sources = {
				"filesystem",
				"buffers",
				"git_status",
				"diagnostics",
			},
			event_handlers = {
				{
					event = "neo_tree_buffer_enter",
					handler = function()
						vim.opt_local.relativenumber = true
					end,
				},
			},
			close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
			enable_git_status = false,
			-- enable_diagnostics = true,
			sort_case_insensitive = false, -- used when sorting files and directories in the tree
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = " ",
					last_indent_marker = " ",
					highlight = "NeoTreeIndentMarker",
					with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = " ",
					folder_open = " ",
					folder_empty = "ﰊ",
					default = "*",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
						modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
						deleted = "✖", -- this can only be used in the git_status source
						renamed = "", -- this can only be used in the git_status source
						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			window = {
				position = "left",
				width = 40,
				mapping_options = {
					noremap = true,
					nowait = true,
				},
				mappings = {
					["<space>"] = {
						"toggle_node",
						nowait = false,
					},
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["t"] = "open_tabnew",
					["w"] = "open_with_window_picker",
					["C"] = "close_node",
					["z"] = "close_all_nodes",
					--["Z"] = "expand_all_nodes",
					["a"] = {
						"add",
						-- "none", "relative", "absolute"
						config = { show_path = "relative" },
					},
					["A"] = {
						"add_directory",
						config = { show_path = "relative" },
					},
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = {
						"copy",
						config = { show_path = "relative" },
					},
					["m"] = {
						"move",
						config = { show_path = "relative" },
					},
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
					["<"] = "prev_source",
					[">"] = "next_source",
				},
			},
			nesting_rules = {},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
					hide_by_name = {},
					hide_by_pattern = {},
					never_show = {},
				},
				follow_current_file = {
					enabled = false,
				},
				group_empty_dirs = true,
				hijack_netrw_behavior = "open_default",
				window = {
					mappings = {
						["<bs>"] = "navigate_up",
						["."] = "set_root",
						["H"] = "toggle_hidden",
						["/"] = "fuzzy_finder",
						["D"] = "fuzzy_finder_directory",
						["f"] = "filter_on_submit",
						["<c-x>"] = "clear_filter",
						["[g"] = "prev_git_modified",
						["]g"] = "next_git_modified",
					},
				},
			},
			buffers = {
				follow_current_file = {
					enabled = true, -- This will find and focus the file in the active buffer every
				},
				group_empty_dirs = true, -- when true, empty folders will be grouped together
				show_unloaded = true,
				window = {
					mappings = {
						["D"] = "buffer_delete",
						["<bs>"] = "navigate_up",
						["."] = "set_root",
					},
				},
			},
			git_status = {
				window = {
					position = "bottom",
					mappings = {
						["A"] = "git_add_all",
						["gu"] = "git_unstage_file",
						["ga"] = "git_add_file",
						["gr"] = "git_revert_file",
						["gc"] = "git_commit",
						-- ["gp"] = "git_push",
						-- ["gg"] = "git_commit_and_push",
					},
				},
			},
			diagnostics = {
				bind_to_cwd = true,
				diag_sort_function = "severity", -- "severity" means diagnostic items are sorted by severity in addition to their positions.
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_dirs_and_files = true, -- when true, empty folders and files will be grouped together
				group_empty_dirs = true, -- when true, empty directories will be grouped together
				show_unloaded = true, -- show diagnostics from unloaded buffers
			},
		},
	},
} ]]
