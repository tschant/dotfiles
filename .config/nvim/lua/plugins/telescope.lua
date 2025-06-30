local util = require("utils.core")
local u = require("utils.extra")
local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
	local action_state = require("telescope.actions.state")
	local actions = require("telescope.actions")
	local picker = action_state.get_current_picker(prompt_bufnr)
	local selected_entry = action_state.get_selected_entry()
	local num_selections = #picker:get_multi_selection()
	if not num_selections or num_selections <= 1 then
		actions.add_selection(prompt_bufnr)
		if type(selected_entry.value) == "table" then -- Code actions the value is a table instead of a string
			actions.select_default(prompt_bufnr)
			return
		end
	end
	actions.send_selected_to_qflist(prompt_bufnr)
	vim.cmd("cfdo " .. open_cmd)
end
function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
	telescope_custom_actions._multiopen(prompt_bufnr, "vsplit")
end
function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
	telescope_custom_actions._multiopen(prompt_bufnr, "split")
end
function telescope_custom_actions.multi_selection_open_tab(prompt_bufnr)
	telescope_custom_actions._multiopen(prompt_bufnr, "tab")
end
function telescope_custom_actions.multi_selection_open(prompt_bufnr)
	telescope_custom_actions._multiopen(prompt_bufnr, "edit")
