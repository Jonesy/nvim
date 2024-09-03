-- Core Vim configuration options
local MAX_WIDTH = 80

-- First things first, spacebar is the leaderkey
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- highlight on search
vim.o.hlsearch = false

-- Spell check
vim.opt.spelllang = "en_us"
vim.opt.spell = true

-- [ Encoding ]
vim.o.encoding = "utf-8"

-- Set clipboard to use OS
vim.o.clipboard = "unnamedplus"

-- Save undo
vim.o.undofile = true

-- Disable swap files
vim.o.swapfile = false

-- Wrapping is indented
vim.o.breakindent = true

-- Keep sign column
-- HINT: gq<motion> to format line
vim.wo.signcolumn = "yes"
vim.wo.colorcolumn = "80"
vim.o.wrap = true
vim.o.linebreak = true
vim.o.textwidth = MAX_WIDTH

-- Splits
-- Force all horizontal splits to go below current window
vim.o.splitbelow = true
-- Force all vertical splits to go to the right of current window
vim.o.splitright = true

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Live substitution
vim.o.inccommand = "nosplit"

-- Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- Shift/Tab widths
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true

-- Better completion
vim.o.completeopt = "menuone,noselect"

-- Use terminal colours
vim.o.termguicolors = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300
