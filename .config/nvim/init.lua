local modules = {
	-- General settings
	"key-maps",
	-- "colorscheme",
	"autocmds",
	-- Plugins
	"plugin-configs/general",
	"plugin-configs/nvim-tree",
	"plugin-configs/dashboard",
	"plugin-configs/terminal",
	"plugin-configs/telescope",
	"plugin-configs/emmet",
	"plugin-configs/statusline",
	"plugin-configs/vimwiki",
	"plugin-configs/git-signs",
	-- "plugin-configs/bufferline",
	-- LSP
	"lsp/completion",
	"lsp/init",
	-- "lsp/jdtls",
	"hydra/all",
}

-- No external requires, global configs
require("config")
require("options")
require("plugins")
require("colorscheme")
-- require("utils/core")
-- require("utils/extra")


local impatientOk, retval = pcall(require,'impatient')
if impatientOk then
	retval.enable_profile()
else
	print("Impatient failed to load" .. retval)
end
for _, module in ipairs(modules) do
	local ok, err = pcall(require, module)
	if not ok then
		-- This was error, updated to keep loading configs without error
		print("Error loading " .. module .. "\n\n" .. err)
	end
end
