local winbar = {}

local colors = require("colors").get()
vim.api.nvim_set_hl(0, "WinBarSeparator", { fg = colors.grey })
vim.api.nvim_set_hl(0, "WinBarContent", { fg = colors.green, bg = colors.grey })

winbar.eval = function()
    if vim.api.nvim_eval_statusline("%f",{})["str"] == "[No Name]" then
        return ""
    end
    return "%#WinBarSeparator#"
        .. ""
        .. "%*"
        .. "%#WinBarContent#"
        .. "%f"
        .. "%*"
        .. "%#WinBarSeparator#"
        .. ""
        .. "%*"
end

return winbar
