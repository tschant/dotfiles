---Patch workflow for worktrees
---@module utils.worktree-patch
local M = {}

local tabs = require("utils.tabs")
local git_worktree = require("utils.git.worktree")

-- Directory to store patches
local PATCH_DIR = vim.fn.stdpath("data") .. "/patches"

---Ensure patch directory exists
local function ensure_patch_dir()
	if vim.fn.isdirectory(PATCH_DIR) ~= 1 then
		vim.fn.mkdir(PATCH_DIR, "p")
	end
end

---Generate patch filename
---@param branch string|nil Branch name
---@return string filename
local function generate_patch_filename(branch)
	local name = branch or "detached"
	local timestamp = os.date("%Y%m%d-%H%M%S")
	return string.format("%s-%s.patch", name, timestamp)
end

---Create patch from uncommitted changes in current or specified worktree
---Includes both tracked and untracked files
---@param worktree_path? string Path to worktree (defaults to cwd)
---@return string|nil patch_path Path to created patch, nil on failure
function M.create_patch_from_worktree(worktree_path)
	worktree_path = worktree_path or vim.fn.getcwd()

	-- Check for changes
	if not git_worktree.worktree_has_changes(worktree_path) then
		vim.notify("No uncommitted changes to create patch from", vim.log.levels.WARN)
		return nil
	end

	ensure_patch_dir()

	-- Get branch name for filename
	local branch = vim.fn.system("git -C " .. vim.fn.shellescape(worktree_path) .. " branch --show-current 2>/dev/null")
	branch = vim.trim(branch)
	if branch == "" then
		branch = nil
	end

	local filename = generate_patch_filename(branch)
	local patch_path = PATCH_DIR .. "/" .. filename
	local esc_path = vim.fn.shellescape(worktree_path)

	-- Mark untracked files with intent-to-add so they appear in diff
	vim.fn.system(string.format("git -C %s add --intent-to-add . 2>/dev/null", esc_path))

	-- Create patch (include staged, unstaged, and newly tracked via intent-to-add)
	local cmd = string.format("git -C %s diff HEAD > %s 2>&1", esc_path, vim.fn.shellescape(patch_path))
	vim.fn.system(cmd)

	-- Reset only the intent-to-add files (untracked files) to restore original state
	vim.fn.system(
		string.format(
			"git -C %s ls-files --others --exclude-standard -z | xargs -0 git -C %s reset HEAD -- 2>/dev/null",
			esc_path,
			esc_path
		)
	)

	-- Verify patch was created and has content
	local stat = vim.loop.fs_stat(patch_path)
	if not stat or stat.size == 0 then
		vim.fn.delete(patch_path)
		vim.notify("Failed to create patch or patch is empty", vim.log.levels.ERROR)
		return nil
	end

	vim.notify("Created patch: " .. filename, vim.log.levels.INFO)
	return patch_path
end

---Apply patch to specified worktree
---@param patch_path string Path to patch file
---@param worktree_path? string Path to worktree (defaults to cwd)
---@return boolean success
---@return string? error
function M.apply_patch_to_worktree(patch_path, worktree_path)
	worktree_path = worktree_path or vim.fn.getcwd()

	-- Check if patch exists
	if vim.fn.filereadable(patch_path) ~= 1 then
		return false, "Patch file not found: " .. patch_path
	end

	-- Check if patch can be applied (dry run)
	local check_cmd = string.format(
		"git -C %s apply --check %s 2>&1",
		vim.fn.shellescape(worktree_path),
		vim.fn.shellescape(patch_path)
	)

	local check_result = vim.fn.system(check_cmd)
	if vim.v.shell_error ~= 0 then
		return false, "Patch cannot be applied cleanly: " .. vim.trim(check_result)
	end

	-- Apply the patch
	local apply_cmd =
		string.format("git -C %s apply %s 2>&1", vim.fn.shellescape(worktree_path), vim.fn.shellescape(patch_path))

	local result = vim.fn.system(apply_cmd)
	if vim.v.shell_error ~= 0 then
		return false, "Failed to apply patch: " .. vim.trim(result)
	end

	return true, nil
