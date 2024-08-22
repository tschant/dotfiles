return {
	"Isrothy/neominimap.nvim",
	version = "v3.*.*",
	lazy = true,
	event = 'BufReadPre',
	keys = {
		-- Global Minimap Controls
		{ "<leader>nm", "<cmd>lua require('neominimap').toggle()<cr>", desc = "Toggle global minimap" },
		{ "<leader>nr", "<cmd>lua require('neominimap').refresh()<cr>", desc = "Refresh global minimap" },

		---Focus Controls
		{ "<leader>nf", "<cmd>lua require('neominimap').toggleFocus()<cr>", desc = "Switch focus on minimap" },
	},
	init = function()
		vim.g.neominimap = {
			auto_enable = true,
			buf_filter = function(bufnr)
				local line_cnt = vim.api.nvim_buf_line_count(bufnr)
				return line_cnt < 4096 and not vim.b[bufnr].large_buf
			end,
			layout = "split",
			split = {
				minimap_width = 22,
				window_border = { "▏", "", "", "", "", "", "▏", "▏" },
			},
			search = {
				enabled = true,
				mode = "line",
			},
			diagnostic = {
				enabled = true,
				severity = vim.diagnostic.severity.HINT,
				mode = "line",
			},
			exclude_filetypes = {
				"help",
				"alpha",
			},
			winopt = function() 
				return {
					winhighlight = "Normal:NeominimapBackground,FloatBorder:NeominimapBorder,CursorLine:NeominimapCursorLine",
					wrap = false,
					foldcolumn = false,
					signcolumn = "0",
					number = false,
					relativenumber = false,
					scrolloff = 99999, -- To center minimap
					sidescrolloff = 0,
					winblend = 0,
					cursorline = true,
					spell = false,
					list = false,
					fillchars = "eob: ",
					winfixwidth = true,
				}
			end,
		}
	end
}

--[[ return {
	"petertriho/nvim-scrollbar",
	event = "BufReadPost",
	config = function()
		local icons = require('utils.icons')
		local color = require("utils.colors")
		require("scrollbar").setup({
			show = true,
			handle = {
				color = color.bg2
			},
			marks = {
				Error     = { text = {icons.error, icons.error}, color = color.error },
				Warn      = { text = {icons.warn, icons.warn}, color = color.warning },
				Info      = { text = {icons.info, icons.info}, color = color.info },
				Hint      = { text = {icons.hint, icons.hint}, color = color.comments },
				Search    = { text = "", color = color.white },
				GitAdd    = { text = icons.git_add, color = color.green },
				GitChange = { text = icons.git_change, color = color.blue },
				GitDelete = { text = icons.git_delete, color = color.red },
			}
		})
	end
} ]]
--[[ return {
	"gorbit99/codewindow.nvim",
	-- dir = "~/codewindow.nvim",
	lazy = true,
	enabled = true,
	event = {
		'BufRead'
	},
	opts = {
		auto_enable = true,
		exclude_filetypes = {
			"qf",
			"help",
		},
		minimap_width = 20,
		use_lsp = true,
		use_treesitter = true,
		use_git = true,
		width_multiplier = 4,
		z_index = 1,
		show_cursor = true,
		screen_bounds = "background",
		window_border = "none",
		-- window_border = { "", "", "", "", "", "", "", "" },
		relative = "win",
		events = {
			"LspAttach",
			"BufEnter",
			"BufNewFile",
			"BufRead",
			"TextChanged",
			"InsertLeave",
			"DiagnosticChanged",
			"FileWritePost",
		},
	},
} ]]

