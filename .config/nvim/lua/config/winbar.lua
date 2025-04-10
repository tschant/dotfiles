local colors = require("utils.colors")
local winbar = {}

local function get_winbar_path()
	local full_path = vim.fn.expand("%:p")
	return full_path:gsub(vim.fn.expand("$HOME"), "~")
end

local function get_buffer_count()
	local buffers = vim.fn.execute("ls")
	local count = 0
	-- Match only lines that represent buffers, typically starting with a number followed by a space
	for line in string.gmatch(buffers, "[^\r\n]+") do
		if string.match(line, "^%s*%d+") then
			count = count + 1
		end
	end
	return count
end

winbar.eval = function()
	if vim.api.nvim_eval_statusline("%f", {})["str"] == "[No Name]" then
		return ""
	end
	local default_name = vim.api.nvim_eval_statusline("%f", {})["str"]
	local home_replaced = get_winbar_path()
	local buffer_count = get_buffer_count()
	local buff_name = home_replaced == "" and default_name or home_replaced
	local is_changed = vim.fn.getbufinfo("%")[1].changed
	if is_changed == 1 then
		buff_name =  buff_name .. "  "
		vim.cmd("hi TabLineSel guifg=" .. colors.error .. " guibg=" .. colors.bg2)
	else
		vim.cmd("hi TabLineSel guifg=" .. colors.white .. " guibg=" .. colors.bg2)
	end

	return "%#WinBarSeparator#"
		.. "%#WinBar2#("
		.. buffer_count
		.. ") "
		.. "%#TabLineSel#"
		.. " "
		.. "%*"
		.. "%#TabLineSel#"
		.. buff_name
		.. "%*"
		.. "%#TabLineSel#"
		.. " "
		.. "%*"
end

-- Autocmd to update the winbar on BufEnter and WinEnter events
-- vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
--   callback = winbar.eval,
-- })

return winbar
