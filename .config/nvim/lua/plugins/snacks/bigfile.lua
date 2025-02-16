return {
	enabled = true,
	notify = true, -- show notification when big file detected
	size = 2 * 1024 * 1024, -- 1.5MB
	line_length = 1000, -- average line length (useful for minified files)
	setup = function(ctx)
		if vim.fn.exists(":NoMatchParen") ~= 0 then
			vim.cmd([[NoMatchParen]])
		end
		Snacks.util.wo(0, { foldmethod = "manual", statuscolumn = "", conceallevel = 0 })
		vim.schedule(function()
			require("colorizer").detach_from_buffer()
			if vim.api.nvim_buf_is_valid(ctx.buf) then
				vim.bo[ctx.buf].syntax = ctx.ft
			end
		end)
	end,
}
