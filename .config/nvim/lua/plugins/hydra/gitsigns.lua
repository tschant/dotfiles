local Hydra = require('hydra')

local hint = [[
 _J_: next hunk   _s_: stage hunk        _d_: show deleted   _b_: blame line
 _K_: prev hunk   _u_: undo stage hunk   _p_: preview hunk   _B_: blame show full 
 ^ ^              _S_: stage buffer      ^ ^                 _/_: show base file
 ^
 ^ ^              _<Enter>_: LazyGit              _q_: exit _<Esc>_: exit
]]

Hydra({
   hint = hint,
   config = {
      color = 'pink',
      invoke_on_body = true,
      hint = {
         position = 'bottom',
         border = 'rounded'
      },
      on_enter = function()
				local gitsigns = require('gitsigns')
         vim.bo.modifiable = false
         gitsigns.toggle_signs(true)
         gitsigns.toggle_linehl(true)
      end,
      on_exit = function()
				local gitsigns = require('gitsigns')
         gitsigns.toggle_signs(false)
         gitsigns.toggle_linehl(false)
         gitsigns.toggle_deleted(false)
         vim.cmd 'echo' -- clear the echo area
      end
   },
   mode = {'n','x'},
   body = '<leader>ga',
   heads = {
      { 'J', function()
						local gitsigns = require('gitsigns')
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gitsigns.next_hunk() end)
            return '<Ignore>'
         end, { expr = true } },
      { 'K', function()
						local gitsigns = require('gitsigns')
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
         end, { expr = true } },
      { 's', ':Gitsigns stage_hunk<CR>', { silent = true } },
			{ 'u', ':Gitsigns undo_stage_hunk<CR>' },
      { 'S', ':Gitsigns stage_buffer<CR>' },
      { 'p', ':Gitsigns preview_hunk<CR>' },
      { 'd', ':Gitsigns toggle_deleted<CR>', { nowait = true } },
      { 'b', ':Gitsigns blame_line<CR>' },
      { 'B', function()
				local gitsigns = require('gitsigns')
				gitsigns.blame_line{ full = true }
			end },
			{ '/', ':Gitsigns show<cr>', { exit = true } }, -- show the base of the file
      { '<Enter>', ':FloatermNew lazygit<CR>', { exit = true } },
      { 'q', nil, { exit = true, nowait = true } },
      { '<Esc>', nil, { exit = true, nowait = true } },
   }
})
