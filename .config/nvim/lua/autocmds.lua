local u = require("utils.core")

u.define_augroups({
	trim_whitespaces = {
		{"BufWritePre", "*", [[%s/\s\+$//e]]},
		{"BufWritePre", "*", [[%s/\n\+\%$//e]]}
		-- {"BufWritePre", "*.[ch]", [[*.[ch] %s/\%$/\r/e]]}
	},
	filetypes = {
		{"FileType", "*", "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"}
	}
})
