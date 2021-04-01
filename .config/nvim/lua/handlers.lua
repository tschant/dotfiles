require("config")

C = Theming.colorscheme:gsub("%s+", "")
CS = Theming.colorscheme_style:gsub("%s+", "")

if C == "" or C == nil then
    C = "horizon"
end

local styles = {
    gruvbox = {
        "medium",
        "soft",
        "hard"
    }
}

local function check_theme(theme)
    local style
    if theme == "gruvbox" then
        style = styles.gruvbox
    end
    if style ~= nil then
        if CS == "" or CS == nil then
            CS = style[1]
        end
    end
end
check_theme(C)
