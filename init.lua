local COLUMN_WIDTH = 80

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

--[
-- Keymaps 
--]
local kset = vim.keymap.set
local noremap_opts = { silent = true, noremap = true }

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

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { 
  clear = true
})

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
