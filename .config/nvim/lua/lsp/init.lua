local servers = {
-- npm i -g bash-language-server
	"bashls",
-- npm i -g typescript typescript-language-server
	"tsserver",
-- npm i -g vscode-css-languageserver-bin
	"cssls",
-- npm i -g pyright
	"pyright",
-- npm i -g vscode-json-languageserver
	"jsonls",
-- npm i -g emmet-ls
	"emmet_ls"
-- npm install -g vscode-html-languageserver-bin
-- "html"
}

-- Stop lsp diagnostics from showing virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    {
        virtual_text = false,
        update_in_insert = false,
        underline = true,
        signs = true
    }
)

-- local coq = require "coq"
local nvim_lsp = require "lspconfig"
local configs = require "lspconfig/configs"

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
				sourceName = "eslint",
				command = "./node_modules/.bin/eslint",
				rootPatterns = {
					".eslitrc.js",
					"package.json"
				},
				debounce = 100,
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

local luapath = "/home/rafa/.local/share/nvim/lua/sumneko_lua"
local luabin = luapath .. "/bin/Linux/lua-language-server"

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
                globals = {"vim", "use", "Theming", "Formatting"}
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

local function on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = {noremap = true, silent = true}

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Mappings.
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
end

for i,lang in pairs(servers) do
	-- print(lang, nvim_lsp)
	-- coq.lsp_ensure_capabilities

	nvim_lsp[lang].setup({
		on_attach = on_attach,
		capabilities = capabilities,
		root_dir = vim.loop.cwd
	})
end
