require("projections").setup({
	workspaces = {
		"~/git",
		"~/git/analyst-ng",
		"~/git/analyst-ng/boxbe/webapp-boxbe/src/main",
		"~/git/analyst-ng/source/webapp-analyst-ng/src/main",
		"~/git/analyst-ng/source/webapp-admin-ng/src/main",
		"~/git/analyst-ng/source/webapp-delivery-index/src/main",
		"~/git/team-ea",
		"~/git/tschant",
	},
	patterns = {
		".git",
		".svn",
		".hg",
		"package.json",
	},
})

-- Add workspace command
local Workspace = require("projections.workspace")
vim.api.nvim_create_user_command("AddWorkspace", function() 
    Workspace.add(vim.loop.cwd()) 
end, {})

-- local Session = require("projections.session")
-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     callback = function()
--         if vim.fn.argc() ~= 0 then return end
--         local session_info = Session.info(vim.loop.cwd())
--         if session_info == nil then
--             Session.restore_latest()
--         else
--             Session.restore(vim.loop.cwd())
--         end
--     end,
--     desc = "Restore last session automatically"
-- })

-- vim.api.nvim_create_user_command("StoreProjectSession", function()
--     Session.store(vim.loop.cwd())
-- end, {})

-- vim.api.nvim_create_user_command("RestoreProjectSession", function()
--     Session.restore(vim.loop.cwd())
-- end, {})

-- Autostore session on DirChange and VimExit
-- local Session = require("projections.session")
-- vim.api.nvim_create_autocmd({ 'DirChangedPre', 'VimLeavePre' }, {
-- 	callback = function() Session.store(vim.loop.cwd()) end,
-- 	desc = "Store project session",
-- })

