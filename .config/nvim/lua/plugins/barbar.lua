local M = {
	-- "romgrk/barbar.nvim",
	-- branch = "master",
	-- dependencies = {
	-- 	"kyazdani42/nvim-web-devicons",
	-- },
	-- init = function() vim.g.barbar_auto_setup = false end,
	-- opts = {
	-- 	animation = false,
	-- 	auto_hide = false,
	-- 	tabpages = true,
	-- 	closable = true,
	-- 	clickable = true,
	-- 	icons = {
	-- 		inactive = {buffer_index = true},
	-- 		filetype = { enabled = true },
	-- 		button = '󰅖',
	-- 		modified = {button = '●'},
	-- 		pinned = {button = '', filename = true},
	-- 		separator = {left = '▎', right = ''},
	-- 	},
	-- 	insert_at_end = false,
	-- 	insert_at_start = false,
	-- 	maximum_padding = 1,
	-- 	maximum_length = 30,
	-- 	semantic_letters = true,
	-- 	no_name_title = nil,
	-- 	-- sidebar_filetypes = {
	-- 	-- 	['neo-tree'] = {event = 'BufWipeout'},
	-- 	-- },
	-- },
	-- keys = {
	-- 	'<C-q>'
	-- },
	-- event = "BufAdd",
	-- -- cmd = {
	-- -- 	"BufferPrev",
	-- -- 	"BufferNext",
	-- -- 	"BufferClose",
	-- -- 	"BufferCloseAllButCurrentOrPinned",
	-- -- 	"BufferCloseBuffersLeft",
	-- -- 	"BufferCloseBuffersRight",
	-- -- 	"BufferPin",
	-- -- 	"BufferFirst",
	-- -- 	"BufferLast",
	-- -- 	"BufferMovePrevious",
	-- -- 	"BufferMoveNext",
	-- -- 	"BufferOrderByDirectory",
	-- -- 	"BufferOrderByBufferNumber",
	-- -- 	"BufferOrderByWindowNumber",
	-- -- 	"BufferGoto",
	-- -- },


	-- keybinds 
	--[[ 
		{ "<leader>b1", "<cmd>BufferGoto 1<CR>", desc = "goto buffer 1" },
    { "<leader>b2", "<cmd>BufferGoto 2<CR>", desc = "goto buffer 2" },
    { "<leader>b3", "<cmd>BufferGoto 3<CR>", desc = "goto buffer 3" },
    { "<leader>b4", "<cmd>BufferGoto 4<CR>", desc = "goto buffer 4" },
    { "<leader>b5", "<cmd>BufferGoto 5<CR>", desc = "goto buffer 5" },
    { "<leader>b6", "<cmd>BufferGoto 6<CR>", desc = "goto buffer 6" },
    { "<leader>b7", "<cmd>BufferGoto 7<CR>", desc = "goto buffer 7" },
    { "<leader>b8", "<cmd>BufferGoto 8<CR>", desc = "goto buffer 8" },
    { "<leader>b9", "<cmd>BufferGoto 9<CR>", desc = "goto buffer 9" },

		{ "<leader>bca", "<cmd>BufferCloseAllButCurrentOrPinned<CR>", desc = "Close all but current" },
    { "<leader>bcl", "<cmd>BufferCloseBuffersLeft<CR>", desc = "Close all left" },
    { "<leader>bcr", "<cmd>BufferCloseBuffersRight<CR>", desc = "Close all right" },
    { "<leader>bd", "<cmd>BufferClose<CR>", desc = "Close buffer" },
    { "<leader>bh", "<cmd>BufferMovePrevious<CR>", desc = "Move buffer prev" },
    { "<leader>bj", "<cmd>BufferLast<CR>", desc = "Goto last buffer" },
    { "<leader>bk", "<cmd>BufferFirst<CR>", desc = "Goto First buffer" },
    { "<leader>bl", "<cmd>BufferMoveNext<CR>", desc = "Move buffer next" },

		 { "<leader>bod", "<cmd>BufferOrderByDirectory<CR>", desc = "by directory" },
    { "<leader>bon", "<cmd>BufferOrderByBufferNumber<CR>", desc = "by buffer number" },
    { "<leader>bow", "<cmd>BufferOrderByWindowNumber<CR>", desc = "by window number" },
    { "<leader>bpp", "<cmd>BufferPin<CR>", desc = "Pin Buffer" },
	--]]
}

--[[ M.config = function() 

	-- local hl = require('bufferline.utils').hl
	-- local fg_modified  = hl.fg_or_default({ 'DiagnosticWarn' }, 'none')
	-- local fg_modified_subtle  = hl.fg_or_default({ 'DiagnosticError' }, 'none')
	-- cmd("hi BufferCurrentMod  guifg=" .. fg_modified.gui)
	-- cmd("hi BufferVisibleMod  guifg=" .. fg_modified.gui)
	-- cmd("hi BufferInactiveMod guifg=" .. fg_modified_subtle.gui)
	-- # Meaning of terms:
	-- #
	-- # format: "Buffer" + status + part
	-- #
	-- # status:
	-- #     *Current: current buffer
	-- #     *Visible: visible but not current buffer
	-- #    *Inactive: invisible but not current buffer
	-- #
	-- # part:
	-- #        *Icon: filetype icon
	-- #       *Index: buffer index
	-- #         *Mod: when modified
	-- #        *Sign: the separator between buffers
	-- #      *Target: letter in buffer-picking mode
	-- #
	-- # BufferTabpages: tabpage indicator
	-- # BufferTabpageFill: filler after the buffer section
	-- # BufferOffset: offset section, created with set_offset()
	-- cmd('hi BufferCurrent guifg=' ..         fg_current)
	-- cmd('hi BufferCurrentIndex guifg=' ..    fg_special)
	-- cmd('hi BufferCurrentSign guifg=' ..     fg_special)
	-- cmd('hi BufferCurrentTarget guifg=' ..   fg_target)
	-- cmd('hi BufferVisible guifg=' ..         fg_visible)
	-- cmd('hi BufferVisibleIndex guifg=' ..    fg_visible)
	-- cmd('hi BufferVisibleSign guifg=' ..     fg_visible)
	-- cmd('hi BufferVisibleTarget guifg=' ..   fg_target)
	-- cmd('hi BufferInactive guifg=' ..        fg_inactive)
	-- cmd('hi BufferInactiveIndex guifg=' ..   fg_subtle)
	-- cmd('hi BufferInactiveSign guifg=' ..    fg_subtle)
	-- cmd('hi BufferInactiveTarget guifg=' ..  fg_target)
	-- cmd('hi BufferTabpages guifg=' ..        fg_special)
	-- cmd('hi BufferTabpageFill guifg=' ..     fg_inactive)
	-- cmd('hi BufferCurrentIcon guifg=' ..   'BufferCurrent')
	-- cmd('hi BufferVisibleIcon guifg=' ..   'BufferVisible')
	-- cmd('hi BufferInactiveIcon guifg=' ..  'BufferInactive')
	-- cmd('hi BufferOffset guifg=' ..        'BufferTabpageFill')
end ]]

return M
