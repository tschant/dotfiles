return {
	-- Markdown
	{ "iamcco/markdown-preview.nvim", build = "cd app && yarn install", event = "BufRead *.md" },

	-- Terraform
	{ "hashivim/vim-terraform", event = "BufReadPre *.tf" },
	{ "juliosueiras/vim-terraform-completion", event = "BufRead *.tf" },

	-- General pluginscomment
	{ "jake-stewart/multicursor.nvim", config = true },

	{
		"NMAC427/guess-indent.nvim",
		event = "BufRead",
		config = function()
			require("guess-indent").setup({
				auto_cmd = true,
			})
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = "BufReadPre",
		config = true,
		keys = {
			{
				"<c-_>",
				':lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>',
				desc = "Comment line",
				mode = { "x" },
			},
			{ "<C-_>", ':lua require("Comment.api").toggle_current_linewise()<CR>', desc = "ctrl-/" },
		},
	},
	{
		"kylechui/nvim-surround",
		event = "BufReadPre",
		init = function()
			-- Disable all default keymaps (v4 requirement)
			vim.g.nvim_surround_no_mappings = true
		end,
		keys = {
			-- Insert mode
			{ "<C-g>s", "<Plug>(nvim-surround-insert)", mode = "i", desc = "Add surround (insert)" },
			{ "<C-g>S", "<Plug>(nvim-surround-insert-line)", mode = "i", desc = "Add surround on new lines (insert)" },

			-- Normal mode - add surround
			{ "<leader>ys", "<Plug>(nvim-surround-normal)", desc = "Add surround around motion" },
			{ "<leader>yss", "<Plug>(nvim-surround-normal-cur)", desc = "Add surround around line" },
			{ "<leader>yS", "<Plug>(nvim-surround-normal-line)", desc = "Add surround around motion (new lines)" },
			{ "<leader>ySS", "<Plug>(nvim-surround-normal-cur-line)", desc = "Add surround around line (new lines)" },

			-- Visual mode
			{ "<leader>S", "<Plug>(nvim-surround-visual)", mode = "x", desc = "Add surround around selection" },
			{ "<leader>gS", "<Plug>(nvim-surround-visual-line)", mode = "x", desc = "Add surround around selection (new lines)" },

			-- Delete surround
			{ "<leader>ds", "<Plug>(nvim-surround-delete)", desc = "Delete surround" },

			-- Change surround
			{ "<leader>cs", "<Plug>(nvim-surround-change)", desc = "Change surround" },
			{ "<leader>cS", "<Plug>(nvim-surround-change-line)", desc = "Change surround (new lines)" },
		},
		config = function()
			-- Call setup for any other configuration (if needed)
			require("nvim-surround").setup({})
		end,
	},
	-- {"ggandor/lightspeed.nvim", event = "BufReadPre"},

	-- Multi-line plugins
	{
		"anuvyklack/fold-preview.nvim",
		branch = "main",
		event = "BufReadPre",
		dependencies = "anuvyklack/nvim-keymap-amend",
		config = true,
	},
	{
		"kevinhwang91/nvim-hlslens",
		branch = "main",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlslens").setup({
				build_position_cb = function(plist, bufnr, changedtick, pattern)
					require("scrollbar").search_handler.show(plist.start_pos)
				end,
				override_lens = function(render, plist, nearest, idx, r_idx)
					local sfw = vim.v.searchforward == 1
					local indicator, text, chunks
					local abs_r_idx = math.abs(r_idx)
					if abs_r_idx > 1 then
						indicator = string.format("%d%s", abs_r_idx, sfw ~= (r_idx > 1) and "N" or "n")
					elseif abs_r_idx == 1 then
						indicator = sfw ~= (r_idx == 1) and "N" or "n"
					else
						indicator = ""
					end

					local lnum, col = unpack(plist[idx])
					local cnt = #plist
					if nearest then
						if indicator ~= "" then
							text = string.format("[%s %d/%d]", indicator, idx, cnt)
						else
							text = string.format("[%d/%d]", idx, cnt)
						end
						chunks = { { " ", "Ignore" }, { text, "HlSearchLensNear" } }
					else
						text = string.format("[%s %d/%d]", indicator, idx, cnt)
						chunks = { { " ", "Ignore" }, { text, "HlSearchLens" } }
					end
					render.set_virt(0, lnum - 1, col - 1, chunks, nearest)
				end,
			})
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "BufReadPre",
		config = function()
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
	-- Measure startuptime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
}
