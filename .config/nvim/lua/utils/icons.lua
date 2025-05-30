local icons = {
	error = "",
	warn = "",
	info = "",
	hint = "",
	ok = "",
	branch = "",
	git_add = "",
	git_delete = "",
	git_change = "",
	file = "",
	unsaved = "",
	readonly = "",
	fold_expanded = "-", --"",
	fold_collapsed = "+", --""",
	gitsigns_bar = "│",
	-- gitsigns_bar = "┃",
}

icons.diag_signs = {
	DiagnosticSignError = icons.error,
	DiagnosticSignWarn = icons.warn,
	DiagnosticSignInfo = icons.info,
	DiagnosticSignHint = icons.hint,
	DiagnosticSignOk = icons.ok
}

icons.spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }

return icons
