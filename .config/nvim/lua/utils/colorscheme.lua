local cmd = vim.cmd
local utils = {}

function utils.setColorScheme(Theme)
	cmd("colorscheme " .. Theme)

	-- Use terminal background color instead of colorscheme
	-- cmd("hi Normal ctermbg=none guibg=none")
	cmd("hi NormalNC ctermbg=none guibg=#262626")
	cmd("hi SignColumn ctermbg=none guibg=none")
	cmd("hi FoldColumn ctermbg=none guibg=none")
	cmd("hi FocusedLine ctermbg=none guibg=none guifg=#0088aa")

	-- cmd "hi StatusColumnBorder guifg=SignColumn guibg=SignColumn"
	-- cmd "hi StatusColumnGitSigns guifg=SignColumn guibg=SignColumn"

	-- highlights --
	cmd("hi EndOfBuffer guifg=#525252 guibg=NONE")
	-- cmd("hi gitcommitOverflow guifg=#525252 guibg=NONE")
	-- cmd("hi gitcommitTrailers guifg=#525252 guibg=NONE")
	-- cmd("hi Visual guibg=#525252")

	-- -- git signs
	local colors = require("utils.colors")
	cmd("hi DiffAdd guifg=" .. colors.green .. " guibg = none")
	cmd("hi DiffChange guifg =" .. colors.blue .. " guibg = none")
	cmd("hi DiffModified guifg =" .. colors.orange .. " guibg = none")
	cmd("hi DiffDeleted guifg =" .. colors.red .. " guibg = none")
	cmd("hi DiagnosticError guifg =" .. colors.error .. " guibg = none")
	cmd("hi DiagnosticWarn guifg =" .. colors.warning .. " guibg = none")
	cmd("hi DiagnosticInfo guifg =" .. colors.info .. " guibg = none")
	cmd("hi DiagnosticHint guifg =" .. colors.hint .. " guibg = none")

	-- cmd("hi BufferCurrentADDED guifg=" .. colors.green)
	-- cmd("hi BufferCurrentCHANGED guifg =" .. colors.blue)
	-- cmd("hi BufferCurrentMod guifg =" .. colors.orange)
	-- cmd("hi BufferCurrentDELETED guifg =" .. colors.red)
	-- cmd("hi BufferCurrentERROR guifg =" .. colors.error)
	-- cmd("hi BufferCurrentWARN guifg =" .. colors.warning)
	-- cmd("hi BufferCurrentINFO guifg =" .. colors.info)
	-- cmd("hi BufferCurrentHINT guifg =" .. colors.hint)

	cmd("hi NotifyBackground guifg = none guibg=#000000")
end


return utils
