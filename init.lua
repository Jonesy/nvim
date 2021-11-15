-- General
require("settings")
require("mappings")

-- Plugins
require("plugins")
require("colorizer").setup()

-- LSP
require("treesitter")
require("lsp-config")
require("completion")
require("lspkind").init()
require("lspsaga").init_lsp_saga()
-- require "lsp-install"
-- require "nvim-dap"

-- ColorsScheme
require("themes/dracula")
