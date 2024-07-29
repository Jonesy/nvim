local os = vim.fn.system("uname")

return {
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        "williamboman/mason.nvim",
        config = function()
          require("mason").setup()
        end,
        enable = function()
          return os == "Darwin"
        end,
      },
      {
        "williamboman/mason-lspconfig.nvim",
        config = function()
          require("mason-lspconfig").setup()
        end,

        enable = function()
          return os == "Darwin"
        end,
      },

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            "~/Developer/PlaydateSDK/CoreLibs",
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local keymap = vim.keymap.set
      local diagnostic = vim.diagnostic

      vim.filetype.add({
        extension = {
          templ = "templ",
        },
      })

      -- Diagnostics
      keymap("n", "[d", diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
      keymap("n", "]d", diagnostic.goto_next, { desc = "Go to next diagnostic message" })
      keymap("n", "<leader>x", diagnostic.open_float, { desc = "Open floating diagnostic message" })
      keymap("n", "<leader>xl", diagnostic.setloclist, { desc = "Open diagnosics list" })
      -- Handler to setup keymapping when server attaches
      local on_attach = function(client, bufnr)
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

        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true)
        end
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      -- Markdown
      lspconfig.marksman.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- CSS
      lspconfig.cssls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
      lspconfig.somesass_ls.setup({
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
        settings = {
          single_file_support = false,
        },
      })

      lspconfig.denols.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = util.root_pattern("deno.json", "deno.jsonc"),
      })

      -- As per docs
      vim.g.markdown_fenced_languages = {
        "ts=typescript",
      }

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

      -- Templ (Go)
      lspconfig.templ.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- Rust
      -- Disabled in favour of rustacean plugin
      -- lspconfig.rust_analyzer.setup({
      --   capabilities = capabilities,
      --   on_attach = on_attach,
      -- })

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

      -- Shopify
      lspconfig.shopify_theme_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
      })
    end,
  },
}
