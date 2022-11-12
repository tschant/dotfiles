local setup_plugin = require("utils.core").setup_plugin
setup_plugin("bufferline", {
	options = {
		offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
		numbers = "buffer_id",
		middle_mouse_command = "BufDel",
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
})
