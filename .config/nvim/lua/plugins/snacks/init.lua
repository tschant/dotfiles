return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Enabled plugins
		bufdelete = { enabled = true },
		bigfile = require("plugins.snacks.bigfile"),
		dashboard = require("plugins.snacks.dashboard"),
		indent = require("plugins.snacks.indent"),
		quickfile = { enabled = true },
		scope = { enabled = true },
		scroll = { enabled = true },
		words = { enabled = true },
		-- disabled
		explorer = { enabled = false }, -- neo-tree
		picker = require("plugins.snacks.picker"), -- telescope
		input = { enabled = false },
		notifier = { enabled = false },
		statuscolumn = { enabled = false },
		terminal = { enabled = false },
	},
	keys = {
        { "<leader><Home>", ":lua Snacks.dashboard()<CR>", desc = "Dashboard" },
        {
            "<C-q>",
            function()
                Snacks.bufdelete.delete()
            end,
            desc = "Close buffer",
        },

        { "gR", function() Snacks.picker.lsp_references({ include_declaration = false }) end, desc = "References" },
        { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Definitions" },
        { "gs", function() Snacks.picker.lsp_document_symbols({ 
            symbols = {
                "Class", "Function", "Method", "Constructor",
                "Interface", "Module", "Struct", "Trait", "Field", "Property",
            } 
        }) 
        end, desc = "Goto Symbol" },

        -- Files
        { "<C-p>", function() Snacks.picker.files({ cwd = vim.loop.cwd() }) end, desc = "Find files (cwd)" },
        { "<C-S-p>", function() Snacks.picker.commands() end, desc = "Show command prompt" },

        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>fF", function() Snacks.picker.files({ root = true }) end, desc = "Find files (root dir)" },
        { "<leader>ff", function() Snacks.picker.files({ cwd = vim.loop.cwd() }) end, desc = "Find files (cwd)" },
        { "<leader>fG", function() Snacks.picker.grep({ open = true }) end, desc = "Grep open files" },
        { "<leader>fg", function() Snacks.picker.grep({ cwd = vim.loop.cwd() }) end, desc = "Grep files (cwd)" },
        { "<leader>fW", function() Snacks.picker.grep_word({ root = true }) end, desc = "Search word (root dir)" },
        { "<leader>fw", function() Snacks.picker.grep_word({ cwd = vim.loop.cwd() }) end, desc = "Search word (cwd)" },

        -- Buffers & history
        { "<leader>fb", function() Snacks.picker.buffers() end, desc = "List buffers" },
        { "<leader>fo", function() Snacks.picker.recent() end, desc = "Recently opened files" },
        { "<leader>fj", function() Snacks.picker.jumps() end, desc = "Jumplist" },
        { "<leader>fh", function() Snacks.picker.harpoon() end, desc = "Harpoon" },
        { "<leader>fH", function() Snacks.picker.help() end, desc = "Vim help" },
        { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
        { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
        -- { "<leader>fO", function() Snacks.picker.options() end, desc = "Vim options" },
        { "<leader>fr", function() Snacks.picker.registers() end, desc = "Registers" },
        { "<leader>fs", function()
            local possession = require('possession')
            local sessions = possession.list()
            local items = {}
            local current_dir = vim.fn.getcwd()

            for name, session in pairs(sessions) do
                if session.cwd:find(current_dir, 1, true) or current_dir:find(session.cwd, 1, true) then
                    table.insert(items, {
                        text = session.name,
                        file = session.name,
                        value = session,
                        preview = {text = session.vimscript},
                    })
                end
            end
     
            if #items == 0 then
                vim.notify("No sessions found", vim.log.levels.WARN)
                return
            end

            Snacks.picker.pick({
                source = "sessions",
                title = "Load Session",
                items = items,
                -- layout = { preview = false },
                actions = {
                    confirm = function(picker, item)
                        if item and item.value then
                            possession.load(item.value)
                        end
                        picker:close()
                    end
                }
            })
        end,
            desc = "Load Session"
        },
        { "<leader>fS", function() Snacks.picker.spelling({preview=false}) end, desc = "Spell suggest" },
        { "<leader>f/", function() Snacks.picker.grep_buffers() end, desc = "Search in open buffers" },
        { "<leader>f?", function() Snacks.picker.search_history() end, desc = "Search history" },
        { "<leader>fC", function() Snacks.picker.command_history() end, desc = "Command-line history" },
        { "<leader>fc", function() Snacks.picker.commands() end, desc = "Show commands" },
        { "<leader>fx", function() Snacks.picker.colorschemes() end, desc = "Colorscheme picker" },
        { "<leader>fu", "<cmd>silent! %foldopen! | UndotreeToggle<cr>", desc = "Undotree" },
        { "<leader>fds", function() Snacks.picker.lsp_symbols() end, desc = "Doc symbols" },
        { "<leader>fdS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },
        { "<leader>ft", function() Snacks.picker.treesitter() end, desc = "Treesitter symbols" },

        -- Git
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git branches" },
        { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git commits" },
        { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git diff" },
        { "<leader>gf", function() Snacks.picker.git_files() end, desc = "Git files" },
        { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
    },
}
