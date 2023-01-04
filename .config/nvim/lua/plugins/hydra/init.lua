local M = {
	'anuvyklack/hydra.nvim',
	dependencies = {'anuvyklack/keymap-layer.nvim'},
	-- event = "VimEnter",
	event = 'VeryLazy'
}

M.config = function()
	require('plugins.hydra.window')
	require('plugins.hydra.gitsigns')
	require('plugins.hydra.telescope')
	require('plugins.hydra.buffers')
end

return M
