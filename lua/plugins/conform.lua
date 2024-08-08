return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        bash = { "shellharden" },
        go = { "goimports", "gofmt" },
        -- NOTE: use sublist to pick biome first
        javascript = { "biome", "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        liquid = { "prettierd", "prettier" },
        lua = { "stylua" },
        markdown = { "prettierd", "prettier", stop_after_first = true },
        scss = { "stylelint" },
        sh = { "shellharden" },
        templ = { "templ" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function(args)
        conform.format({ bufnr = args.buf })
      end,
    })
  end,
}
