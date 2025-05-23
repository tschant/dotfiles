if _G.StatusColumn then
	return
end

local icons = require("utils.icons")
local hl_groups = require("utils.hl_groups")
local utils = require("utils.extra")
_G.StatusColumn = {
	handler = {
		fold = function()
			local lnum = vim.fn.getmousepos().line

			-- Only lines with a mark should be clickable
			if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
				return
			end

			local state
			if vim.fn.foldclosed(lnum) == -1 then
				state = "close"
			else
				state = "open"
			end

			vim.cmd.execute("'" .. lnum .. "fold" .. state .. "'")
		end,
		gitsign = function()
			StatusColumn.handler.move_cursor(minwid, clicks, button, mods)
			vim.schedule(function()
				require("gitsigns").preview_hunk()
			end)
		end,
		diag = function(minwid, clicks, button, mods)
			StatusColumn.handler.move_cursor(minwid, clicks, button, mods)
			vim.schedule(function()
				vim.diagnostic.open_float()
			end)
		end,
		move_cursor = function()
			local mousepos = vim.fn.getmousepos()
			vim.api.nvim_set_current_win(mousepos.winid)
			vim.api.nvim_win_set_cursor(0, { mousepos.line, 0 })
		end,
	},

	display = {
		line = function(bufnr)
			local function pad_line_num(num, max_lines)
				if #num ~= #max_lines then
					return string.rep(" ", #max_lines - #num) .. num
				else
					return num
				end
			end

			local lnum = tostring(vim.v.lnum)
			local relnum = tostring(vim.v.relnum)
			local max_lines = tostring(vim.fn.line("$"))
			local current_mode = vim.fn.mode()
			local cur_sign_nm = utils.get_name_from_group(bufnr, lnum, "gitsigns_vimfn_signs_")
			local text = pad_line_num(lnum, max_lines)

			cur_sign_nm = cur_sign_nm and cur_sign_nm or "NonText"
			if current_mode == "i" then
				text = pad_line_num(lnum, max_lines)
			else
				if relnum ~= "0" then
					text = pad_line_num(relnum, max_lines)
				end
			end

			return utils.make_hl_statuscolumn(cur_sign_nm, text)
		end,

		marks = function(bufnr)
			local lnum = vim.v.lnum
			local cur_sign_nm = utils.get_name_from_group(bufnr, lnum, "gitsigns_vimfn_signs_")
			cur_sign_nm = cur_sign_nm and cur_sign_nm or "NonText"
			for _, data in ipairs(vim.fn.getmarklist(bufnr)) do
				local mark = data.mark:sub(2, 3)
				local _, mark_line = unpack(data.pos)
				if vim.v.lnum == mark_line then
					return utils.make_hl_statuscolumn(cur_sign_nm, mark .. " ")
				end
			end
			return "  "
		end,

		fold = function()
			if vim.v.wrap then
				return ""
			end

			local lnum = vim.v.lnum
			local icon = " "

			-- Line isn't in folding range
			if vim.fn.foldlevel(lnum) <= 0 then
				return icon
			end

			-- Not the first line of folding range
			if vim.fn.foldlevel(lnum) <= vim.fn.foldlevel(lnum - 1) then
				return icon
			end

			if vim.fn.foldclosed(lnum) == -1 then
				icon = icons.fold_expanded
			else
				icon = icons.fold_collapsed
			end

			return icon
		end,

		gitsign = function(bufnr, lnum)
			local curr_lnum, column = unpack(vim.api.nvim_win_get_cursor(0))
			local cur_sign_nm = utils.get_name_from_group(bufnr, lnum, "gitsigns_vimfn_signs_")

			if cur_sign_nm ~= nil then
				return utils.make_hl_statuscolumn(hl_groups.gitsigns[cur_sign_nm], icons.gitsigns_bar)
			elseif lnum == curr_lnum then
				return utils.make_hl_statuscolumn("FocusedLine", icons.gitsigns_bar)
			else
				return utils.make_hl_statuscolumn("NonText", icons.gitsigns_bar)
			end
		end,

		diag = function(bufnum, lnum)
			local diagnostics = vim.diagnostic.get(bufnum, { lnum = lnum - 1 })
			if diagnostics[1] ~= nil then
				local severity = vim.diagnostic.severity[diagnostics[1].severity]
				local cur_sign_nm = "DiagnosticSign" .. utils.title_case(severity)
				return utils.make_hl_statuscolumn(cur_sign_nm, icons.diag_signs[cur_sign_nm])
			end
			return " "
		end,
	},

	sections = {
		sign_column = {
			[[%s]],
		},
		line_number = {
			[[%{%v:lua.StatusColumn.display.line(bufnr())%}]],
			-- [[%=%{v:lua.StatusColumn.display.line()}]]
		},
		folds = {
			[[%#FoldColumn#]], -- HL
			[[%@v:lua.StatusColumn.handler.fold@]],
			[[%{v:lua.StatusColumn.display.fold()}]],
		},
		gitsign = {
			[[%#StatusColumnGitSigns#]],
			[[%@v:lua.StatusColumn.handler.gitsign@]],
			[[%{%v:lua.StatusColumn.display.gitsign(bufnr(), v:lnum)%}]],
		},
		diag = {
			[[%@v:lua.StatusColumn.handler.diag@]],
			[[%{%v:lua.StatusColumn.display.diag(bufnr(), v:lnum)%}]],
		},
		border = {
			[[%#StatusColumnBorder#]], -- HL
			[[│]],
		},
		padding = {
			[[%#StatusColumnBuffer#]], -- HL
			[[ ]],
		},
		marks = {
			[[%{%v:lua.StatusColumn.display.marks(bufnr())%}]],
		},
	},

	build = function(tbl)
		local statuscolumn = {}

		for _, value in ipairs(tbl) do
			if type(value) == "string" then
				table.insert(statuscolumn, value)
			elseif type(value) == "table" then
				table.insert(statuscolumn, StatusColumn.build(value))
			end
		end

		return table.concat(statuscolumn)
	end,
}

local present, err = pcall(function()
	local stc = StatusColumn.build({
		StatusColumn.sections.folds,
		-- StatusColumn.sections.padding,
		StatusColumn.sections.diag,
		StatusColumn.sections.padding,
		StatusColumn.sections.marks,
		StatusColumn.sections.line_number,
		StatusColumn.sections.padding,
		StatusColumn.sections.gitsign,
		-- StatusColumn.sections.padding,
	})

	vim.opt.statuscolumn = stc
end)

if not present then
	print("statuscolumn error during setup", err)
end
