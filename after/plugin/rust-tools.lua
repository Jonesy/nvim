local status, rt = pcall(require, "rust-tools")
if not status then
  return
end

rt.setup()

vim.keymap.set("n", "<leader>rti", function()
  rt.inlay_hints.enable()
end, { silent = true, noremap = true, desc = "[RUST] Turn on inlay hints" })
