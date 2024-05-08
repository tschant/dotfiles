require('horizon')
local autocmd = vim.api.nvim_create_autocmd
local u = require("utils.colorscheme")
local Theme = "horizon"
local ok, _ = pcall(u.setColorScheme, Theme)
if not ok then
  print("error setting colorscheme")
end

autocmd("BufEnter", {
	pattern = { 'sql', '*.sql' },
	callback = function()
		u.setColorScheme(Theme)
	end,
})
