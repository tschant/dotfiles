-- Multi-session terminal provider for claudecode.nvim
-- Adapted from alex35mil's config
-- Enables independent Claude sessions per tab with proper broadcasting and side/float layouts switching

local Provider = {
	config = nil,
	initialized = false,
}

---@alias SessionMode "continue" | "resume" | nil

---@alias LayoutMode "side" | "float"

---@class LayoutOpts
---@field default LayoutMode?
---@field side table?
---@field float table?

local State = {
	terminals = {}, ---@type table<number, {instance: snacks.win, bufnr: number, client_id: string | nil}>
	clients = {}, ---@type table<number, string>
	ghosts = {}, ---@type table<string>
	layouts = {}, ---@type table<number, LayoutMode>
	connecting = nil, ---@type number | nil
	layout_switching = false,
	on_connect_patched = false,
	on_disconnect_patched = false,
	broadcast_patched = false,
}

local Terminal = {}
local Layout = {}
local CCInternal = {}

---
--- Public API
---

function Provider.init(opts)
	if Provider.initialized then
		return Provider
	end
	opts = opts or {}
	Provider.layout = vim.tbl_deep_extend("force", { default = "side" }, opts.layout or {})
	Provider.on_hide = opts.on_hide
	Provider.on_exit = opts.on_exit
	Provider.on_layout_switch = opts.on_layout_switch
	Provider.initialized = true
	return Provider
end

function Provider.focus()
	local tab_id = vim.api.nvim_get_current_tabpage()
	local tab_term = State.terminals[tab_id]
	if tab_term then
		Terminal.focus(tab_term)
	end
end

---@return boolean
function Provider.is_connected(tab_id)
	local client = State.clients[tab_id]
	return client ~= nil
end

---@return boolean
function Provider.is_active()
	local tab_id = vim.api.nvim_get_current_tabpage()
	local tab_term = Terminal.get_instance(tab_id)
	if tab_term then
		local win = tab_term.win
		return win ~= nil and vim.api.nvim_win_is_valid(win)
	end
	return false
end

---
--- CC Interface
---

function Provider.setup(config)
	Provider.config = config
	State.register_autocmds()
end

function Provider.open(cmd, env, config, focus)
	State.patch_on_connect()
	State.patch_on_disconnect()
	State.patch_broadcast()

	local tab_id = vim.api.nvim_get_current_tabpage()
	local tab_term = State.terminals[tab_id]
	local tab_client = State.clients[tab_id]

	if tab_term and Terminal.is_valid(tab_term) then
		tab_term.instance:show()
		if focus ~= false then
			Terminal.focus(tab_term)
		end
		return
	end

	-- Clear any stale client state and mark as connecting for this tab
	State.clients[tab_id] = nil
	State.connecting = tab_id

	local terminal = Terminal.new(cmd, env, config, focus)

	if not terminal then
		return
	end

	State.terminals[tab_id] = {
		instance = terminal,
		bufnr = terminal.buf,
		client_id = nil,
	}
end

function Provider.close()
	local tab_id = vim.api.nvim_get_current_tabpage()
	local tab_term = State.terminals[tab_id]

	if tab_term then
		if tab_term.instance then
			pcall(function()
				tab_term.instance:close()
			end)
		end
		State.clients[tab_id] = nil
		State.terminals[tab_id] = nil
	end
end

function Provider.simple_toggle(cmd, env, config)
	local tab_id = vim.api.nvim_get_current_tabpage()

	local tab_term = State.terminals[tab_id]

	if tab_term and Terminal.is_valid(tab_term) then
		tab_term.instance:toggle()
	else
		Provider.open(cmd, env, config, true)
	end
end

function Provider.focus_toggle(cmd, env, config)
	local tab_id = vim.api.nvim_get_current_tabpage()
	local tab_term = State.terminals[tab_id]

	if not tab_term or not Terminal.is_valid(tab_term) then
		Provider.open(cmd, env, config, true)
		return
	end

	local term_win = tab_term.instance.win
	local current_win = vim.api.nvim_get_current_win()

	if term_win and vim.api.nvim_win_is_valid(term_win) then
		if current_win == term_win then
			tab_term.instance:hide()
		else
			vim.api.nvim_set_current_win(term_win)
			vim.cmd("startinsert")
		end
	else
		tab_term.instance:show()
		Terminal.focus(tab_term)
	end
end

function Provider.get_active_bufnr()
	local tab_id = vim.api.nvim_get_current_tabpage()
	local tab_term = State.terminals[tab_id]

	if tab_term and tab_term.bufnr and vim.api.nvim_buf_is_valid(tab_term.bufnr) then
		return tab_term.bufnr
	end

	return nil
end

