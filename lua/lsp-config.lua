local lsp = require("lspconfig")
local cmp = require("cmp_nvim_lsp")
local saga = require("lspsaga")

-- LSP this is needed for LSP completions in CSS along with the snippets plugin
local capabilities = cmp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

-- Formatter
lsp.diagnosticls.setup {
    filetypes = {
        "javascript",
        "javascriptreact",
        "json",
        "typescript",
        "typescriptreact",
        "css",
        "markdown",
    },
    init_options = {
        linters = {
            formatters = {
                prettier = {
                    command = "prettier",
                    args = { "--stdin-filepath", "%filename" },
                },
            },
            formatFiletypes = {
                css = "prettier",
                json = "prettier",
                javascript = "prettier",
                javascriptreact = "prettier",
                typescript = "prettier",
                typescriptreact = "prettier",
            },
        },
    },
}

-- CSS #cssls
lsp.cssls.setup {
  settings = {
    css = {
      lint = {
        idSelector = "warning",
        zeroUnits = "warning",
        duplicateProperties = "warning",
      },
      completion = {
        completePropertyWithSemicolon = true,
        triggerPropertyValueCompletion = true,
      },
    }
  },
  capabilities = capabilities,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end,
}

-- ESLint
lsp.eslint.setup{}

-- TypeScript
lsp.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
  end,
}

-- LSP Prevents inline buffer annotations
vim.lsp.diagnostic.show_line_diagnostics()
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   virtual_text = false,
--   signs = true,
--   underline = true,
--   update_on_insert = false,
-- })

local signs = {
  Error = "ﰸ",
  Warn = "",
  Hint = "",
  Info = "",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = nil })
end

saga.init_lsp_saga {
  error_sign = "!",
  warn_sign = "^",
  hint_sign = "?",
  infor_sign = "~",
  border_style = "round",
  code_action_prompt = {
    enable = false
  },
}
