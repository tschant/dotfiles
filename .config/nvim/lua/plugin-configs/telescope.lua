local present, telescope = pcall(require, "telescope")

if not present then
  return
end

vim.g.theme_switcher_loaded = true
local actions = require("telescope.actions")
-- Global remapping
------------------------------
-- '--color=never',
telescope.setup {
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case"
		},
		prompt_prefix = " ",
		selection_caret = " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				preview_width = 0.55,
        results_width = 0.8,
				mirror = false
			},
			vertical = {mirror = false},
			width = 0.75,
			prompt_position = "bottom",
			preview_cutoff = 120
		},
		file_sorter = require("telescope.sorters").get_fzy_sorter,
		file_ignore_patterns = {
			"^.git/"
		},
		generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
		path_display = {"truncate"},
		winblend = 0,
		border = {},
		borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
		color_devicons = true,
		use_less = true,
		set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
		file_previewer = require "telescope.previewers".vim_buffer_cat.new,
		grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
		qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker,
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				-- To disable a keymap, put [map] = false
				-- So, to not map "<C-n>", just put
				-- ["<c-x>"] = false,
				["<esc>"] = actions.close,
				-- Otherwise, just set the mapping to the function that you want it to be.
				-- ["<C-i>"] = actions.select_horizontal,

				-- Add up multiple actions
				-- ["<CR>"] = actions.select_default + actions.center

				-- You can perform as many actions in a row as you like
				-- ["<CR>"] = actions.select_default + actions.center + my_cool_custom_action,
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous
				-- ["<C-i>"] = my_cool_custom_action,
			}
		}
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true
		},
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = {"png", "webp", "jpg", "jpeg"},
			find_cmd = "rg" -- find command (defaults to `fd`)
		},
		project = {
			display_type = 'full',
			base_dirs = {
				'~/git/analyst-ng',
				'~/git/team-ea/terraform_ea',
				'~/git/team-ea/d12y-tools',
				'~/git/team-ea/ea-configs',
				'~/git/team-ea/ea-dotfiles',
				'~/git/tschant/dotfiles',
				'~/git/tschant/schant-server',
				'~/git/team-ea/sfmc-InboxtrackerProd',
			}
		}
	}
}
telescope.load_extension("fzy_native")
telescope.load_extension("media_files")
telescope.load_extension("session-lens")
-- telescope.load_extension("projects")
