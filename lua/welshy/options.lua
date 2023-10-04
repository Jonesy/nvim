-- Leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- highlight on search
vim.o.hlsearch = false

-- UTF8
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
vim.wo.signcolumn = "yes"
vim.o.colorcolumn = "9999" -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59

-- Splits
vim.o.splitbelow = true -- Force all horizontal splits to go below current window
vim.o.splitright = true -- Force all vertical splits to go to the right of current window

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "nosplit" -- Live substitution

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
