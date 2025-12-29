-- Colorscheme

return {
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd.colorscheme("eldritch")
    end,
  },
  {
    "zootedb0t/citruszest.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { style = "moon" },
  },
}
