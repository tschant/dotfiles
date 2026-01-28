---Worktree + Tab integration
---@module utils.worktree-tabs
local M = {}

local tabs = require("utils.tabs")
local git_worktree = require("utils.git.worktree")

---Create a new tab with tcd to worktree
---@param worktree WorktreeInfo Worktree info
function M.create_tab_with_worktree(worktree)
	vim.cmd("tabnew")
	vim.cmd("tcd " .. vim.fn.fnameescape(worktree.path))

	-- Label tab with shortened path and branch
	local label = tabs.shorten_path(vim.fn.fnamemodify(worktree.path, ":~"))
	if worktree.branch then
		label = label .. " [" .. worktree.branch .. "]"
	end
	tabs.rename_tab(label)
end

---@class SwitchWorktreeOpts
---@field new_tab? boolean Always create new tab (default: false, reuses existing)

---Switch to worktree - finds existing tab or creates new one
---@param worktree WorktreeInfo Worktree info
---@param opts? SwitchWorktreeOpts Options
function M.switch_to_worktree(worktree, opts)
	opts = opts or {}

	if not opts.new_tab then
		-- Try to find existing tab with this worktree
		local existing_tab = tabs.find_tab_with_cwd(worktree.path)
		if existing_tab then
			vim.cmd("tabnext " .. existing_tab)
			return
		end
	end

	-- Create new tab
	M.create_tab_with_worktree(worktree)
end

---@class PickWorktreeOpts
---@field new_tab? boolean Open in new tab
---@field on_select? fun(worktree: WorktreeInfo) Callback after selection

---Show picker to select a worktree
---@param opts? PickWorktreeOpts Options
function M.pick_worktree(opts)
	opts = opts or {}
	local worktrees = git_worktree.get_all_worktrees()

	if #worktrees == 0 then
		vim.notify("No worktrees found", vim.log.levels.WARN)
		return
	end

	local items = {}
	for _, wt in ipairs(worktrees) do
		local display = wt.branch or ("detached:" .. wt.commit)
		if wt.is_main then
			display = display .. " (main)"
		end
		if git_worktree.worktree_has_changes(wt.path) then
			display = display .. " *"
		end

		table.insert(items, {
			text = display,
			file = wt.path,
			value = wt,
		})
	end

	Snacks.picker.pick({
		source = "worktrees",
		title = opts.new_tab and "Open Worktree in Tab" or "Switch to Worktree",
		items = items,
		format = function(item, ctx)
			local wt = item.value
			local ret = {}
			-- Branch/commit
			table.insert(ret, { wt.branch or ("@" .. wt.commit), "SnacksPickerLabel" })
			table.insert(ret, { " " })
			-- Path
			table.insert(ret, { tabs.shorten_path(wt.path), "SnacksPickerComment" })
			-- Indicators
			if wt.is_main then
				table.insert(ret, { " (main)", "SnacksPickerSpecial" })
			end
			if git_worktree.worktree_has_changes(wt.path) then
				table.insert(ret, { " *", "DiagnosticWarn" })
			end
			return ret
		end,
		actions = {
			confirm = function(picker, item)
				picker:close()
				if item and item.value then
					if opts.on_select then
						opts.on_select(item.value)
					else
						M.switch_to_worktree(item.value, { new_tab = opts.new_tab })
					end
				end
			end,
		},
	})
end

---Prompt for name, create worktree, and open in new tab
function M.create_worktree_with_tab()
	local git_root = git_worktree.get_git_root()
	if not git_root then
		vim.notify("Not in a git repository", vim.log.levels.ERROR)
		return
	end

	-- Get parent directory for worktrees (sibling to main repo)
	local parent_dir = vim.fn.fnamemodify(git_root, ":h")

	Snacks.input({
		prompt = "Branch name: ",
	}, function(input)
		if not input or input == "" then
			return
		end

		local branch = git_worktree.normalize_worktree_name(input)
		local worktree_path = parent_dir .. "/" .. vim.fn.fnamemodify(git_root, ":t") .. "-" .. branch

		-- Check if worktree already exists
		local existing = git_worktree.find_worktree_for_branch(branch)
		if existing then
			vim.notify("Worktree for branch '" .. branch .. "' already exists", vim.log.levels.WARN)
			M.switch_to_worktree(existing, { new_tab = true })
			return
		end

		-- Create worktree
		local ok, err = git_worktree.create_worktree(worktree_path, branch)
		if not ok then
			vim.notify("Failed to create worktree: " .. (err or "unknown error"), vim.log.levels.ERROR)
			return
		end

		vim.notify("Created worktree: " .. branch, vim.log.levels.INFO)

		-- Open in new tab
		local wt = { path = worktree_path, branch = branch }
		M.create_tab_with_worktree(wt)
	end)