end

---Revert applied patch (discard all uncommitted changes)
---@param worktree_path? string Path to worktree (defaults to cwd)
---@return boolean success
function M.revert_patch(worktree_path)
	worktree_path = worktree_path or vim.fn.getcwd()

	if not git_worktree.worktree_has_changes(worktree_path) then
		vim.notify("No changes to revert", vim.log.levels.INFO)
		return true
	end

	local choice = vim.fn.confirm("Revert all uncommitted changes?", "&Yes\n&No", 2)

	if choice ~= 1 then
		return false
	end

	local cmd = string.format("git -C %s checkout . 2>&1", vim.fn.shellescape(worktree_path))

	local result = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to revert changes: " .. vim.trim(result), vim.log.levels.ERROR)
		return false
	end

	-- Also clean untracked files
	cmd = string.format("git -C %s clean -fd 2>&1", vim.fn.shellescape(worktree_path))
	vim.fn.system(cmd)

	vim.notify("Reverted all changes", vim.log.levels.INFO)
	return true
end

---Get list of available patches
---@return {path: string, name: string, mtime: number}[]
local function get_available_patches()
	ensure_patch_dir()

	local patches = {}
	local handle = vim.loop.fs_scandir(PATCH_DIR)
	if not handle then
		return patches
	end

	while true do
		local name, type = vim.loop.fs_scandir_next(handle)
		if not name then
			break
		end
		if type == "file" and name:match("%.patch$") then
			local path = PATCH_DIR .. "/" .. name
			local stat = vim.loop.fs_stat(path)
			table.insert(patches, {
				path = path,
				name = name,
				mtime = stat and stat.mtime.sec or 0,
			})
		end
	end

	-- Sort by modification time (newest first)
	table.sort(patches, function(a, b)
		return a.mtime > b.mtime
	end)

	return patches
end

---UI: Create patch from current changes
function M.create_patch()
	local patch_path = M.create_patch_from_worktree()
	if patch_path then
		-- Copy to clipboard
		vim.fn.setreg("+", patch_path)
		vim.notify("Patch path copied to clipboard", vim.log.levels.INFO)
	end
end

---UI: Pick source worktree, create patch from it, apply to current worktree
function M.apply_patch()
	local worktrees = git_worktree.get_all_worktrees()
	local current_cwd = vim.fn.getcwd()

	-- Filter to worktrees with changes (excluding current)
	local sources = {}
	for _, wt in ipairs(worktrees) do
		local is_current = current_cwd:find(wt.path, 1, true) == 1
		if not is_current and git_worktree.worktree_has_changes(wt.path) then
			table.insert(sources, wt)
		end
	end

	if #sources == 0 then
		vim.notify("No other worktrees with uncommitted changes", vim.log.levels.WARN)
		return
	end

	local items = {}
	for _, wt in ipairs(sources) do
		local display = wt.branch or ("detached:" .. wt.commit)
		table.insert(items, {
			text = display,
			file = wt.path,
			value = wt,
		})
	end

	Snacks.picker.pick({
		source = "worktrees",
		title = "Apply changes from worktree",
		items = items,
		format = function(item, ctx)
			local wt = item.value
			local ret = {}
			table.insert(ret, { wt.branch or ("@" .. wt.commit), "SnacksPickerLabel" })
			table.insert(ret, { " " })
			table.insert(ret, { tabs.shorten_path(wt.path), "SnacksPickerComment" })
			return ret
		end,
		actions = {
			confirm = function(picker, item)
				picker:close()
				if item and item.value then
					local source_wt = item.value
					-- Create patch from source worktree
					local patch_path = M.create_patch_from_worktree(source_wt.path)
					if not patch_path then
						return
					end
					-- Apply to current worktree
					local ok, err = M.apply_patch_to_worktree(patch_path, current_cwd)
					if ok then
						vim.notify("Applied changes from " .. (source_wt.branch or source_wt.path), vim.log.levels.INFO)
					else
						vim.notify(err or "Failed to apply patch", vim.log.levels.ERROR)
					end
				end
			end,
		},
	})
end

return M
