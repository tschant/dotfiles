if _G.StatusColumn then
  return
end

local icons = require('utils.icons')
local hl_groups = require('utils.hl_groups')
local utils = require('utils.extra')
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
    end
  },

  display = {
    line = function()
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

      if vim.v.wrap then
        return " " .. string.rep(" ", #lnum)
      end

			if current_mode == "i" then
				return pad_line_num(lnum, max_lines)	
			else
				if relnum == "0" then
					return pad_line_num(lnum, max_lines)
				else
					return pad_line_num(relnum, max_lines)
				end
			end
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
			local cur_sign_nm = utils.get_name_from_group(bufnr, lnum, "gitsigns_vimfn_signs_")

			if cur_sign_nm ~= nil then
				return utils.make_hl_statuscolum(hl_groups.gitsigns[cur_sign_nm], icons.gitsigns_bar)
			else
				return icons.gitsigns_bar
			end
		end,

		diag = function(bufnum, lnum)
			local cur_sign_nm = utils.get_name_from_group(bufnum, lnum, "*")

			if cur_sign_nm ~= nil and vim.startswith(cur_sign_nm, "DiagnosticSign") then
				-- return mk_hl(cur_sign_nm, diag_signs_icons[cur_sign_nm])
				return utils.make_hl_statuscolum(cur_sign_nm, icons.diag_signs[cur_sign_nm])
			else
				return " "
			end
		end
  },

  sections = {
    sign_column = {
      [[%s]]
    },
    line_number = {
      [[%{%v:lua.StatusColumn.display.line()%}]]
      -- [[%=%{v:lua.StatusColumn.display.line()}]]
    },
    folds       = {
      [[%#FoldColumn#]], -- HL
      [[%@v:lua.StatusColumn.handler.fold@]],
      [[%{v:lua.StatusColumn.display.fold()}]]
    },
		gitsign   = {
			[[%#StatusColumnGitSigns#]],
			[[%{%v:lua.StatusColumn.display.gitsign(bufnr(), v:lnum)%}]]
		},
		diag   = {
			[[%{%v:lua.StatusColumn.display.diag(bufnr(), v:lnum)%}]]
		},
    border      = {
      [[%#StatusColumnBorder#]], -- HL
      [[│]],
    },
    padding     = {
      [[%#StatusColumnBuffer#]], -- HL
      [[ ]],
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

  set_window = function(value)
    vim.defer_fn(function()
      vim.api.nvim_win_set_option(vim.api.nvim_get_current_win(), "statuscolumn", value)
    end, 1)
  end
}


local present, err = pcall(function ()
	vim.opt.statuscolumn = StatusColumn.build({
		StatusColumn.sections.folds,
		StatusColumn.sections.diag,
		StatusColumn.sections.padding,
		StatusColumn.sections.line_number,
		StatusColumn.sections.padding,
		StatusColumn.sections.gitsign,
		-- StatusColumn.sections.padding,
	})
end)

if not present then
	print("statuscolumn error during setup", err)
end
