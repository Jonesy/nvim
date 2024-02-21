-- All global, plugin free keymaps go here
local keymap = vim.keymap.set
local noremap_opts = { silent = true, noremap = true }

keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- [ Buffers ]
keymap("n", "<Space>bn", ":bnext<CR>", noremap_opts)
keymap("n", "<Space>bp", ":bprevious<CR>", noremap_opts)

-- [ Windows ]
-- Splitting
keymap("n", "_", ":split<CR>", noremap_opts)
keymap("n", "|", ":vsplit<CR>", noremap_opts)
-- Window navigation
keymap("n", "<C-h>", "<C-w>h", noremap_opts)
keymap("n", "<C-l>", "<C-w>l", noremap_opts)
keymap("n", "<C-j>", "<C-w>j", noremap_opts)
keymap("n", "<C-k>", "<C-w>k", noremap_opts)
-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", noremap_opts)
keymap("n", "<C-Down>", ":resize -2<CR>", noremap_opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", noremap_opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", noremap_opts)

-- [[ Editing ]]
-- +/- inc/dec
keymap("n", "+", "<C-a>")
keymap("n", "-", "<C-x>")
-- Moving lines up/down
keymap("v", "<C-j>", ":move '>+1<CR>gv-gv", noremap_opts)
keymap("v", "<C-k>", ":move '<-2<CR>gv-gv", noremap_opts)

-- Better pasting (doesn't swap the clipboard contents with what you replaced)
keymap("v", "p", '"_dP', noremap_opts)

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})
