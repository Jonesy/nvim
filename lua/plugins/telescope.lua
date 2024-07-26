return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Open default finder" },
      { "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Open default finder" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Search entire project via regex" },
      { "<leader>bb", "<cmd>Telescope buffers<cr>", desc = "Search all open buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
      { "<leader>fb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in current buffer" },
      { "<leader>ft", "<cm>TodoTelescope<cr>", desc = "Search all TODOs" },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
