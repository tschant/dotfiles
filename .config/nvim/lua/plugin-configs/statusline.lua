local colors = require("utils.colors")
local lsp = require "feline.providers.lsp"
local lsp_severity = vim.diagnostic.severity
local config = {
	-- hide, show on specific filetypes
	hidden = {
		"help",
		"dashboard",
		"NvimTree",
		"terminal",
	},
	shown = {},
	-- truncate statusline on small screens
	shortline = true,
	-- default, round , slant , block , arrow
	style = "arrow",
}

local icon_styles = {
	default = {
		left = "",
		right = " ",
		main_icon = "  ",
		vi_mode_icon = " ",
		position_icon = " ",
	},
	arrow = {
		left = " ",
		right = " ",
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
		left = " ",
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

local mode_colors = {
	["n"] = { "NORMAL", colors.red },
	["no"] = { "N-PENDING", colors.red },
	["i"] = { "INSERT", colors.purple },
	["ic"] = { "INSERT", colors.purple },
	["t"] = { "TERMINAL", colors.green },
	["v"] = { "VISUAL", colors.cyan },
	["V"] = { "V-LINE", colors.cyan },
	[""] = { "V-BLOCK", colors.cyan },
	["v-m"] = { "V-MULTI", colors.cyan },
	["R"] = { "REPLACE", colors.orange },
	["Rv"] = { "V-REPLACE", colors.orange },
	["s"] = { "SELECT", colors.blue },
	["S"] = { "S-LINE", colors.blue },
	[""] = { "S-BLOCK", colors.blue },
	["c"] = { "COMMAND", colors.magenta },
	["cv"] = { "COMMAND", colors.magenta },
	["ce"] = { "COMMAND", colors.magenta },
	["r"] = { "PROMPT", colors.lightblue },
	["rm"] = { "MORE", colors.lightblue },
	["r?"] = { "CONFIRM", colors.lightblue },
	["!"] = { "SHELL", colors.green },
}

local chad_mode_hl = function()
	return {
		fg = colors.bg2,
		bg = mode_colors[vim.fn.mode()][2],
	}
end

-- Left Section
components.active[1][1] = {
	provider = statusline_style.vi_mode_icon,
	hl = function()
		return {
			fg = colors.bg2,
			bg = mode_colors[vim.fn.mode()][2],
		}
	end,
}

components.active[1][2] = {
	provider = function()
		return " " .. mode_colors[vim.fn.mode()][1] .. " "
	end,
	hl = chad_mode_hl,
}

components.active[1][3] = {
	provider = statusline_style.left,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = function ()
		return {
			bg = mode_colors[vim.fn.mode()][2],
			fg = mode_colors[vim.fn.mode()][2],
		}
	end,
	right_sep = {
		str = statusline_style.right,
		hl = function ()
			return {
				bg = colors.bg3,
				fg = mode_colors[vim.fn.mode()][2]
			}
		end
	},
}

-- File info
components.active[1][4] = {
	provider = function()
		local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
		return "  " .. dir_name .. " "
	end,

	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
	end,

	hl = {
		fg = colors.white,
		bg = colors.bg3,
	},
	right_sep = {
		str = statusline_style.right,
		hl = {
			fg = colors.bg3,
			bg = colors.bg2
		}
	},
}

components.active[1][5] = {
	provider = function()
		local filename = vim.fn.expand "%:~:."
		local extension = vim.fn.expand "%:e"
		local icon = require("nvim-web-devicons").get_icon(filename, extension)
		if icon == nil then
			icon = " "
			return icon
		end
		return " " .. icon .. " " .. filename .. " "
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
	end,
	hl = {
		fg = colors.white,
		bg = colors.bg2,
	},
	right_sep = {
		str = statusline_style.right,
		hl = {
			fg = colors.bg2,
			bg = colors.bg
		}
	},
}

-- Lines changed start
components.active[1][6] = {
	provider = "git_diff_added",
	hl = {
		fg = colors.green,
		bg = colors.bg,
	},
	icon = "  ",
}
-- diffModfified
components.active[1][7] = {
	provider = "git_diff_changed",
	hl = {
		fg = colors.blue,
		bg = colors.bg,
	},
	icon = "  ",
}
-- diffRemove
components.active[1][8] = {
	provider = "git_diff_removed",
	hl = {
		fg = colors.red,
		bg = colors.bg,
	},
	icon = "  ",
}

components.active[1][9] = {
	provider = "diagnostic_errors",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.ERROR)
	end,

	hl = { fg = colors.red },
	icon = "  ",
}

components.active[1][10] = {
	provider = "diagnostic_warnings",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.WARN)
	end,
	hl = { fg = colors.yellow },
	icon = "  ",
}

components.active[1][11] = {
	provider = "diagnostic_hints",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.HINT)
	end,
	hl = { fg = colors.blue },
	icon = "  ",
}

components.active[1][12] = {
	provider = "diagnostic_info",
	enabled = function()
		return lsp.diagnostics_exist(lsp_severity.INFO)
	end,
	hl = { fg = colors.green },
	icon = "  ",
}

-- Middle Section
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
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 80
	end,
	hl = {
		fg = colors.green,
		bg = colors.bg
	},
}

-- Right section
components.active[3][1] = {
	provider = function()
		if next(vim.lsp.buf_get_clients()) ~= nil then
			return "   LSP"
		else
			return ""
		end
	end,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
	end,
	hl = {
		fg = colors.white,
		bg = colors.bg2
	},
	left_sep = {
		str = statusline_style.left,
		hl = {
			fg = colors.bg2,
			bg = colors.bg
		}
	},
}

components.active[3][2] = {
	provider = "git_branch",
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 70
	end,
	hl = {
		fg = colors.white,
		bg = colors.bg3,
	},
	icon = "  ",
	left_sep = {
		str = statusline_style.left,
		hl = {
			fg = colors.bg3,
			bg = colors.bg2
		}
	},
}

components.active[3][3] = {
	provider = statusline_style.left,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = colors.lightblue,
		bg = colors.lightblue,
	},
	left_sep = {
		str = statusline_style.left,
		hl = {
			fg = colors.lightblue,
			bg = colors.bg3
		}
	},
}

components.active[3][4] = {
	provider = statusline_style.position_icon,
	enabled = shortline or function(winid)
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,
	hl = {
		fg = colors.black,
		bg = colors.lightblue,
	},
}

components.active[3][5] = {
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
		return vim.api.nvim_win_get_width(tonumber(winid) or 0) > 90
	end,

	hl = {
		fg = colors.bg,
		bg = colors.lightblue,
	},
}

require("feline").setup {
	colors = {
		bg = colors.bg,
		fg = colors.fg,
	},
	components = components,
}
