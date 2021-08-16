local g = vim.g
local fn = vim.fn

g.dashboard_disable_at_vimenter = 0 -- dashboard is disabled by default
g.dashboard_disable_statusline = 1
g.dashboard_default_executive = "telescope"

g.dashboard_custom_header = {
		"          ▀████▀▄▄              ▄█ ",
		"            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ",
		"    ▄        █          ▀▀▀▀▄  ▄▀  ",
		"   ▄▀ ▀▄      ▀▄              ▀▄▀  ",
		"  ▄▀    █     █▀   ▄█▀▄      ▄█    ",
		"  ▀▄     ▀▄  █     ▀██▀     ██▄█   ",
		"   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ",
		"    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ",
		"   █   █  █      ▄▄           ▄▀   "
}
--[[ g.dashboard_custom_header = {
    "                                   ",
    "                                   ",
    "                                   ",
    "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆         ",
    "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
    "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
    "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
    "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
    "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
    "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
    " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
    " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
    "    ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆       ",
    "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
    "                                   "
} ]]

g.dashboard_custom_section = {
    a = {description = {"  Find File                 , f f"}, command = "Telescope find_files"},
    b = {description = {"  Recents                   , f o"}, command = "Telescope oldfiles"},
    c = {description = {"  Projects                  , f p"}, command = "Telescope projects"},
    d = {description = {"  Find Word                 , f g"}, command = "Telescope live_grep"},
    e = {description = {"洛 New File                  , f n"}, command = "DashboardNewFile"},
    f = {description = {"  Bookmarks                 , b m"}, command = "Telescope marks"},
    g = {description = {"  Load Last Session         , s l"}, command = "SessionLoad"}
}

g.dashboard_custom_footer = {
    "   ",
    "TDS"
}