function Provider.is_available()
	local ok, snacks = pcall(require, "snacks")
	return ok and snacks.terminal ~= nil
end

---
--- Layout
---

---@return LayoutMode
function Layout.current()
	local tab_id = vim.api.nvim_get_current_tabpage()
	return State.layouts[tab_id] or Provider.layout.default
end

---@param mode LayoutMode
function Layout.set(mode)
	local tab_id = vim.api.nvim_get_current_tabpage()
	State.layouts[tab_id] = mode
end

---@param mode SessionMode
function Provider.open_on_side(mode)
	Layout.set("side")
	vim.cmd(Provider.cmd(mode))
end

---@param mode SessionMode
function Provider.open_float(mode)
	Layout.set("float")
	vim.cmd(Provider.cmd(mode))
end

---@param mode SessionMode
---@return string
function Provider.cmd(mode)
	if mode == "continue" then
		return "ClaudeCode --continue"
	elseif mode == "resume" then
		return "ClaudeCode --resume"
	end
	return "ClaudeCode"
end

function Provider.toggle_layout()
	local tab_id = vim.api.nvim_get_current_tabpage()
	local tab_term = State.terminals[tab_id]

	if not tab_term or not Terminal.is_valid(tab_term) then
		return
	end

	local current_mode = Layout.current()
	local new_mode = current_mode == "side" and "float" or "side"
	local instance = tab_term.instance
	local new_opts = Terminal.build_layout_opts(new_mode)

	instance.opts = vim.tbl_deep_extend("force", instance.opts, new_opts)

	State.layout_switching = true
	instance:hide()
	State.layout_switching = false
	instance:show()

	Layout.set(new_mode)

	local new_win = instance.win
	if new_win and vim.api.nvim_win_is_valid(new_win) then
		-- Signal terminal to reflow content for new window size
		local bufnr = tab_term.bufnr
		local chan = vim.bo[bufnr].channel
		if chan and chan > 0 then
			local win_width = vim.api.nvim_win_get_width(new_win)
			local win_height = vim.api.nvim_win_get_height(new_win)
			pcall(vim.fn.jobresize, chan, win_width, win_height)
		end
	end

	vim.defer_fn(function()
		Terminal.focus(tab_term)
		if Provider.on_layout_switch then
			Provider.on_layout_switch(tab_id, new_mode)
		end
	end, 100)
end

---
--- Patches
---

function State.patch_on_connect()
	if State.on_connect_patched then
		return
	end

	local tcp_server = CCInternal.get_tcp_server()

	if not tcp_server then
		return
	end

	local original_on_connect = tcp_server.on_connect

	tcp_server.on_connect = function(client)
		original_on_connect(client)

		vim.schedule(function()
			local root_set = {}
			for _, id in ipairs(CCInternal.get_root_client_ids()) do
				root_set[id] = true
			end

			local tcp_set = {}
			for _, id in ipairs(CCInternal.get_tcp_client_ids()) do
				tcp_set[id] = true
			end

			-- On CC session termination, an unidentified connection appears in root layer
			-- but not in TCP layer. Ignore it since it's not a real CC terminal connection.
			if root_set[client.id] and not tcp_set[client.id] then
				table.insert(State.ghosts, client.id)
				return
			end

			local tab_id = State.connecting

			if not tab_id then
				-- NOTE: It's not user initiated connection.
				return
			end

			if State.terminals[tab_id] then
				local tab_client_id = State.clients[tab_id]

				if not tab_client_id then
					State.clients[tab_id] = client.id
					State.connecting = nil
				end
			end
		end)
	end

	State.on_connect_patched = true
end

