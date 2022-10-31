local cmd = vim.cmd

cmd "hi IndentBlanklineIndent1 guifg=#381111" --[[ guibg=#2a3834 ]]
cmd "hi IndentBlanklineIndent2 guifg=#613e1a" --[[ guibg=#2a3834 ]]
cmd "hi IndentBlanklineIndent3 guifg=#636218" --[[ guibg=#2a3834 ]]
cmd "hi IndentBlanklineIndent4 guifg=#2a3834" --[[ guibg=#332b36 ]]
cmd "hi IndentBlanklineIndent5 guifg=#184b63" --[[ guibg=#2a3834 ]]
cmd "hi IndentBlanklineIndent6 guifg=#492a63" --[[ guibg=#2a3834 ]]

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
  space_char_blankline = " ",
	show_current_context = true,
	show_current_context_start = true,
	filetype_exclude = {"help", "dashboard", "startify", "NvimTree", "vista", "sagahover"},
	space_char_blankline = " ",
	char_highlight_list = {
		"IndentBlanklineIndent1",
		"IndentBlanklineIndent2",
		"IndentBlanklineIndent3",
		"IndentBlanklineIndent4",
		"IndentBlanklineIndent5",
		"IndentBlanklineIndent6",
	},
}
