local M = {}

M.capabilities = function(force_snippet_support)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local ok, blink = pcall(require, "blink.cmp")
	if ok then
		capabilities = blink.get_lsp_capabilities(capabilities)
	end
	if force_snippet_support then
		capabilities.textDocument.completion.completionItem.snippetSupport = true
	end
	return capabilities
end

return M
