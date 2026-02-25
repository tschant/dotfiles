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

---Create patch series from committed changes using git format-patch
---@param worktree_path string Source worktree
---@param base_branch? string Base branch to compare (default: main/master)
---@return string|nil patch_dir Directory with .patch files, nil on failure
function M.create_commit_patch_from_worktree(worktree_path, base_branch)
	worktree_path = worktree_path or vim.fn.getcwd()

	-- Get worktree's current branch or commit
	local branch_cmd = string.format(
		"git -C %s rev-parse --abbrev-ref HEAD 2>/dev/null",
		vim.fn.shellescape(worktree_path)
	)
	local worktree_branch = vim.trim(vim.fn.system(branch_cmd))

	-- Handle detached HEAD
	if worktree_branch == "HEAD" or vim.v.shell_error ~= 0 then
		local commit_cmd = string.format(
			"git -C %s rev-parse HEAD 2>/dev/null",
			vim.fn.shellescape(worktree_path)
		)
		worktree_branch = vim.trim(vim.fn.system(commit_cmd))
		if vim.v.shell_error ~= 0 then
			vim.notify("Failed to get worktree branch/commit", vim.log.levels.ERROR)
			return nil
		end
	end

	-- Determine base branch if not provided
	if not base_branch then
		local main_exists = vim.fn.system(
			string.format("git -C %s show-ref --verify --quiet refs/heads/main", vim.fn.shellescape(worktree_path))
		)
		if vim.v.shell_error == 0 then
			base_branch = "main"
		else
			local master_exists = vim.fn.system(
				string.format("git -C %s show-ref --verify --quiet refs/heads/master", vim.fn.shellescape(worktree_path))
			)
			if vim.v.shell_error == 0 then
				base_branch = "master"
			else
				vim.notify("Could not determine base branch (main/master not found)", vim.log.levels.ERROR)
				return nil
			end
		end
	end

	-- Get merge-base
	local merge_base_cmd = string.format(
		"git -C %s merge-base %s %s 2>/dev/null",
		vim.fn.shellescape(worktree_path),
		vim.fn.shellescape(worktree_branch),
		vim.fn.shellescape(base_branch)
	)
	local merge_base = vim.trim(vim.fn.system(merge_base_cmd))
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to find common ancestor (branches may be orphans)", vim.log.levels.ERROR)
		return nil
	end

	-- Check if there are commits to export
	local diff = git_worktree.get_commit_difference(worktree_branch, base_branch, worktree_path)
	if not diff or diff.ahead == 0 then
		vim.notify("No commits to create patches from", vim.log.levels.WARN)
		return nil
	end

	ensure_patch_dir()

	-- Create directory for patch series
	local dir_name = string.format("%s-%s", worktree_branch:gsub("/", "-"), os.date("%Y%m%d-%H%M%S"))
	local patch_dir = PATCH_DIR .. "/" .. dir_name
	vim.fn.mkdir(patch_dir, "p")

	-- Create patches using git format-patch
	local cmd = string.format(
		"git -C %s format-patch %s..HEAD -o %s 2>&1",
		vim.fn.shellescape(worktree_path),
		vim.fn.shellescape(merge_base),
		vim.fn.shellescape(patch_dir)
	)

	local result = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to create patches: " .. vim.trim(result), vim.log.levels.ERROR)
		return nil
	end

	-- Verify patches were created
	local patches = vim.fn.glob(patch_dir .. "/*.patch", false, true)
	if #patches == 0 then
		vim.fn.delete(patch_dir, "rf")
		vim.notify("No patch files were created", vim.log.levels.ERROR)
		return nil
	end

	vim.notify(string.format("Created %d patch(es) in: %s", #patches, dir_name), vim.log.levels.INFO)
	return patch_dir
end

---Apply commit patches to worktree using git am
---@param patch_dir string Directory containing .patch files
---@param worktree_path? string Target worktree (default: cwd)
---@return boolean success
---@return string? error
function M.apply_commit_patch_to_worktree(patch_dir, worktree_path)
	worktree_path = worktree_path or vim.fn.getcwd()

	-- Check if patch directory exists
	if vim.fn.isdirectory(patch_dir) ~= 1 then
		return false, "Patch directory not found: " .. patch_dir
	end

	-- Pre-flight check: ensure clean working directory
	if git_worktree.worktree_has_changes(worktree_path) then
		return false, "Target worktree has uncommitted changes. Commit or stash first."
	end

	-- Get patch files sorted by name (format-patch numbers them)
	local patches = vim.fn.glob(patch_dir .. "/*.patch", false, true)
	if #patches == 0 then
		return false, "No patch files found in directory"
	end

	table.sort(patches)

	-- Apply patches using git am
	local cmd = string.format(
		"git -C %s am %s 2>&1",
		vim.fn.shellescape(worktree_path),
		table.concat(vim.tbl_map(vim.fn.shellescape, patches), " ")
	)

	local result = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		-- Check if it's a conflict
		if result:match("Applying:") then
			return false, string.format(
				"Conflict while applying patches:\n%s\n\nResolve manually or run: git -C %s am --abort",
				vim.trim(result),
				worktree_path
			)
		end
		return false, "Failed to apply patches: " .. vim.trim(result)
	end

	return true, nil
end

---Rollback applied commit patches
---@param commit_count number Number of commits to rollback
---@param worktree_path? string Target worktree (default: cwd)
---@return boolean success
function M.revert_commit_patch(commit_count, worktree_path)
	worktree_path = worktree_path or vim.fn.getcwd()

	if commit_count <= 0 then
		vim.notify("Invalid commit count", vim.log.levels.ERROR)
		return false
	end

	local choice = vim.fn.confirm(
		string.format("Reset and remove last %d commit(s)?", commit_count),
		"&Yes\n&No",
		2
	)

	if choice ~= 1 then
		return false
	end

	local cmd = string.format(
		"git -C %s reset --hard HEAD~%d 2>&1",
		vim.fn.shellescape(worktree_path),
		commit_count
	)

	local result = vim.fn.system(cmd)
	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to revert commits: " .. vim.trim(result), vim.log.levels.ERROR)
		return false
	end

	vim.notify(string.format("Reverted %d commit(s)", commit_count), vim.log.levels.INFO)
	return true
end

---Get current branch or commit
---@param path? string Optional path
---@return string|nil
local function get_current_branch(path)
	path = path or vim.fn.getcwd()
	local cmd = string.format("git -C %s rev-parse --abbrev-ref HEAD 2>/dev/null", vim.fn.shellescape(path))
	local result = vim.trim(vim.fn.system(cmd))

	if vim.v.shell_error ~= 0 or result == "" then
		return nil
	end

	-- Handle detached HEAD
	if result == "HEAD" then
		local commit_cmd = string.format("git -C %s rev-parse HEAD 2>/dev/null", vim.fn.shellescape(path))
		result = vim.trim(vim.fn.system(commit_cmd))
		if vim.v.shell_error ~= 0 then
			return nil
		end
	end

	return result
end

---UI: Pick source worktree, create patch from it, apply to current worktree
function M.apply_patch()
	local worktrees = git_worktree.get_all_worktrees()
	local current_cwd = vim.fn.getcwd()
	local current_branch = get_current_branch(current_cwd)

	-- Filter to worktrees with changes (excluding current)
	local sources = {}
	for _, wt in ipairs(worktrees) do
		local is_current = current_cwd:find(wt.path, 1, true) == 1
		if not is_current then
			local has_uncommitted = git_worktree.worktree_has_changes(wt.path)
			local has_committed = false
			local commit_diff = nil

			-- Check for committed changes if we have a current branch to compare against
			if current_branch then
				has_committed = git_worktree.worktree_has_committed_changes(wt.path, current_branch)
				if has_committed then
					local wt_branch = wt.branch or wt.commit
					commit_diff = git_worktree.get_commit_difference(wt_branch, current_branch, wt.path)
				end
			end

			if has_uncommitted or has_committed then
				table.insert(sources, {
					worktree = wt,
					has_uncommitted = has_uncommitted,
					has_committed = has_committed,
					commit_diff = commit_diff,
				})
			end
		end
	end

	if #sources == 0 then
		vim.notify("No other worktrees with changes", vim.log.levels.WARN)
		return
	end

	local items = {}
	for _, source in ipairs(sources) do
		local wt = source.worktree
		local display = wt.branch or ("detached:" .. wt.commit)
		table.insert(items, {
			text = display,
			file = wt.path,
			value = source,
		})
	end

	Snacks.picker.pick({
		source = "worktrees",
		title = "Apply changes from worktree",
		items = items,
		format = function(item, ctx)
			local wt = item.value.worktree
			local ret = {}

			-- Branch name
			table.insert(ret, { wt.branch or ("@" .. wt.commit), "SnacksPickerLabel" })
			table.insert(ret, { " " })

			-- Change indicators
			if item.value.has_uncommitted then
				table.insert(ret, { "*", "DiagnosticWarn" })
			end

			if item.value.has_committed then
				local diff = item.value.commit_diff
				if diff then
					local indicator
					if diff.is_diverged then
						indicator = string.format(" (%d↑ %d↓)", diff.ahead, diff.behind)
					else
						indicator = string.format(" (%d commits)", diff.ahead)
					end
					table.insert(ret, { indicator, "DiagnosticInfo" })
				end
			end

			-- Path
			table.insert(ret, { " " })
			table.insert(ret, { tabs.shorten_path(wt.path), "SnacksPickerComment" })

			return ret
		end,
		actions = {
			confirm = function(picker, item)
				picker:close()
				if item and item.value then
					local source = item.value
					local source_wt = source.worktree
					local success_count = 0
					local errors = {}

					-- Apply committed changes first (if any)
					if source.has_committed then
						-- Warn about large commit ranges
						local diff = source.commit_diff
						if diff and diff.ahead > 10 then
							local choice = vim.fn.confirm(
								string.format("Apply %d commits?", diff.ahead),
								"&Yes\n&No",
								2
							)
							if choice ~= 1 then
								vim.notify("Cancelled commit application", vim.log.levels.INFO)
								return
							end
						end

						-- Warn about diverged branches
						if diff and diff.is_diverged and diff.behind > 5 then
							vim.notify(
								string.format("Warning: Branches have diverged (%d behind)", diff.behind),
								vim.log.levels.WARN
							)
						end

						local patch_dir = M.create_commit_patch_from_worktree(source_wt.path, current_branch)
						if patch_dir then
							local ok, err = M.apply_commit_patch_to_worktree(patch_dir, current_cwd)
							if ok then
								success_count = success_count + 1
								vim.notify(
									string.format("Applied %d commit(s) from %s", diff.ahead, source_wt.branch or source_wt.path),
									vim.log.levels.INFO
								)
							else
								table.insert(errors, "Commits: " .. (err or "Failed to apply"))
							end
						end
					end

					-- Apply uncommitted changes (if any)
					if source.has_uncommitted then
						local patch_path = M.create_patch_from_worktree(source_wt.path)
						if patch_path then
							local ok, err = M.apply_patch_to_worktree(patch_path, current_cwd)
							if ok then
								success_count = success_count + 1
								vim.notify(
									string.format("Applied uncommitted changes from %s", source_wt.branch or source_wt.path),
									vim.log.levels.INFO
								)
							else
								table.insert(errors, "Uncommitted: " .. (err or "Failed to apply"))
							end
						end
					end

					-- Report overall status
					if #errors > 0 then
						vim.notify("Errors:\n" .. table.concat(errors, "\n"), vim.log.levels.ERROR)
					elseif success_count == 0 then
						vim.notify("No changes were applied", vim.log.levels.WARN)
					end
				end
			end,
		},
	})
end

return M
