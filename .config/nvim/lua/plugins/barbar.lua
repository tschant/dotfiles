local M = {
	"romgrk/barbar.nvim",
	dependencies = {
		"kyazdani42/nvim-web-devicons",
	},
	init = function() vim.g.barbar_auto_setup = false end,
	opts = {
		animation = false,
		auto_hide = false,
		tabpages = true,
		closable = true,
		clickable = true,
		icons = {
			filetype = { enabled = true },
			button = '󰅖',
			modified = {button = '●'},
			pinned = {button = '', filename = true},
			separator = {left = '▎', right = ''},
		},
		insert_at_end = false,
		insert_at_start = false,
		maximum_padding = 1,
		maximum_length = 30,
		semantic_letters = true,
		no_name_title = nil,
		sidebar_filetypes = {
			['neo-tree'] = {event = 'BufWipeout'},
		},
	},
	keys = {
		'<C-q>'
	},
	event = "BufAdd",
	-- cmd = {
	-- 	"BufferPrev",
	-- 	"BufferNext",
	-- 	"BufferClose",
	-- 	"BufferCloseAllButCurrentOrPinned",
	-- 	"BufferCloseBuffersLeft",
	-- 	"BufferCloseBuffersRight",
	-- 	"BufferPin",
	-- 	"BufferFirst",
	-- 	"BufferLast",
	-- 	"BufferMovePrevious",
	-- 	"BufferMoveNext",
	-- 	"BufferOrderByDirectory",
	-- 	"BufferOrderByBufferNumber",
	-- 	"BufferOrderByWindowNumber",
	-- 	"BufferGoto",
	-- },
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
