local M = {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
}

M.config = function()
	require('dressing').setup({
		select = {
			telescope = {
				layout_config = {
					width = 120,
					height = 25,
				},
			},
		},
	})
end

return M
