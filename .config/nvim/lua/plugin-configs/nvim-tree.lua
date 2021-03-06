local tree_cb = require "nvim-tree.config".nvim_tree_callback
local list = {
	-- mappings
	{ key = {"<2-LeftMouse>", "<CR>", "o"}, cb = tree_cb("edit")},
	{ key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
	{ key = "v", cb = tree_cb("vsplit")},
	{ key = "s", cb = tree_cb("split")},
	{ key = "<C-t>", cb = tree_cb("tabnew")},
	{ key = "h", cb = tree_cb("close_node")},
	{ key = "<BS>", cb = tree_cb("close_node")},
	{ key = "<S-CR>", cb = tree_cb("close_node")},
	{ key = "<Tab>", cb = tree_cb("preview")},
	{ key = "I", cb = tree_cb("toggle_ignored")},
	{ key = "H", cb = tree_cb("toggle_dotfiles")},
	{ key = "R", cb = tree_cb("refresh")},
	{ key = "a", cb = tree_cb("create")},
	{ key = "d", cb = tree_cb("remove")},
	{ key = "r", cb = tree_cb("rename")},
	{ key = "<C-r>", cb = tree_cb("full_rename")},
	{ key = "x", cb = tree_cb("cut")},
	{ key = "c", cb = tree_cb("copy")},
	{ key = "p", cb = tree_cb("paste")},
	{ key = "[c", cb = tree_cb("prev_git_item")},
	{ key = "]c", cb = tree_cb("next_git_item")},
	{ key = "-", cb = tree_cb("dir_up")},
	{ key = "q", cb = tree_cb("close")}
}

require"nvim-tree".setup({
	disable_netrw = true,
	hijack_netrw = false,
	update_focused_file = {
		enable = true
	},
	git = {
		ignore = false
	},
	view = {
		width = 40,
		hide_root_folder = false,
		mappings = {
			custom_only = true,
			list = list
		}
	},
	
})

require"nvim-tree.events".on_tree_close(function() 
	require'bufferline.state'.set_offset(0, 'FileTree')
end)
require"nvim-tree.events".on_tree_open(function() 
	require'bufferline.state'.set_offset(40, 'FileTree')
end)

vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_auto_ignore_ft = {"startify", "dashboard"}
vim.g.nvim_tree_side = "left"
vim.g.nvim_tree_quit_on_open = 0

vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {unstaged = "", staged = "✓", unmerged = "", renamed = "➜", untracked = ""},
    folder = {default = "", open = "", empty = "", empty_open = "", symlink = ""}
}

