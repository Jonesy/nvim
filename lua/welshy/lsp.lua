local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end
local keymap = vim.keymap.set
local diagnostic = vim.diagnostic

-- Diagnostics
keymap("n", "[d", diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap("n", "]d", diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap("n", "<leader>x", diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap("n", "<leader>xl", diagnostic.setloclist, { desc = "Open diagnosics list" })

-- Handler to setup keymapping when server attaches
local on_attach = function(_, bufnr)
  -- mapping callback
  local nmap = function(keys, func, desc)
    if desc then
      desc = "[LSP] " .. desc
    end
    keymap("n", keys, func, { buffer = bufnr, desc = desc })
  end

  -- Actions
  nmap("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
  nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  nmap("gd", vim.lsp.buf.definition, "Go to Definition")
  nmap("gi", vim.lsp.buf.type_definition, "Type Definition")
  nmap("gr", vim.lsp.buf.references, "Show References")
  -- Inline
  nmap("K", vim.lsp.buf.hover, "Hover documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

  -- if client.server_capabilities.inlayHintProvider then
  --   vim.lsp.inlay_hint.enable(bufnr, true)
  -- end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
-- Requires npm i -g css-variables-language-server
-- lspconfig.css_variables.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

-- HTML
lspconfig.html.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
-- Requires @olrtg/emmet-language-server
lspconfig.emmet_language_server.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Custom Elements
-- requires npm install -g custom-elements-languageserver
-- lspconfig.custom_elements_ls.setup({
--   capabilities = capabilities,
--   on_attach = on_attach,
-- })

-- TypeScript
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- ESLint
lspconfig.eslint.setup({
  capabilities = capabilities,
  on_attach = function(_, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "ESLintFixAll",
    })
  end,
})

lspconfig.biome.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

-- Go
lspconfig.gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Rust
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Zig
lspconfig.zls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Swift
lspconfig.sourcekit.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Nix
lspconfig.nil_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
})
