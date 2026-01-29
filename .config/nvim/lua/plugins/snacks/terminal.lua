-- Per-tab terminal management using Snacks.terminal
-- General terminal and lazygit are per-tab, btop is global

local M = {}

local State = {
	terminals = {}, -- table<tab_id, {instance: Snacks.win, bufnr: number}>
	lazygits = {}, -- table<tab_id, {instance: Snacks.win, bufnr: number}>
	btop = nil, -- {instance: Snacks.win, bufnr: number}
	layouts = {}, -- table<tab_id, "float"|"bottom">
}

--- Check if a terminal entry is valid
---@param tab_term table|nil {instance: Snacks.win, bufnr: number}
---@return boolean
local function is_valid(tab_term)
	if not tab_term or not tab_term.instance then
		return false
	end
	if not tab_term.bufnr or not vim.api.nvim_buf_is_valid(tab_term.bufnr) then
		return false
	end
	return true
end

--- Build terminal options
---@param position string "float" or "bottom"
---@param tab_id number
---@return table
local function build_opts(position, tab_id)
	local win_opts = {
		position = position,
	}

	if position == "bottom" then
		win_opts.height = 0.3
	end

	return {
		count = tab_id, -- Makes terminal unique per tab
		cwd = vim.fn.getcwd(),
		start_insert = true,
		auto_insert = true,
		win = win_opts,
	}
end

--- Open a new terminal
---@param cmd string|nil
---@param opts table
---@return table|nil {instance: Snacks.win, bufnr: number}
local function open_terminal(cmd, opts)
	local Snacks = require("snacks")
	local ok, terminal = pcall(Snacks.terminal.open, cmd, opts)

	if ok and terminal then
		return {
			instance = terminal,
			bufnr = terminal.buf,
		}
	end

	return nil
end

--- Toggle a per-tab terminal
---@param state_table table State.terminals or State.lazygits
---@param cmd string|nil Command to run
---@param position string "float" or "bottom"
function M.toggle_per_tab(state_table, cmd, position)
	local tab_id = vim.api.nvim_get_current_tabpage()
	local tab_term = state_table[tab_id]

	if is_valid(tab_term) then
		tab_term.instance:toggle()
	else
		local opts = build_opts(position, tab_id)
		local terminal = open_terminal(cmd, opts)
		if terminal then
			state_table[tab_id] = terminal
		end
	end
end

--- Toggle layout between float and bottom for per-tab terminal
function M.toggle_layout()
	local tab_id = vim.api.nvim_get_current_tabpage()
	local tab_term = State.terminals[tab_id]

	if not is_valid(tab_term) then
		return
	end

	-- Toggle layout preference
	local current = State.layouts[tab_id] or "bottom"
	local new_pos = current == "float" and "bottom" or "float"
	State.layouts[tab_id] = new_pos

	-- Close current terminal window (keeps buffer)
	tab_term.instance:hide()

	-- Reopen with new position
	local opts = build_opts(new_pos, tab_id)
	local Snacks = require("snacks")
	local ok, terminal = pcall(Snacks.terminal.open, nil, opts)

	if ok and terminal then
		State.terminals[tab_id] = {
			instance = terminal,
			bufnr = terminal.buf,
		}
	end
end

--- Toggle global btop terminal
---@param cmd string
---@param position string
function M.toggle_global(cmd, position)
	if is_valid(State.btop) then
		State.btop.instance:toggle()
	else
		local opts = build_opts(position, 9999) -- Use fixed count for global
		local terminal = open_terminal(cmd, opts)
		if terminal then
			State.btop = terminal
		end
	end
end

--- Clean up terminals for a specific tab
---@param tab_id number
local function cleanup_tab(tab_id)
	local term = State.terminals[tab_id]
	if term and term.bufnr and vim.api.nvim_buf_is_valid(term.bufnr) then
		pcall(function()
			vim.api.nvim_buf_delete(term.bufnr, { force = true })
		end)
	end
	State.terminals[tab_id] = nil
	State.layouts[tab_id] = nil

	local lg = State.lazygits[tab_id]
	if lg and lg.bufnr and vim.api.nvim_buf_is_valid(lg.bufnr) then
		pcall(function()
			vim.api.nvim_buf_delete(lg.bufnr, { force = true })
		end)
	end
	State.lazygits[tab_id] = nil
end

--- Set up autocmd for tab cleanup
local function setup_autocmds()
	vim.api.nvim_create_autocmd("TabClosed", {
		group = vim.api.nvim_create_augroup("TerminalTabCleanup", { clear = true }),
		callback = function(args)
			local closed_tab = tonumber(args.file)
			if closed_tab then
				cleanup_tab(closed_tab)
			end
		end,
	})
end

-- Expose State for keybindings
M.State = State

-- Snacks terminal config options
M.opts = {
	enabled = true,
}

-- Setup autocmds when module loads
setup_autocmds()

return M
