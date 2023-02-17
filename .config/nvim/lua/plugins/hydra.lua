return {
	'anuvyklack/hydra.nvim',
	event = 'VeryLazy',
	config = function()
		local Hydra = require('hydra')
		Hydra({
			name = 'Splits',
			mode = 'n',
			body = '<leader>w',
			config = {
				color = 'pink',
				hint = {
					type = 'statusline',
				},
			},
			heads = {
				{ 'H', function() require('smart-splits').resize_left(2)  end, {desc = 'Resize split left'} },
				{ 'J', function() require('smart-splits').resize_down(2)  end, {desc = 'Resize split down'} },
				{ 'K', function() require('smart-splits').resize_up(2)    end, {desc = 'Resize split up'} },
				{ 'L', function() require('smart-splits').resize_right(2) end, {desc = 'Resize split right'} },
			}
		})
	end
}
