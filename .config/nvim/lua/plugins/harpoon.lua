return {
	{
		"cbochs/portal.nvim",
		dependencies = {
			"ThePrimeagen/harpoon",
		},
		config = true,
		opts = {
			max_results = 8,
			labels = {
				"h",
				"j",
				"k",
				"l",
				"a",
				"s",
				"d",
				"f",
			},
			window_options = {
        relative = "cursor",
        width = 80,
        height = 5,
        col = 2,
        focusable = false,
        border = "single",
        noautocmd = true,
    },
		},
	},
	{
		"ThePrimeagen/harpoon",
		-- branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" } --[[ ,
	config = function()
		local harpoon = require('harpoon')
		harpoon:setup({})

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = conf.file_previewer({}),
				sorter = conf.generic_sorter({}),
			}):find()
		end

		vim.keymap.set("n", "<leader>'m", function() harpoon:list():append() end, {desc = "Harpoon add file"})
		vim.keymap.set("n", "<leader>'n", function() harpoon:list():remove() end, {desc = "Harpoon remove file"})
		-- vim.keymap.set("n", "<leader>'h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
	end ]],
	},
}
