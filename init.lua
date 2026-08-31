local COLUMN_WIDTH = 80

-- Functions
local kset = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local noremap_opts = { silent = true, noremap = true }
ptable = function(t)
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

-- vim.o.spell = true
vim.o.spelllang = "en_ca"

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = augroup("YankHighlight", {
  clear = true,
})

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

--[[
-- Plugins
--]]
require("vim._core.ui2").enable({})
local pack_changed_group = augroup("nvim-treesitter-pack-changed-update-handler", { clear = true })

autocmd("PackChanged", {
  desc = "Handle nvim-treesitter updates",
  group = pack_changed_group,
  callback = function(event)
    local name, kind = event.data.spec.name, event.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not event.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      ---@diagnostic disable-next-line: param-type-mismatch
      local ok = pcall(vim.cmd, "TSUpdate")

      if ok then
        vim.notify("TSUpdate completed successfully", vim.log.levels.INFO)
      else
        vim.notify("TSUpdate command not available yet, skipping...", vim.log.levels.WARN)
      end
    end
  end,
})

local gh = function(package)
  return "https://github.com/" .. package
end

vim.pack.add({
  gh("eldritch-theme/eldritch.nvim"),
  {
    src = gh("nvim-treesitter/nvim-treesitter"),
    version = "main",
  },
  {
    src = gh("nvim-treesitter/nvim-treesitter-textobjects"),
    version = "main",
  },
  gh("nvim-mini/mini.nvim"),
  gh("neovim/nvim-lspconfig"),
  gh("b0o/schemastore.nvim"),
  gh("stevearc/conform.nvim"),
  gh("lewis6991/gitsigns.nvim"),
}, { confirm = false })

-- Colorscheme
vim.cmd.colorscheme("eldritch-dark")

-- Treesitter
local parsers = {
  "c",
  "css",
  "elm",
  "gleam",
  "gren",
  "go",
  "hare",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "ocaml",
  "python",
  "qmljs",
  "rust",
  "swift",
  "templ",
  "tsx",
  "typescript",
  "vimdoc",
  "vim",
  "zig",
}
local ts = require("nvim-treesitter")

ts.install(parsers)

autocmd("FileType", {
  pattern = parsers,
  callback = function()
    vim.treesitter.start()
  end,
})

require("sa.api").setup()

-- Mini
require("mini.comment").setup({
  mappings = {
    comment = "<leader>/",
    comment_line = "<leader>/",
    comment_visual = "<leader>/",
  },
})
require("mini.snippets").setup()
require("mini.completion").setup({
  lsp_completion = { source_func = "omnifunc" },
})
require("mini.ai").setup()
require("mini.extra").setup()
require("mini.files").setup()
require("mini.icons").setup()
require("mini.notify").setup()
require("mini.pairs").setup()
require("mini.pick").setup()
require("mini.statusline").setup()
require("mini.surround").setup()

-- Picker
local pick_files = function()
  MiniPick.builtin.files({ tool = "git" })
end

local pick_symbols = function()
  MiniExtra.pickers.lsp({ scope = "document_symbol" })
end

kset("n", "<leader>bb", MiniPick.builtin.buffers, noremap_opts)
kset("n", "<leader>ff", pick_files, noremap_opts)
kset("n", "<leader>fg", MiniPick.builtin.grep_live, noremap_opts)
kset("n", "<leader>fs", pick_symbols, noremap_opts)
kset("n", "<leader>fh", MiniPick.builtin.help, noremap_opts)
kset("n", "<leader>e", MiniFiles.open, noremap_opts)

-- LSP
if vim.fn.has("mac") == 1 then
  vim.pack.add({ gh("mason-org/mason.nvim") })
  require("mason").setup()
end

-- Enable LSP if in Git repo
vim.lsp.config("*", { root_markers = { ".git" } })
vim.lsp.inlay_hint.enable(true)

local lsps = {
  { "clangd" },
  { "cssls" },
  { "elmls" },
  { "eslint" },
  { "gopls" },
  { "qmlls" },
  {
    "jsonls",
    {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    },
  },
  {
    "lua_ls",
    {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
        },
      },
    },
  },
  { "marksman" },
  { "nixd" },
  { "pico8_ls" },
  { "stylelint_lsp", { root_dir = { "stylelint.config.mjs" } } },
  { "somesass_ls" },
  {
    "emmet_language_server",
    {
      settings = {
        filetypes = {
          "css",
          "eruby",
          "html",
          "javascript",
          "javascriptreact",
          "less",
          "php",
          "sass",
          "scss",
          "pug",
          "typescriptreact",
          "templ",
        },
      },
    },
  },
  {
    "vtsls",
    {
      settings = {
        javascript = {
          preferences = {
            importModuleSpecifierEnding = "js",
          },
        },
      },
    },
  },
  {
    "yamlls",
    {
      settings = {
        yaml = {
          validate = true,
          -- disable the schema store
          schemaStore = {
            enable = false,
            url = "",
          },
          -- reference https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/api/json/catalog.json
          -- use inline comment for specific versions # yaml-language-server: $schema=<urlToTheSchema|relativeFilePath|absoluteFilePath}>
          schemas = {
            ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose*.{yml,yaml}",
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
          },
        },
      },
    },
  },
  { "zls" },
}

vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })

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
kset("n", "gr", vim.lsp.buf.references, noremap_opts)
kset("n", "<leader>ca", vim.lsp.buf.code_action, noremap_opts)
kset("n", "<leader>do", vim.diagnostic.open_float, noremap_opts)
kset("n", "<leader>dl", vim.diagnostic.setloclist, noremap_opts)

--[
-- Conform - Formatting
--]
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
      return { first(bufnr, "biome", "prettierd", "prettier") }
    end,
    go = { "goimports", "gofmt" },
    html = function(bufnr)
      return { first(bufnr, "biome", "prettier", "prettierd") }
    end,
    -- NOTE: use sublist to pick biome first
    javascript = function(bufnr)
      return { first(bufnr, "biome", "prettierd", "prettier") }
    end,
    json = function(bufnr)
      return { first(bufnr, "biome", "prettier", "prettierd") }
    end,
    liquid = { "prettierd", "prettier" },
    lua = { "stylua" },
    markdown = function(bufnr)
      return { first(bufnr, "panache", "prettierd", "prettier"), "injected" }
    end,
    nix = { "alejandra" },
    php = function(bufnr)
      return { first(bufnr, "pint", "pretty-php") }
    end,
    scss = function(bufnr)
      return { first(bufnr, "prettierd", "prettier") }
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
-- Gitsigns
--]
local gitsigns = require("gitsigns")

gitsigns.setup({
  signs = {
    add = { text = "▉" },
    change = { text = "▉" },
    delete = { text = "▓" },
    topdelete = { text = " " },
    changedelete = { text = "▒" },
    untracked = { text = "░" },
  },
})

kset("n", "<leader>gl", gitsigns.setqflist, noremap_opts)

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
kset("n", "<leader>x", ":bd!<CR>", noremap_opts)

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
