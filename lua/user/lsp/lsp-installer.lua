local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
local schemastore = require("schemastore")
local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local handlers = require("user.lsp.handlers")

if not status_ok then
	return
end

lsp_installer.setup({
	automatic_installation = true,
	ensure_installed = { "tsserver", "graphql", "denols", "cssls", "emmet_ls" },
})

-- Ensure VSCode LSP package is installed: npm i -g vscode-langservers-extracted
local jsonCapabilities = vim.lsp.protocol.make_client_capabilities()
jsonCapabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.jsonls.setup({
	on_attach = handlers.on_attach,
	capabilities = jsonCapabilities,
	init_options = {
		provideFormatter = false,
	},
	settings = {
		json = {
			schemas = schemastore.json.schemas(),
		},
	},
	setup = {
		commands = {},
	},
})

lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig.denols.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
	root_dir = util.root_pattern("deno.json"),
	init_options = {
		lint = true,
	},
})

lspconfig.tsserver.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.rust_analyzer.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.cssls.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
})

lspconfig.emmet_ls.setup({
	on_attach = handlers.on_attach,
	capabilities = handlers.capabilities,
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.html.setup({
	on_attach = handlers.on_attach,
	capabilities = capabilities,
})
