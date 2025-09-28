local icons = require("utils.icons")
-- local spinner = icons.spinner

vim.diagnostic.config({
	virtual_text = { current_line = true, severity = { min = "WARN", max = "ERROR" } }, -- {spacing = 6, severity = "error"},
	-- virtual_lines = { current_line = true, severity = { min = "ERROR" } },
	update_in_insert = false,
	underline = true,
	signs = {
		active = true,
		text = {
			[vim.diagnostic.severity.ERROR] = icons.error,
			[vim.diagnostic.severity.WARN] = icons.warn,
			[vim.diagnostic.severity.INFO] = icons.info,
			[vim.diagnostic.severity.HINT] = icons.hint,
		},
		texthl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
	},
})

-- Autocommand to modify the behavior of LSP clients
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("LspInlayHintEnable", {}),
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- Enable inlay hints
		if vim.g.enable_inlay_hints then
			vim.lsp.inlay_hint.enable(true)
		end
		-- Enable document color if the client supports it
		if client and client:supports_method("textDocument/documentColor") and vim.lsp.document_color then
			vim.lsp.document_color.enable(true, args.buf, {
				style = "virtual",
			})
		end
	end,
})
-- Autocommand to notify when LSP progress is made
--[[ vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		vim.notify(vim.lsp.status(), vim.log.levels.INFO, {
			id = "lsp_progress",
			title = "LSP Progress",
			icon = " " .. (ev.data.params.value.kind == "end" and icons.ok or spinner[math.floor(
				vim.uv.hrtime() / (1e6 * 80)
			) % #spinner + 1]),
		})
	end,
}) ]]
