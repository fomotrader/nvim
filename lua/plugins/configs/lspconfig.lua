-- Setup language servers.
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
	return
end

lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.gopls.setup({})
lspconfig.rust_analyzer.setup({
	-- Server-specific settings. See `:help lspconfig-setup`
	settings = {
		["rust-analyzer"] = {},
	},
})
lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

local keymap = vim.keymap
local api = vim.api
local lsp = vim.lsp
local capabilities = lsp.protocol.make_client_capabilities()

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
keymap.set("n", "<space>e", vim.diagnostic.open_float)
keymap.set("n", "[d", vim.diagnostic.goto_prev)
keymap.set("n", "]d", vim.diagnostic.goto_next)
keymap.set("n", "<space>q", vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
api.nvim_create_autocmd("LspAttach", {
	group = api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		keymap.set("n", "gD", lsp.buf.declaration, opts)
		keymap.set("n", "gd", lsp.buf.definition, opts)
		keymap.set("n", "K", lsp.buf.hover, opts)
		keymap.set("n", "gi", lsp.buf.implementation, opts)
		keymap.set("n", "<C-k>", lsp.buf.signature_help, opts)
		keymap.set("n", "<space>wa", lsp.buf.add_workspace_folder, opts)
		keymap.set("n", "<space>wr", lsp.buf.remove_workspace_folder, opts)
		keymap.set("n", "<space>wl", function()
			print(vim.inspect(lsp.buf.list_workspace_folders()))
		end, opts)
		keymap.set("n", "<space>D", lsp.buf.type_definition, opts)
		keymap.set("n", "<space>rn", lsp.buf.rename, opts)
		keymap.set({ "n", "v" }, "<space>ca", lsp.buf.code_action, opts)
		keymap.set("n", "gr", lsp.buf.references, opts)
		keymap.set("n", "<space>fm", function()
			lsp.buf.format({ async = true })
		end, opts)
	end,
})

capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

local on_attach = function(client)
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

local servers = { "tsserver", "html", "cssls", "gopls" }

for _, language_server in ipairs(servers) do
	lspconfig[language_server].setup({
		capabilities = capabilities,
	})
end

lspconfig.lua_ls.setup({
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
})
