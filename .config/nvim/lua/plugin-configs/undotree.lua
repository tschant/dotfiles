local u = require("utils.core")
local e = require("utils.extra")
local fn = vim.fn

if fn.has("persistent_undo") then
	local target_path = fn.stdpath("data") .. "/undodir"
	--     " create the directory and any parent directories
	--     " if the location does not exist.
	print(target_path)
	if not e.isdir(target_path) then
		fn.mkdir(target_path, "p", 0777)
	end

	u.opt("o", "undodir", target_path)
	u.opt("b", "undofile", true)
end
