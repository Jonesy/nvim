local COLUMN_WIDTH = 80

-- Functions
local kset = vim.keymap.set
local noremap_opts = { silent = true, noremap = true }
local ptable = function(t)
  for key, value in pairs(t) do
    print(key, value)
  end
end

--[[
-- Global settings 
--]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--[[
-- Options 
--]]

-- Search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- File options
vim.o.clipboard = "unnamedplus" -- OS clipboard
vim.o.encoding = "utf-8"
vim.o.swapfile = false
vim.o.undofile = true

-- Line breaks
vim.o.breakindent = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.textwidth = COLUMN_WIDTH

-- Shift/Tab widths
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true

-- Display
vim.o.termguicolors = true
vim.o.splitbelow = true
vim.o.splitright = true

-- Window Options
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes" -- Always add a little buffer for any signs to left
vim.wo.colorcolumn = tostring(COLUMN_WIDTH) -- Display the column vertical line

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", {
  clear = true,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

--[[
-- Plugins
--]]
local gh = function(package)
  return "https://github.com/" .. package
end

-- Colorscheme
vim.pack.add({ gh("eldritch-theme/eldritch.nvim") }, { confirm = false })
vim.cmd.colorscheme("eldritch-dark")

-- Treesitter
vim.api.nvim_create_autocmd("PackChanged", {
  desc = "Handle nvim-treesitter updates",
  group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
  callback = function(event)
    if event.data.kind == "update" and event.data.spec.name == "nvim-treesitter" then
      vim.notify("nvim-treesitter updated, running TSUpdate...", vim.log.levels.INFO)
      ---@diagnostic disable-next-line: param-type-mismatch
      local ok = pcall(vim.cmd, "TSUpdate")

      if ok then
        vim.notify("TSUpdate completed successfiully", vim.log.levels.INFO)
      else
        vim.notify("TSUpdate command not available yet, skipping...", vim.log.levels.WARN)
      end
    end
  end,
})

vim.pack.add({
  {
    src = gh("nvim-treesitter/nvim-treesitter"),
    version = "main",
  },
  {
    src = gh("nvim-treesitter/nvim-treesitter-textobjects"),
    version = "main",
  },
}, { load = true })

require("nvim-treesitter").setup({
  auto_install = true,
  sync_install = true,
  ensure_installed = {
    "c",
    "elm",
    "go",
    "hare",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "ocaml",
    "python",
    "rust",
    "swift",
    "templ",
    "tsx",
    "typescript",
    "vimdoc",
    "vim",
    "zig",
  },
})

-- Mini
vim.pack.add({ gh("nvim-mini/mini.nvim") })

require("mini.comment").setup({
  mappings = {
    comment = "<leader>/",
    comment_line = "<leader>/",
    comment_visual = "<leader>/",
  },
})
require("mini.files").setup({})
require("mini.icons").setup()
require("mini.notify").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
require("mini.statusline").setup()
require("mini.surround").setup()

local pick_files = function()
  MiniPick.builtin.files({ tool = "git" })
end

kset("n", "<leader>bb", MiniPick.builtin.buffers, noremap_opts)
kset("n", "<leader>ff", pick_files, noremap_opts)
kset("n", "<leader>fh", MiniPick.builtin.help, noremap_opts)
kset("n", "<leader>e", MiniFiles.open, noremap_opts)

-- LSP
vim.pack.add({
  gh("neovim/nvim-lspconfig"),
  gh("mason-org/mason.nvim"),
})
require("mason").setup()

-- Enable LSP if in Git repo
vim.lsp.config("*", { root_markers = { ".git" } })

local lsps = {
  { "cssls" },
  {
    "eslint",
  },
  { "gopls" },
  {
    "lua_ls",
    {
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
    },
  },
  {
    "ts_ls",
  },
}

for _, lsp in pairs(lsps) do
  local name, config = lsp[1], lsp[2]

  vim.lsp.enable(name)

  if config then
    vim.lsp.config(name, config)
  end
end

-- Diagostics
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
})

kset("n", "gd", vim.lsp.buf.definition, noremap_opts)
kset("n", "grt", vim.lsp.buf.type_definition, noremap_opts)
kset("n", "rn", vim.lsp.buf.rename, noremap_opts)

--[
-- Conform - Formatting
--]
vim.pack.add({ gh("stevearc/conform.nvim") })

local conform = require("conform")

---@param bufnr integer
---@param ... string
---@return string
local function first(bufnr, ...)
  for i = 1, select("#", ...) do
    local formatter = select(i, ...)
    if conform.get_formatter_info(formatter, bufnr).available then
      return formatter
    end
  end
  return select(1, ...)
end

conform.setup({
  formatters_by_ft = {
    bash = { "shellharden" },
    c = { "clang-format" },
    css = function(bufnr)
      return { first(bufnr, "prettierd", "prettier", "biome", "stylelint") }
    end,
    go = { "goimports", "gofmt" },
    html = function(bufnr)
      return { first(bufnr, "biome", "prettier", "prettierd") }
    end,
    -- NOTE: use sublist to pick biome first
    javascript = function(bufnr)
      return { first(bufnr, "prettier", "prettierd", "biome", "deno_fmt") }
    end,
    json = { "prettierd", "prettier" },
    liquid = { "prettierd", "prettier" },
    lua = { "stylua" },
    markdown = function(bufnr)
      -- return { first(bufnr, "deno_fmt", "prettierd", "prettier"), "injected" }
      return { first(bufnr, "deno_fmt", "prettierd", "prettier") }
    end,
    nix = { "alejandra" },
    php = function(bufnr)
      return { first(bufnr, "pint", "pretty-php") }
    end,
    scss = function(bufnr)
      return { first(bufnr, "prettierd", "prettier", "stylelint") }
    end,
    sh = { "shellharden" },
    templ = { "templ" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

--[
-- Global Keymaps
--]
kset({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
kset("n", "<leader>rl", ":so %<CR>", noremap_opts)
kset("n", "<leader>q", ":qa<CR>", noremap_opts)

-- Splitting
kset("n", "_", ":split<CR>", noremap_opts)
kset("n", "|", ":vsplit<CR>", noremap_opts)

-- Window navigation
kset("n", "<C-h>", "<C-w>h", noremap_opts)
kset("n", "<C-l>", "<C-w>l", noremap_opts)
kset("n", "<C-j>", "<C-w>j", noremap_opts)
kset("n", "<C-k>", "<C-w>k", noremap_opts)

-- Buffers
kset("n", "<leader>bn", ":bnext<CR>", noremap_opts)
kset("n", "<leader>bp", ":bprevious<CR>", noremap_opts)
kset("n", "<leader>c", ":bd!<CR>", noremap_opts)

-- Resize with arrows
kset("n", "<C-Up>", ":resize +2<CR>", noremap_opts)
kset("n", "<C-Down>", ":resize -2<CR>", noremap_opts)
kset("n", "<C-Left>", ":vertical resize -2<CR>", noremap_opts)
kset("n", "<C-Right>", ":vertical resize +2<CR>", noremap_opts)

-- +/- inc/dec
kset("n", "+", "<C-a>")
kset("n", "-", "<C-x>")

-- Moving lines up/down
kset("v", "<C-j>", ":move '>+1<CR>gv-gv", noremap_opts)
kset("v", "<C-k>", ":move '<-2<CR>gv-gv", noremap_opts)

-- Better pasting (doesn't swap the clipboard contents with what you replaced)
kset("v", "p", '"_dP', noremap_opts)

-- Open scratch buffer
kset("n", "<leader>n", ":new<CR>", noremap_opts)
