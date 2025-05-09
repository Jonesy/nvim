-- Conform
--
-- Handles file formatting on save.

---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  local conform = require("conform")
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        bash = { "shellharden" },
        c = { "clang-format" },
        go = { "goimports", "gofmt" },
        -- NOTE: use sublist to pick biome first
        javascript = function(bufnr)
          return { first(bufnr, "biome", "prettier", "prettierd", "deno_fmt") }
        end,
        json = { "prettierd", "prettier" },
        liquid = { "prettierd", "prettier" },
        lua = { "stylua" },
        markdown = function(bufnr)
          -- return { first(bufnr, "deno_fmt", "prettierd", "prettier"), "injected" }
          return { first(bufnr, "deno_fmt", "prettierd", "prettier") }
        end,
        nix = { "alejandra" },
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
