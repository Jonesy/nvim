-- General
require("user.options")
require("user.mappings")

require("user.lsp")
-- Plugins
require("user.plugin-manager")
-- require("colorizer").setup()
require("user.configs.cmp")
require("user.configs.telescope")
require("user.configs.treesitter")
require("user.configs.autopairs")
require("user.configs.comments")
require("user.configs.closetag")
require("user.configs.gitsigns")
require("user.configs.jabs")
require("user.configs.nvim-tree")
require("user.configs.bufferline")
require("user.configs.lualine")
-- require("user.configs.marks")
require("user.configs.project")
require("user.configs.neogit")

-- ColorsScheme
require("themes.dracula")
