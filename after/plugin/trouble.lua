local status, trouble = pcall(require, "trouble")
if not status then
  return
end

trouble.setup({
  auto_close = true,
})

vim.keymap.set("n", "<leader>xx", ":TroubleToggle<CR>", { desc = "Toggle Trouble buffer issues" })
vim.keymap.set(
  "n",
  "<leader>xw",
  ":TroubleToggle workspace_diagnostics<CR>",
  { desc = "Toggle Trouble workspace issues" }
)
