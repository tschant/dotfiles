-- General settings
require("config")
require("options")
require("mappings")
require("pluginList")
require("colorscheme")
require("autocmds")

-- Plugins
require("plugin-configs/general")
require("plugin-configs/nvim-tree")
require("plugin-configs/statusline")
require("plugin-configs/dashboard")
require("plugin-configs/indent-guides")
require("plugin-configs/terminal")
require("plugin-configs/telescope")
require("plugin-configs/emmet")
require("plugin-configs/treesitter")
-- require("plugin-configs/navigator")

require("lsp/init")
require("lsp/completion")

-- require("utils/core")
-- require("utils/extra")
