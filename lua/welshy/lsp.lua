local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end
local keymap = vim.keymap.set
local diagnostic = vim.diagnostic
local api = vim.api
local fn = vim.fn

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
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- CSS
lspconfig.cssls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})
-- TypeScript
lspconfig.tsserver.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Lua
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
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

-- Formatting
-- Adapted from NVIM Kickstart
local _augroups = {}
local get_augroup = function(client)
  if not _augroups[client.id] then
    local group_name = "abc-lsp-format-" .. client.name
    local id = api.nvim_create_augroup(group_name, { clear = true })
    _augroups[client.id] = id
  end
  return _augroups[client.id]
end

api.nvim_create_autocmd("LspAttach", {
  group = api.nvim_create_augroup("abc-lsp-attach-format", { clear = true }),
  callback = function(args)
    local client_id = args.data.client_id
    local client = vim.lsp.get_client_by_id(client_id)
    local bufnr = args.bufnr

    if not client.server_capabilities.documentFormattingProvider then
      return
    end
    -- TODO: add source kit support (not supported by LSP)
    -- if client.name == "sourcekit" then
    --   local input = api.nvim_buf_get_lines(0, 0, -1, true)
    --   local cmd = "swift-format format"
    --   local output = fn.system(cmd, input)
    --   local formatted = fn.split(output, "\n")
    --   api.nvim_buf_set_lines(0, 0, -1, false, formatted)
    -- end

    api.nvim_create_autocmd("BufWritePre", {
      group = get_augroup(client),
      buffer = bufnr,
      callback = function()
        if client.name == "lua_ls" then
          local input = api.nvim_buf_get_lines(0, 0, -1, true)
          local cmd = "stylua --search-parent-directories -"
          local output = fn.system(cmd, input)
          local formatted = fn.split(output, "\n")
          api.nvim_buf_set_lines(0, 0, -1, false, formatted)
          -- TODO: break this out to a reusable function that can be called with TS
        elseif client.name == "tsserver" then
          local input = api.nvim_buf_get_lines(0, 0, -1, true)
          local cmd = "prettierd " .. api.nvim_buf_get_name(0)
          local output = fn.system(cmd, input)
          if vim.v.shell_error ~= 0 then
            vim.notify("formatting error", vim.log.levels.ERROR)
          else
            local formatted = fn.split(output, "\n")
            api.nvim_buf_set_lines(0, 0, -1, false, formatted)
          end
        else
          vim.lsp.buf.format({
            async = false,
            timeout = 3000,
            filter = function(c)
              return c.id == client.id
            end,
          })
        end
      end,
    })
  end,
})
