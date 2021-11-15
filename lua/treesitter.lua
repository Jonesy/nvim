local ts = require("nvim-treesitter.configs")

ts.setup({
  autotag = {
    enable = true,
    filetypes = {
      "html",
      "javascript",
      "typescript",
      "markdown",
      "css",
      "scss",
      "graphql",
    },
  },
})