end

---Close worktree tab with optional cleanup
function M.close_worktree_tab()
	if #vim.api.nvim_list_tabpages() <= 1 then
		vim.notify("Cannot close the last tab", vim.log.levels.WARN)
		return
	end

	local current_wt = git_worktree.get_current_worktree()
	if not current_wt or current_wt.is_main then
		-- Not in a worktree or in main - just close tab
		tabs.close_tab()
		return
	end

	local has_changes = git_worktree.worktree_has_changes(current_wt.path)
	local choice

	if has_changes then
		choice = vim.fn.confirm(
			"Worktree has uncommitted changes. Close tab?",
			"&Close tab only\n&Delete worktree (force)\n&Cancel",
			3
		)
	else
		choice = vim.fn.confirm(
			"Close worktree tab?",
			"&Close tab only\n&Delete worktree\n&Delete worktree + branch\n&Cancel",
			4
		)
	end

	if choice == 0 or (has_changes and choice == 3) or (not has_changes and choice == 4) then
		return -- Cancel
	end

	if choice == 1 then
		-- Just close tab
		vim.cmd("tabclose")
		return
	end

	local branch = current_wt.branch
	local path = current_wt.path

	-- Close tab first
	vim.cmd("tabclose")

	-- Delete worktree
	local force = has_changes
	local ok, err = git_worktree.remove_worktree(path, force)
	if not ok then
		vim.notify("Failed to remove worktree: " .. (err or "unknown error"), vim.log.levels.ERROR)
		return
	end

	vim.notify("Removed worktree: " .. path, vim.log.levels.INFO)

	-- Optionally delete branch
	if not has_changes and choice == 3 and branch then
		ok, err = git_worktree.delete_branch(branch, false)
		if ok then
			vim.notify("Deleted branch: " .. branch, vim.log.levels.INFO)
		else
			vim.notify("Failed to delete branch: " .. (err or "unknown error"), vim.log.levels.WARN)
		end
	end
end

---Show picker to delete a worktree
function M.delete_worktree()
	local worktrees = git_worktree.get_all_worktrees()

	-- Filter out main worktree
	local deletable = {}
	for _, wt in ipairs(worktrees) do
		if not wt.is_main then
			table.insert(deletable, wt)
		end
	end

	if #deletable == 0 then
		vim.notify("No worktrees to delete (main worktree cannot be deleted)", vim.log.levels.WARN)
		return
	end

	M.pick_worktree({
		on_select = function(wt)
			local has_changes = git_worktree.worktree_has_changes(wt.path)
			local choice

			if has_changes then
				choice = vim.fn.confirm(
					"Worktree '" .. (wt.branch or wt.path) .. "' has uncommitted changes!",
					"&Force delete worktree\n&Cancel",
					2
				)
				if choice ~= 1 then
					return
				end
			else
				choice = vim.fn.confirm(
					"Delete worktree '" .. (wt.branch or wt.path) .. "'?",
					"&Delete worktree\n&Delete worktree + branch\n&Cancel",
					3
				)
				if choice == 0 or choice == 3 then
					return
				end
			end

			-- Close any tab with this worktree
			local tab_nr = tabs.find_tab_with_cwd(wt.path)
			if tab_nr then
				vim.cmd("tabclose " .. tab_nr)
			end

			local ok, err = git_worktree.remove_worktree(wt.path, has_changes)
			if not ok then
				vim.notify("Failed to remove worktree: " .. (err or "unknown error"), vim.log.levels.ERROR)
				return
			end

			vim.notify("Removed worktree: " .. wt.path, vim.log.levels.INFO)

			-- Optionally delete branch
			if not has_changes and choice == 2 and wt.branch then
				ok, err = git_worktree.delete_branch(wt.branch, false)
				if ok then
					vim.notify("Deleted branch: " .. wt.branch, vim.log.levels.INFO)
				else
					vim.notify("Failed to delete branch: " .. (err or "unknown error"), vim.log.levels.WARN)
				end
			end
		end,
	})
end

return M
