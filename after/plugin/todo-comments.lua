local status, todo_comments = pcall(require, "todo-comments")

if not status then
  return
end

vim.keymap.set("n", "<leader>t", ":TodoQuickFix<CR>", { desc = "Show TODO QuickFix window" })
vim.keymap.set("n", "<leader>tt", ":TodoTelescope<CR>", { desc = "Show TODO TodoTelescope" })

vim.keymap.set("n", "<leader>tt", function()
  todo_comments.jump_next()
end, { desc = "Next TODO comment" })

vim.keymap.set("n", "<leader>tt", function()
  todo_comments.jump_prev()
end, { desc = "Previous TODO comment" })
