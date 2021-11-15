local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- Open neovim config
map("n", "<leader>,", ":e ~/.config/nvim/init.lua<CR>", opt)

-- Mappings to move lines
map("n", "<A-j>", ":m .+1<CR>", {noremap=true, silent=true})
map("n", "<A-k>", ":m .-2<CR>", {noremap=true, silent=true})
map("i", "<A-j>", ":m .+1<CR>", {noremap=true, silent=true})
map("i", "<A-k>", ":m .-2<CR>", {noremap=true, silent=true})
map("v", "<A-j>", ":m .+1<CR>", {noremap=true, silent=true})
map("v", "<A-k>", ":m .-2<CR>", {noremap=true, silent=true})

-- Use Ctrl+H,J,K,L to navigate panes
map("n", "<C-h>", "<C-w>h", {noremap=true, silent=true})
map("n", "<C-j>", "<C-w>j", {noremap=true, silent=true})
map("n", "<C-k>", "<C-w>k", {noremap=true, silent=true})
map("n", "<C-l>", "<C-w>l", {noremap=true, silent=true})

-- better indenting
map('v', '<', '<gv', {noremap = true, silent = true})
map('v', '>', '>gv', {noremap = true, silent = true})

-- Tabbing through buffers
map("n", "<C-Right>", ":bn<CR>")  -- Next buffer in list
map("n", "<C-Left>", ":bp<CR>")   -- Previous buffer in list
map("n", "<C-S-Left>", ":b#<CR>") -- Previous buffer you were in
