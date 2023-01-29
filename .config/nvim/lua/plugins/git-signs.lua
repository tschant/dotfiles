local M = {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPre",
}

M.config = function()
	local u = require("utils.core")

	-- Git signs
	require("gitsigns").setup {
		signs = {
			add = {hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn"},
			change = {hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"},
			delete = {hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
			topdelete = {hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn"},
			changedelete = {hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn"}
		},
		numhl = false,
		linehl = false,
		watch_gitdir = {
			interval = 1000
		},
		sign_priority = 6,
		update_debounce = 200,
		status_formatter = nil, -- Use default
		-- use_decoration_api = false
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			-- Navigation
			u.map('n', ']c', function()
				if vim.wo.diff then return ']c' end
				vim.schedule(function() gs.next_hunk() end)
				return '<Ignore>'
			end, {expr=true, buffer = bufnr})

			u.map('n', '[c', function()
				if vim.wo.diff then return '[c' end
				vim.schedule(function() gs.prev_hunk() end)
				return '<Ignore>'
			end, {expr=true, buffer = bufnr})

			-- Actions
			u.map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', {buffer = bufnr})
			u.map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', {buffer = bufnr})
			u.map('n', '<leader>hS', gs.stage_buffer, {buffer = bufnr})
			u.map('n', '<leader>hu', gs.undo_stage_hunk, {buffer = bufnr})
			u.map('n', '<leader>hR', gs.reset_buffer, {buffer = bufnr})
			u.map('n', '<leader>hp', gs.preview_hunk, {buffer = bufnr})
			u.map('n', '<leader>hd', gs.diffthis, {buffer = bufnr})
			u.map('n', '<leader>hD', function() gs.diffthis('~') end, {buffer = bufnr})
			u.map('n', '<leader>td', gs.toggle_deleted, {buffer = bufnr})
			u.map("n", "<C-g>", ":Gitsigns blame_line<CR>")
		end
	}

	require("scrollbar.handlers.gitsigns").setup()
end

return M
