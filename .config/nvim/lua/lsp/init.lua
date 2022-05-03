local servers = {
-- npm i -g bash-language-server
"bashls",
-- npm i -g typescript typescript-language-server
"tsserver",
-- npm i -g vscode-langservers-extracted
-- "eslint",
-- npm i -g vscode-css-languageserver-bin
"cssls",
-- npm i -g pyright
"pyright",
-- npm i -g vscode-json-languageserver
"jsonls",
-- npm i -g emmet-ls
"emmet_ls",
"jdtls",
-- "java_language_server",
-- npm install -g vscode-html-languageserver-bin
-- "html"
-- brew install tflint
"tflint",
-- brew install hashicorp/tap/terraform-ls
"terraform_lsp",
-- npm install -g yaml@next
"yamlls",
-- gem install --user-install solargraph
"solargraph",
}
-- npm i -g yaml@next emmet-ls vscode-json-languageserver pyright vscode-css-languageserver-bin typescript-language-server

require("fidget").setup{}
require("trouble").setup({
	position = "bottom",
	icons = true,
	mode = "workspace_diagnostics",
	action_keys = {
		close = "q",
		cancel = "<esc>",
		refresh = "r",
		jump = {"<cr>", "<tab>"},
		open_split = { "<c-x>" },
		open_vsplit = { "<c-v>" },
		open_tab = { "<c-t>" },
		jump_close = {"o"},
		toggle_mode = "m",
		toggle_preview = "p",
		hover = "k",
		preview = "p",
		close_folds = {"zm", "zm"},
		open_folds = {"zr", "zr"},
		toggle_fold = {"za", "za"},
		previous = "k",
		next = "j"
	},
	auto_open = false,
	auto_close = false,
	auto_preview = true,
	auto_fold = false,
	use_diagnostic_signs = true
})

-- Stop lsp diagnostics from showing virtual text
vim.diagnostic.config({
	virtual_text = {spacing = 4}, -- = false,
	update_in_insert = false,
	underline = true,
	signs = true,
	update_in_insert = false
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, { focusable = false }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, { focusable = false }
)

-- local coq = require "coq"
local nvim_lsp = require "lspconfig"
local configs = require "lspconfig/configs"

-- npm i -g diagnostic-languageserver
nvim_lsp.diagnosticls.setup {
	filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "css"},
	init_options = {
		filetypes = {
			javascript = "eslint",
			typescript = "eslint",
			javascriptreact = "eslint",
			typescriptreact = "eslint"
		},
		linters = {
			eslint = {
				sourceName = "eslint_d",
				command = "eslint_d",
				rootPatterns = {
					".eslitrc.js",
					"package.json"
				},
				debounce = 1000,
				args = {
					"--cache",
					"--stdin",
					"--stdin-filename",
					"%filepath",
					"--format",
					"json"
				},
				parseJson = {
					errorsRoot = "[0].messages",
					line = "line",
					column = "column",
					endLine = "endLine",
					endColumn = "endColumn",
					message = "${message} [${ruleId}]",
					security = "severity"
				},
				securities = {
					[2] = "error",
					[1] = "warning"
				}
			}
		},
		formatters = {
			eslint = {
				command = "eslint_d",
				args = { "--stdin" },
				rootPatterns = {
					"package.json",
					".eslintrc.js"
				}
			}
		}
	}
}

configs.emmet_ls = {
	default_config = {
		cmd = {"emmet-ls", "--stdio"},
		filetypes = {"html", "css"},
		root_dir = function()
			return vim.loop.cwd()
		end,
		settings = {}
	}
}

-- configs.java_language_server = {
-- 	default_config = {
-- 		cmd = {'/Users/tarryn/git/java-language-server/dist/lang_server_mac.sh'},
-- 		filetypes = {"java"}
-- 	}
-- }

configs.terraform_lsp = {
	default_config = {
		cmd = {'terraform-lsp'},
		filetypes = { 'terraform', 'hcl', 'tf' }
	}
}

local luapath = "/usr/local/" -- "~/.local/share/nvim/lua/sumneko_lua"
local luabin = luapath .. "/bin/lua-language-server"

nvim_lsp.sumneko_lua.setup {
	cmd = {luabin, "-E", luapath .. "/main.lua"},
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
				-- Setup your lua path
				path = vim.split(package.path, ";")
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {"vim", "use", "Formatting"}
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
				},
				maxPreload = 10000
			},
			telemetry = {
				enable = false
			}
		}
	}
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = {noremap = true, silent = true}
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	-- Set some keybinds conditional on server capabilities
	if client.server_capabilities.document_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	elseif client.server_capabilities.document_range_formatting then
		buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
	end
end

vim.schedule(function ()
	for i,lang in pairs(servers) do
		-- nvim_lsp[lang].setup(coq.lsp_ensure_capabilities({
		nvim_lsp[lang].setup({
			on_attach = on_attach,
			capabilities = capabilities,
			root_dir = vim.loop.cwd
		})
	end
end)

vim.fn.sign_define(
	"LspDiagnosticsSignError",
	{
		texthl = "LspDiagnosticsSignError",
		text = "",
		numhl = "LspDiagnosticsSignError"
	}
)
vim.fn.sign_define(
	"LspDiagnosticsSignWarning",
	{
		texthl = "LspDiagnosticsSignWarning",
		text = "",
		numhl = "LspDiagnosticsSignWarning"
	}
)
vim.fn.sign_define(
	"LspDiagnosticsSignInformation",
	{
		texthl = "LspDiagnosticsSignInformation",
		text = "",
		numhl = "LspDiagnosticsSignInformation"
	}
)
vim.fn.sign_define(
	"LspDiagnosticsSignHint",
	{
		texthl = "LspDiagnosticsSignHint",
		text = "",
		numhl = "LspDiagnosticsSignHint"
	}
)