function State.patch_on_disconnect()
	if State.on_disconnect_patched then
		return
	end

	local tcp_server = CCInternal.get_tcp_server()

	if not tcp_server then
		return
	end

	local original_on_disconnect = tcp_server.on_disconnect

	tcp_server.on_disconnect = function(client, code, reason)
		original_on_disconnect(client, code, reason)

		for _, ghost_id in ipairs(State.ghosts) do
			if client.id == ghost_id then
				return
			end
		end

		-- Find which tab owns this client (don't assume current_tab)
		for tid, cid in pairs(State.clients) do
			if cid == client.id then
				State.clients[tid] = nil
				-- terminal will be cleaned up in its on_close hook
				break
			end
		end
	end

	State.on_disconnect_patched = true
end

function State.patch_broadcast()
	if State.broadcast_patched then
		return
	end

	local server = CCInternal.get_root_server()
	if not server or not server.broadcast then
		return
	end

	server.broadcast = function(event, data)
		local current_tab = vim.api.nvim_get_current_tabpage()
		local client_id = State.clients[current_tab]

		if client_id then
			if server.state and server.state.clients then
				local client = server.state.clients[client_id]
				if client then
					return server.send(client, event, data)
				else
					return false
				end
			else
				return false
			end
		else
			-- we're on the tab without an active client
			return false
		end
	end

	State.broadcast_patched = true
end

---
--- CC Internal
---

function CCInternal.get_root_server()
	local ok, claudecode = pcall(require, "claudecode")
	if ok and claudecode.state and claudecode.state.server then
		return claudecode.state.server
	end
	return nil
end

function CCInternal.get_tcp_server()
	local ok, claudecode = pcall(require, "claudecode")
	if
		ok
		and claudecode.state
		and claudecode.state.server
		and claudecode.state.server.state
		and claudecode.state.server.state.server
	then
		return claudecode.state.server.state.server
	end
	return nil
end

---@return string[]
function CCInternal.get_root_client_ids()
	local server = CCInternal.get_root_server()
	if server and server.state and server.state.clients then
		return vim.tbl_keys(server.state.clients)
	end
	return {}
end

---@return string[]
function CCInternal.get_tcp_client_ids()
	local server = CCInternal.get_tcp_server()
	if server and server.clients then
		return vim.tbl_keys(server.clients)
	end
	return {}
end

---
--- Terminal
---

function Terminal.new(cmd, env, config, focus)
	local tab_id = vim.api.nvim_get_current_tabpage()
	local opts = Terminal.build_opts(config, env, focus, tab_id)

	local Snacks = require("snacks")
	local ok, terminal = pcall(Snacks.terminal.open, cmd .. " --ide", opts)

	if ok and terminal then
		return terminal
	end

	return nil
end

function Terminal.build_opts(config, env, focus, tab_id)
	local mode = State.layouts[tab_id] or Provider.layout.default
	local layout_opts = Terminal.build_layout_opts(mode)
	local should_focus = focus ~= false

	-- Capture user's on_close if provided via layout config
	local user_on_close = layout_opts.on_close

	local win_opts = vim.tbl_deep_extend("force", layout_opts, {
		on_close = function(terminal)
			if State.layout_switching then
				return
			end

			local tab_client_id = State.clients[tab_id]

			if tab_client_id then
				-- Client is still connected. Terminal is just being hidden.
				if Provider.on_hide then
					Provider.on_hide(tab_id)
				end
			else
				-- Client is disconnected. Removing terminal from state.
				State.terminals[tab_id] = nil
				State.layouts[tab_id] = nil

				if Provider.on_exit then
					Provider.on_exit(tab_id)
				end
			end

			if user_on_close then
				user_on_close(terminal)
			end
		end,
	})

	local opts = {
		count = tab_id,
		cwd = config and config.cwd or vim.fn.getcwd(),
		start_insert = should_focus,
		auto_insert = should_focus,
		auto_close = true,
		win = win_opts,
	}

	if env and next(env) then
		opts.env = env
	end

	return opts
end

---@param mode LayoutMode
---@return table
function Terminal.build_layout_opts(mode)
	local defaults = {
		side = {
			position = "right",
			width = 0.3,
			wo = {
				winfixwidth = true,
			},
		},
		float = {
			position = "float",
			width = 0.6,
			height = 0.8,
			backdrop = false,
			border = "rounded",
		},
	}

	return vim.tbl_deep_extend("force", defaults[mode] or {}, Provider.layout.common or {}, Provider.layout[mode] or {})
end

function Terminal.get_instance(tab_id)
	local terminal = State.terminals[tab_id]

	if terminal then
		return terminal.instance
	end

	return nil
end

function Terminal.is_valid(tab_term)
	if not tab_term or not tab_term.instance then
		return false
	end
	if not tab_term.bufnr or not vim.api.nvim_buf_is_valid(tab_term.bufnr) then
		return false
	end
	return true
end

function Terminal.focus(tab_term)
	local win = tab_term.instance.win
	if win and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_set_current_win(win)
		vim.cmd("startinsert")
	end
end

---
--- Autocmds
---

function State.register_autocmds()
	vim.api.nvim_create_autocmd("TabClosed", {
		group = vim.api.nvim_create_augroup("ClaudeCodeProvider", { clear = true }),
		callback = State.cleanup,
		desc = "Cleanup Claude terminals on tab close",
	})
end

function State.cleanup()
	local active_tabs = vim.api.nvim_list_tabpages()
	local active_set = {}
	for _, tab in ipairs(active_tabs) do
		active_set[tab] = true
	end

	for tab_id, tab_term in pairs(State.terminals) do
		if not active_set[tab_id] then
			if tab_term.instance then
				pcall(function()
					tab_term.instance:close()
				end)
			end
			State.clients[tab_id] = nil
			State.terminals[tab_id] = nil
		end
	end
end

return Provider
