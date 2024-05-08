require('material')
local autocmd = vim.api.nvim_create_autocmd
local u = require("utils.colorscheme")
local Theme = "material-deep-ocean"
local ok, _ = pcall(u.setColorScheme, Theme)
if not ok then
  print("error setting colorscheme")
end

autocmd("BufEnter", {
	pattern = { 'markdown', '*.md' },
	callback = function()
		u.setColorScheme(Theme)
	end,
})
