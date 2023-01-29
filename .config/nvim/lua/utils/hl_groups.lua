local hl_groups = {
	gitsigns = {
		GitSignsAdd          = "DiagnosticOk",
		GitSignsChange       = "DiagnosticWarn",
		GitSignsChangedelete = "DiagnosticWarn",
		GitSignsDelete       = "DiagnosticError",
		GitSignsTopdelete    = "DiagnosticError",
		GitSignsUntracked    = "NonText",
	}
}

return hl_groups
