local colors = require("colors").dark
require("bufferline").setup {
	options = {
		offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
		middle_mouse_command = "bdelete! %d",
		right_mouse_command = "vertical sbuffer %d",
		indicator_icon = '▎',
		buffer_close_icon = '',
		modified_icon = '●',
		close_icon = '',
		left_trunc_marker = '',
		right_trunc_marker = '',
		show_close_icon = false,
		max_name_length = 14,
		max_prefix_length = 13,
		tab_size = 20,
		show_tab_indicators = true,
		enforce_regular_tabs = false,
		view = "multiwindow",
		show_buffer_close_icons = true,
		separator_style = "thin",
		always_show_bufferline = true,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		custom_filter = function(buf_number)
			-- Func to filter out our managed/persistent split terms
			local present_type, type = pcall(function()
				return vim.api.nvim_buf_get_var(buf_number, "term_type")
			end)
			if present_type then
				if type == "vert" then
					return false
				elseif type == "hori" then
					return false
				end
				return true
			end
			return true
		end,
	},
	highlights = {
	}
	--[[ ,
		background = {
			guifg = colors.grey,
		-- guibg = colors.bg2,
		},
		buffer_selected = {
			guifg = colors.grey,
			guibg = colors.bg,
			gui = "bold",
		},
		buffer_visible = {
			guifg = colors.grey,
		-- guibg = colors.bg2,
		},
			-- for diagnostics = "nvim_lsp"
		error = {
			guifg = colors.grey,
			-- guibg = colors.bg2,
		},
		error_diagnostic = {
			guifg = colors.grey,
		-- guibg = colors.bg2,
		},
	-- close buttons
		close_button = {
			guifg = colors.grey,
		-- guibg = colors.bg2,
		},
		close_button_visible = {
			guifg = colors.grey,
		-- guibg = colors.bg2,
		},
		close_button_selected = {
			guifg = colors.red,
		-- guibg = colors.bg2,
		},
		fill = {
			guifg = colors.grey,
		-- guibg = colors.bg2,
		},
		indicator_selected = {
			guifg = colors.bg2,
		-- guibg = colors.bg2,
		},
		-- modified
		modified = {
			guifg = colors.red,
		-- guibg = colors.bg2,
		},
		modified_visible = {
			guifg = colors.red,
		-- guibg = colors.bg2,
		},
		modified_selected = {
			guifg = colors.green,
			guibg = colors.bg,
		},
		-- separators
		separator = {
			guifg = colors.grey,
			guibg = colors.grey,
		},
		separator_visible = {
			guifg = colors.grey,
			guibg = colors.grey,
		},
		separator_selected = {
			guifg = colors.grey,
			guibg = colors.grey,
		},
		-- tabs
		tab = {
			guifg = colors.grey,
			guibg = colors.bg,
		},
		tab_selected = {
			guifg = colors.bg2,
			guibg = colors.blue,
		},
		tab_close = {
			guifg = colors.red,
			guibg = colors.black,
		},
	}, ]]
}
