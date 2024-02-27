local fb_actions = require("telescope").extensions.file_browser.actions

local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end
local actions = require("telescope.actions")
-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "file_browser")
local builtin = require("telescope.builtin")

local keymap = vim.keymap.set
local function telescope_buffer_dir()
  return vim.fn.expand("%:p:h")
end

telescope.setup({
  hidden = true,
  defaults = {
    mappings = {
      n = {
        ["<CR>"] = actions.select_default,
        ["<C-n>"] = telescope.extensions.file_browser.actions.create,
        ["q"] = actions.close,
      },
      i = {
        ["<CR>"] = actions.select_default,
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})
-- Keymaps
keymap("n", "<leader>ff", builtin.find_files, {})
keymap("n", "<leader>e", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_git_ignore = false,
    hidden = true,
    grouped = true,
    previewer = true,
    initial_mode = "normal",
    layout_config = { height = 40 },
  })
end, {})
keymap("n", "<leader>fg", builtin.live_grep, {})
keymap("n", "<leader>fs", builtin.lsp_document_symbols, {})
keymap("n", "<leader>bb", builtin.buffers, {})
keymap("n", "<leader>fh", builtin.help_tags, {})
keymap("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
keymap("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
keymap("n", "<leader>fw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
keymap("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
keymap("n", "<leader>fb", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })
