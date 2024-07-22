local status, trouble = pcall(require, "trouble")
if not status then
  return
end

trouble.setup({
  auto_close = true,
})

vim.keymap.set(
  "n",
  "<leader>xx",
  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  { desc = "Toggle Trouble buffer issues" }
)
vim.keymap.set(
  "n",
  "<leader>cl",
  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  { desc = "LSP Definitions / references / ... (Trouble)" }
)

vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Toggle Trouble workspace issues" })
