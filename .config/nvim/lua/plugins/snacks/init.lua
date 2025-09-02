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

    { "<leader>fF", function() Snacks.picker.files({ root = true }) end, desc = "Find files (root dir)" },
    { "<leader>ff", function() Snacks.picker.files({ cwd = vim.loop.cwd() }) end, desc = "Find files (cwd)" },
    { "<leader>fG", function() Snacks.picker.grep({ open = true }) end, desc = "Grep open files" },
    { "<leader>fg", function() Snacks.picker.grep({ cwd = vim.loop.cwd() }) end, desc = "Grep files (cwd)" },
    { "<leader>fW", function() Snacks.picker.grep_word({ root = true }) end, desc = "Search word (root dir)" },
    { "<leader>fw", function() Snacks.picker.grep_word({ cwd = vim.loop.cwd() }) end, desc = "Search word (cwd)" },

    -- Buffers & history
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "List buffers" },
    { "<leader>fo", function() Snacks.picker.oldfiles() end, desc = "Recently opened files" },
    { "<leader>fj", function() Snacks.picker.jumplist() end, desc = "Jumplist" },
    { "<leader>fh", function() Snacks.picker.harpoon() end, desc = "Harpoon" },
    { "<leader>fH", function() Snacks.picker.help() end, desc = "Vim help" },
    { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fO", function() Snacks.picker.options() end, desc = "Vim options" },
    { "<leader>fr", function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>fs", function() Snacks.picker.sessions({ only_cwd = true }) end, desc = "Sessions" },
    { "<leader>fS", function() Snacks.picker.spell_suggest() end, desc = "Spell suggest" },
    { "<leader>f/", function() Snacks.picker.current_buffer_fuzzy_find() end, desc = "Search in file" },
    { "<leader>f?", function() Snacks.picker.search_history() end, desc = "Search history" },
    { "<leader>fC", function() Snacks.picker.command_history() end, desc = "Command-line history" },
    { "<leader>fc", function() Snacks.picker.commands() end, desc = "Show commands" },
    { "<leader>fx", function() Snacks.picker.colorscheme({ preview = true }) end, desc = "Colorscheme picker" },
    { "<leader>fu", "<cmd>silent! %foldopen! | UndotreeToggle<cr>", desc = "Undotree" },
    { "<leader>fds", function() Snacks.picker.lsp_document_symbols() end, desc = "Doc symbols" },
    { "<leader>fdS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace symbols" },
    { "<leader>ft", function() Snacks.picker.treesitter() end, desc = "Treesitter symbols" },

    -- Git
    { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git branches" },
    { "<leader>gc", function() Snacks.picker.git_commits() end, desc = "Git commits" },
    { "<leader>gf", function() Snacks.picker.git_files() end, desc = "Git files" },
    { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git status" },
	},
}
