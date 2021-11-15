vim.cmd [[packadd packer.nvim]]
local packer = require("packer")
local use = packer.use

return packer.startup(
  function()
    -- Package Manager
    use "wbthomason/packer.nvim"

    -- Colors
    use "simrat39/symbols-outline.nvim"
    use "norcalli/nvim-colorizer.lua"

    -- Language Server Protocol
    use "nvim-treesitter/nvim-treesitter"   -- Nvim Treesitter configurations and abstraction layer
    use "neovim/nvim-lspconfig"             -- Quickstart configurations for the Nvim LSP client
    use "williamboman/nvim-lsp-installer"   -- Seamlessly install LSP servers locally with :LspInstall.
    use "hrsh7th/cmp-nvim-lsp"              -- A completion plugin for neovim coded in Lua.
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/nvim-cmp"
    use "onsails/lspkind-nvim"              -- vscode-like pictograms for neovim lsp completion items
    use "sbdchd/neoformat"                  -- A (Neo)vim plugin for formatting code.
    -- use "glepnir/lspsaga.nvim"              -- Neovim lsp plugin
    use "tami5/lspsaga.nvim"                -- when issue solved, uncomment above OG plugin, using temporary
    use "mfussenegger/nvim-dap"             -- Debug Adapter Protocol client implementation for Neovim (>= 0.5)
    use {
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      config = function()
        require("gitsigns").setup()
      end
    }                                       -- Super fast git decorations implemented purely in lua/teal.
    use "akinsho/nvim-bufferline.lua"       -- A snazzy bufferline for Neovim
    use {
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true}
    }                                       -- statusline plugin written in pure lua & icons  
    use "alvan/vim-closetag"                -- Auto close (X)HTML tags
    use { "iamcco/markdown-preview.nvim",
          run="cd app & npm install"}       -- markdown preview plugin for (neo)vim

    -- Editing
    use {
      "windwp/nvim-autopairs",
      event = "BufRead",
      config = function()
        require("nvim-autopairs").setup({})
      end
    }                                       -- autopairs for neovim written by lua
    use "tpope/vim-repeat"
    use "tpope/vim-surround"

    -- Snippets
    use "L3MON4D3/LuaSnip"                  -- Snippet Engine for Neovim written in Lua.
    use "hrsh7th/vim-vsnip"                 -- Snippet plugin for vim/nvim that supports LSP/VSCode's snippet format.Snippet plugin for vim/nvim that supports LSP/VSCode's snippet format.
    use "rafamadriz/friendly-snippets"      -- Set of preconfigured snippets for different languages.

    -- Theme
    use "Mofiqul/dracula.nvim"
  end
)
