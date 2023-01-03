local Hydra = require('hydra')

local function cmd(command)
	return table.concat({ '<Cmd>', command, '<CR>' })
end

local hint = [[
 _d_: close                    _n_: new                   _pp_: pin              _b_: buffers
 _h_: move previous            _j_: goto last             _k_: goto first        _l_: move next
 _ca_: close all               _cl_: close left           _cr_: close right
 _od_: order by directory      _on_: order by number      _ow_: order by window number
 _<Esc>_
]]

Hydra({
	name = 'Buffers',
	hint = hint,
	config = {
		color = 'blue',
		invoke_on_body = true,
		hint = {
			position = 'top',
			offset = 2,
			border = 'rounded',
		},
	},
	mode = 'n',
	body = '<Leader>b',
	heads = {
		{ 'd',  cmd 'BufferClose' },
		{ 'ca', cmd 'BufferCloseAllButCurrentOrPinned' },
		{ 'cl', cmd 'BufferCloseBuffersLeft' },
		{ 'cr', cmd 'BufferCloseBuffersRight' },
		{ 'b',  cmd 'Telescope buffers' },
		{ 'pp', cmd 'BufferPin' },
		{ 'n',  cmd 'tabnew' },
		{ 'k',  cmd 'BufferFirst' },
		{ 'j',  cmd 'BufferLast' },
		{ 'h',  cmd 'BufferMovePrevious' },
		{ 'l',  cmd 'BufferMoveNext' },
		{ 'od', cmd 'BufferOrderByDirectory',    { desc = 'by directory' } },
		{ 'on', cmd 'BufferOrderByBufferNumber', { desc = 'by buffer number' } },
		{ 'ow', cmd 'BufferOrderByWindowNumber', { desc = 'by window number' } },
		{ '1',  cmd 'BufferGoto 1',              { desc = 'goto buffer 1' } },
		{ '2',  cmd 'BufferGoto 2',              { desc = 'goto buffer 2' } },
		{ '3',  cmd 'BufferGoto 3',              { desc = 'goto buffer 3' } },
		{ '4',  cmd 'BufferGoto 4',              { desc = 'goto buffer 4' } },
		{ '5',  cmd 'BufferGoto 5',              { desc = 'goto buffer 5' } },
		{ '6',  cmd 'BufferGoto 6',              { desc = 'goto buffer 6' } },
		{ '7',  cmd 'BufferGoto 7',              { desc = 'goto buffer 7' } },
		{ '8',  cmd 'BufferGoto 8',              { desc = 'goto buffer 8' } },
		{ '9',  cmd 'BufferGoto 9',              { desc = 'goto buffer 9' } },
		{ '<Esc>', nil, { exit = true, nowait = true } },
	}
})
