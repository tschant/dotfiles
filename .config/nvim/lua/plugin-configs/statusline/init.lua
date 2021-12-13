local colors = require("plugin-configs.colors").dark
local lsp = require "feline.providers.lsp"
local config = Statusline

local icon_styles = {
	default = {
		left = "",
		right = " ",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},
	arrow = {
		left = "",
		right = "",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},

	block = {
		left = " ",
		right = " ",
		main_icon = "   ",
		vi_mode_icon = "  ",
		position_icon = "  ",
	},

	round = {
		left = "",
		right = "",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},

	slant = {
		left = " ",
		right = " ",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},
}

-- statusline style
local user_statusline_style = config.style
local statusline_style = icon_styles[user_statusline_style]

-- show short statusline on small screens
local shortline = config.shortline == false and true

-- Initialize the components table
local components = {
	active = {},
	inactive = {},
}

table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

components.active[1][1] = {
	provider = statusline_style.main_icon,

	hl = {
		fg = colors.bg,
		bg = colors.comments,
	},

	right_sep = { str = statusline_style.right, hl = {
		fg = colors.comments,
		bg = colors.bg2,
	} },
}

components.active[1][2] = {
	provider = function()
		local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
		return "  " .. dir_name .. " "
	end,

	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 80
	end,

	hl = {
		fg = colors.grey,
		bg = colors.bg2,
	},
	right_sep = {
		str = statusline_style.right,
		hi = {
			fg = colors.bg2,
			bg = colors.bg,
		},
	},

	right_sep = { str = statusline_style.right, hl = { fg = colors.bg2, bg = colors.bg } },

}

components.active[1][3] = {
	provider = function()
		local filename = vim.fn.expand "%:t"
		local extension = vim.fn.expand "%:e"
		local icon = require("nvim-web-devicons").get_icon(filename, extension)
		if icon == nil then
			icon = " "
			return icon
		end
		return " " .. icon .. " " .. filename .. " "
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 70
	end,
	hl = {
		fg = colors.white,
		bg = colors.bg,
	}
}


components.active[1][4] = {
	provider = "git_diff_added",
	hl = {
		fg = colors.grey,
		bg = colors.bg,
	},
	icon = " ",
}
-- diffModfified
components.active[1][5] = {
	provider = "git_diff_changed",
	hl = {
		fg = colors.grey_fg2,
		bg = colors.statusline_bg,
	},
	icon = "   ",
}
-- diffRemove
components.active[1][6] = {
	provider = "git_diff_removed",
	hl = {
		fg = colors.grey,
		bg = colors.bg,
	},
	icon = "  ",
}

components.active[1][7] = {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist "Error"
	end,

	hl = { fg = colors.red },
	icon = "  ",
}

components.active[1][8] = {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist "Warning"
	end,
	hl = { fg = colors.yellow },
	icon = "  ",
}

components.active[1][9] = {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist "Hint"
	end,
	hl = { fg = colors.grey },
	icon = "  ",
}

components.active[1][10] = {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist "Information"
	end,
	hl = { fg = colors.chartreuse3 },
	icon = "  ",
}

components.active[2][1] = {
	provider = function()
		local Lsp = vim.lsp.util.get_progress_messages()[1]

		if Lsp then
			local msg = Lsp.message or ""
			local percentage = Lsp.percentage or 0
			local title = Lsp.title or ""
			local spinners = {
				"",
				"",
				"",
			}

			local success_icon = {
				"",
				"",
				"",
			}

			local ms = vim.loop.hrtime() / 1000000
			local frame = math.floor(ms / 120) % #spinners

			if percentage >= 70 then
				return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
			end

			return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
		end

		return ""
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 80
	end,
	hl = { fg = colors.green },
}

components.active[3][1] = {
	provider = function()
		if next(vim.lsp.buf_get_clients()) ~= nil then
			return "  LSP"
		else
			return ""
		end
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 70
	end,
	hl = {
		fg = colors.grey,
		bg = colors.bg
	},
}

components.active[3][2] = {
	provider = "git_branch",
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 70
	end,
	hl = {
		fg = colors.grey,
		bg = colors.bg,
	},
	icon = "  ",
}

components.active[3][3] = {
	provider = " " .. statusline_style.left,
	hl = {
		fg = colors.bg,
		bg = colors.bg,
	},
}

local mode_colors = {
	["n"] = { "NORMAL", colors.red },
	["no"] = { "N-PENDING", colors.red },
	["i"] = { "INSERT", colors.purple },
	["ic"] = { "INSERT", colors.purple },
	["t"] = { "TERMINAL", colors.green },
	["v"] = { "VISUAL", colors.cyan },
	["V"] = { "V-LINE", colors.cyan },
	[""] = { "V-BLOCK", colors.cyan },
	["R"] = { "REPLACE", colors.orange },
	["Rv"] = { "V-REPLACE", colors.orange },
	["s"] = { "SELECT", colors.blue },
	["S"] = { "S-LINE", colors.blue },
	[""] = { "S-BLOCK", colors.blue },
	["c"] = { "COMMAND", colors.plum3 },
	["cv"] = { "COMMAND", colors.plum3 },
	["ce"] = { "COMMAND", colors.plum3 },
	["r"] = { "PROMPT", colors.SkyBlue2 },
	["rm"] = { "MORE", colors.SkyBlue2 },
	["r?"] = { "CONFIRM", colors.SkyBlue2 },
	["!"] = { "SHELL", colors.green },
}

local chad_mode_hl = function()
	return {
		fg = colors.bg2,
		bg = mode_colors[vim.fn.mode()][2],
	}
end

components.active[3][4] = {
	provider = statusline_style.left,
	hl = function()
		return {
			fg = mode_colors[vim.fn.mode()][2],
			bg = colors.bg,
		}
	end,
}

components.active[3][5] = {
	provider = statusline_style.vi_mode_icon,
	hl = function()
		return {
			fg = colors.bg2,
			bg = mode_colors[vim.fn.mode()][2],
		}
	end,
}

components.active[3][6] = {
	provider = function()
		return " " .. mode_colors[vim.fn.mode()][1] .. " "
	end,
	hl = chad_mode_hl,
}

components.active[3][7] = {
	provider = statusline_style.left,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 90
	end,
	hl = function ()
		return {
			fg = colors.comments,
			bg = mode_colors[vim.fn.mode()][2],
		}
	end,
}

components.active[3][8] = {
	provider = statusline_style.left,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 90
	end,
	hl = {
		fg = colors.comments,
		bg = colors.comments,
	},
}

components.active[3][9] = {
	provider = statusline_style.position_icon,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 90
	end,
	hl = {
		fg = colors.black,
		bg = colors.comments,
	},
}

components.active[3][10] = {
	provider = function()
		local current_line = vim.fn.line "."
		local total_line = vim.fn.line "$"

		if current_line == 1 then
			return " Top "
		elseif current_line == vim.fn.line "$" then
			return " Bot "
		end
		local result, _ = math.modf((current_line / total_line) * 100)
		return " " .. result .. "%% "
	end,

	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(winid) > 90
	end,

	hl = {
		fg = colors.bg,
		bg = colors.comments,
	},
}

require("feline").setup {
	colors = {
		bg = colors.bg,
		fg = colors.fg,
	},
	components = components,
}