end

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-fzy-native.nvim",
		"nvim-telescope/telescope-media-files.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
	},
	cmd = "Telescope",
	keys = {
		{
			"gR",
			"<cmd>lua require('telescope.builtin').lsp_references({ show_line = false })<CR>",
			desc = "References",
		},
		{ "gd", ":Telescope lsp_definitions<CR>", desc = "Definitions" },
		{
			"gs",
			util.telescope("lsp_document_symbols", {
				symbols = {
					"Class",
					"Function",
					"Method",
					"Constructor",
					"Interface",
					"Module",
					"Struct",
					"Trait",
					"Field",
					"Property",
				},
			}),
			desc = "Goto Symbol",
		},
		{ "<C-p>", util.telescope("find_files", { cwd = false }), desc = "find files (cwd)" },
		{ "<C-S-p>", "<cmd>Telescope commands<cr>", desc = "show command prompt" },

		{ "<leader>fF", util.telescope("files"), desc = "find files (root dir)" },
		{ "<leader>ff", util.telescope("find_files", { cwd = false }), desc = "find files (cwd)" },
		{ "<leader>fG", util.telescope("live_grep", { grep_open_files = true }), desc = "grep open files" },
		{
			"<leader>fg",
			util.telescope("live_grep", { cwd = false }),
			desc = "grep files (cwd)",
		},
		{ "<leader>fW", util.telescope("grep_string"), desc = "search word (root dir)" },
		{ "<leader>fw", util.telescope("grep_string", { cwd = false }), desc = "search word (cwd)" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "list buffers" },
		{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "show recently opened files" },
		{ "<leader>fj", "<cmd>Telescope jumplist<cr>", desc = "show jumplist" },
		{ "<leader>fh", "<cmd>Telescope harpoon marks<cr>", desc = "show harpoon" },
		{ "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "show vim help" },
		{ "<leader>fm", "<cmd>Telescope marks<cr>", desc = "show marks" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "show keymaps" },
		{ "<leader>fO", "<cmd>Telescope vim_options<cr>", desc = "show vim opts" },
		{ "<leader>fr", "<cmd>Telescope registers<cr>", desc = "show copy registers" },
		{ "<leader>fs", "<cmd>Telescope possession only_cwd=true<cr>", desc = "show sessions" },
		{ "<leader>fS", "<cmd>Telescope spell_suggest<cr>", desc = "show spell suggest" },
		{ "<leader>f/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "search in file" },
		{ "<leader>f?", "<cmd>Telescope search_history<cr>", desc = "search history" },
		{ "<leader>fC", "<cmd>Telescope command_history<cr>", desc = "show command-line history" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>", desc = "show command prompt" },
		{ "<leader>fx", util.telescope("colorscheme", { enable_preview = true }), desc = "show colorscheme picker" },
		{ "<leader>fu", "<cmd>silent! %foldopen! | UndotreeToggle<cr>", desc = "show undotree" },
		{ "<leader>fds", "<cmd>Telescope lsp_document_symbols<cr>", desc = "show doc symbols" },
		{ "<leader>fdS", "<cmd>Telescope lsp_workspace_symbols<cr>", desc = "show workspace symbols" },
		{ "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "show treesitter" },

		{ "<leader>gb", ":Telescope git_branches<CR>", desc = "git branches" },
		{ "<leader>gc", ":Telescope git_commits<CR>", desc = "git commits" },
		{ "<leader>gf", ":Telescope git_files<CR>", desc = "git files" },
		{ "<leader>gs", ":Telescope git_status<CR>", desc = "git status" },
	},
	config = function()
		local telescope = require("telescope")
		vim.g.theme_switcher_loaded = true
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					-- "--no-ignore",
					-- "--hidden",
					"--glob",
					"!**/.git/*",
					"--glob",
					"!**/node_modules/*",
					"--glob",
					"!**/package-lock.json",
					"--max-filesize",
					"50K",
				},
				prompt_prefix = " ",
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
						mirror = false,
					},
					vertical = { mirror = false },
					width = 0.75,
					prompt_position = "bottom",
					preview_cutoff = 120,
				},
				file_sorter = require("telescope.sorters").get_fzy_sorter,
				file_ignore_patterns = {
					"^.git/",
					"^node_modules/",
				},
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = { "truncate" },
				preview = { filesize_limit = 0.5 }, -- MB
				dynamic_preview_title = true,
				winblend = 0,
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				use_less = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				-- Developer configurations: Not meant for general override
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				mappings = {
					i = {
						["<CR>"] = actions.select_default,
						["<C-CR>"] = telescope_custom_actions.multi_selection_open,
						["<TAB>"] = actions.toggle_selection,
						["<C-TAB>"] = actions.toggle_selection + actions.move_selection_next,
						["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-v>"] = telescope_custom_actions.multi_selection_open_vsplit,
						["<C-h>"] = telescope_custom_actions.multi_selection_open_split,
						["<C-e>"] = actions.preview_scrolling_down,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.delete_buffer,
						["<C-n>"] = { "<esc>", type = "command" }, --actions.close,
						["<esc>"] = actions.close,
						["<C-?>"] = actions.which_key,
						-- To disable a keymap, put [map] = false
						-- So, to not map "<C-n>", just put
						-- ["<c-x>"] = false,
					},
					n = {
						["<CR>"] = telescope_custom_actions.multi_selection_open,
						["<TAB>"] = actions.toggle_selection,
						["<C-TAB>"] = actions.toggle_selection + actions.move_selection_next,
						["<S-TAB>"] = actions.toggle_selection + actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<esc>"] = actions.close,
						["<C-e>"] = actions.preview_scrolling_down,
						["<C-u>"] = actions.preview_scrolling_up,
						["<C-d>"] = actions.delete_buffer,
						["d"] = actions.delete_buffer,
						["j"] = actions.preview_scrolling_down,
						["k"] = actions.preview_scrolling_up,
						-- ["h"] = actions.preview_scrolling_left,
						-- ["l"] = actions.preview_scrolling_right,
					},
				},
			},
			extensions = {
				fzy_native = {
					override_generic_sorter = false,
					override_file_sorter = true,
				},
				media_files = {
					-- filetypes whitelist
					-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
					filetypes = { "png", "webp", "jpg", "jpeg" },
					find_cmd = "rg", -- find command (defaults to `fd`)
				},
			},
			pickers = {
				--[[ git_files = {
				find_command = {
					"rg",
					"--files",
					"--hidden",
					"--sortr=modified",
					"--glob",
					"!**/.git/*",
					"--glob",
					"!**/node_modules/*",
				},
			}, ]]
				find_files = {
					find_command = {
						"rg",
						"--files",
						"--hidden",
						"--sortr=modified",
						"--glob",
						"!**/.git/*",
						"--glob",
						"!**/node_modules/*",
					},
				},
			},
		})
		telescope.load_extension("fzy_native")
		telescope.load_extension("media_files")
		telescope.load_extension("harpoon")
		telescope.load_extension("ui-select")
		telescope.load_extension("possession")

		vim.api.nvim_create_autocmd("WinLeave", {
			callback = function()
				if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
				end
			end,
		})
	end,
}
