return {
	-- Window splitting
	"beauwilliams/focus.nvim",

	-- Markdown
	{ "iamcco/markdown-preview.nvim", build = "cd app && yarn install", event = "BufRead *.md" },

	-- Terraform
	{ "hashivim/vim-terraform", event = "BufReadPre *.tf" },
	{ "juliosueiras/vim-terraform-completion", event = "BufRead *.tf" },

	-- General pluginscomment
	{ "jake-stewart/multicursor.nvim", config = true },
	
	{
		"wurli/visimatch.nvim",
		event = "BufRead",
		opts = {},
	},
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
	},
	{
		"kylechui/nvim-surround",
		event = "BufReadPre",
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					insert = "<C-g>s",
					insert_line = "<C-g>S",
					normal = "<leader>ys",
					normal_cur = "<leader>yss",
					normal_line = "<leader>yS",
					normal_cur_line = "<leader>ySS",
					visual = "<leader>S",
					visual_line = "<leader>gS",
					delete = "<leader>ds",
					change = "<leader>cs",
					change_line = "<leader>cS",
				},
			})
		end,
	},
	-- {"ggandor/lightspeed.nvim", event = "BufReadPre"},
	{
		"phaazon/hop.nvim",
		config = true,
	},

	-- Multi-line plugins
	--[[ {
		"anuvyklack/pretty-fold.nvim",
		branch = "master",
		event = "BufRead",
		dependencies = 'anuvyklack/nvim-keymap-amend',
		config = function()
			require("pretty-fold").setup({
				keep_indentation = false,
				fill_char = '━',
				sections = {
					left = {
						function() return string.rep('>', vim.v.foldlevel) end,
						' ', 'number_of_folded_lines', ':', 'content', 'percentage', ' ┣━━',
					},
					right = {
						'┫'
					}
				}
			})
		end
	}, ]]
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
	{
		"mrjones2014/smart-splits.nvim",
		config = true,
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},
	{ "nvim-pack/nvim-spectre" },

	-- Measure startuptime
	{
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
		config = function()
			vim.g.startuptime_tries = 10
		end,
	},
}
