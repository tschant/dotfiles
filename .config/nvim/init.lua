-- General settings
require("config")
require("options")
require("mappings")
require("pluginList")
require("colorscheme")
require("autocmds")

-- Plugins
require("plugins/general")
require("plugins/nvim-tree")
require("plugins/statusline")
require("plugins/dashboard")
require("plugins/indent-guides")
require("plugins/terminal")
require("plugins/telescope")
require("plugins/emmet")
require("plugins/treesitter")

require("lsp/init")
require("lsp/completion")

-- require("utils/core")
-- require("utils/extra")
