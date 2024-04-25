local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- LSP
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      -- "williamboman/mason.nvim",
      -- "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", tag = "legacy", opts = {} },

      -- Helpful dev tools for NeoVim
      {
        "folke/neodev.nvim",
        config = function()
          require("neodev").setup()
        end,
      },
    },
  },
  {
    "stevearc/conform.nvim",
  },
  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = (function()
          if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
            return
          end
          return "make install_jsregexp"
        end)(),
      },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
  },
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
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
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  -- Source Control
  { "lewis6991/gitsigns.nvim" },
  -- Statusline
  {
    "echasnovski/mini.statusline",
    version = "*",
    config = function()
      require("mini.statusline").setup()
    end,
  },
  -- Tooling
  -- TODO: Figure out how to set auto_focus on hover docs
  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      {
        "lvimuser/lsp-inlayhints.nvim",
        opts = {},
      },
    },
    ft = { "rust" },
    config = function()
      vim.g.rustaceanvim = {
        inlay_hints = {
          highlight = "NonText",
        },
        tools = {
          hover_actions = {
            auto_focus = true,
          },
        },
        server = {
          on_attach = function(client, bufnr)
            require("lsp-inlayhints").on_attach(client, bufnr)
          end,
        },
      }
    end,
  },
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    -- Probably don't need this in Nix
    -- build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        lsp_inlay_hints = {
          enable = true,
        },
      })
    end,
  },
  -- Editing
  {
    "echasnovski/mini.ai",
    version = "*",
    config = function()
      require("mini.ai").setup()
    end,
  },
  {
    "echasnovski/mini.pairs",
    version = "*",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "echasnovski/mini.surround",
    version = "*",
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "echasnovski/mini.comment",
    version = "*",
    config = function()
      require("mini.comment").setup({
        mappings = {
          comment = "<leader>/",
          comment_line = "<leader>/",
          comment_visual = "<leader>/",
        },
      })
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
    end,
  },
  -- Theme
  {
    "jaredgorski/spacecamp",
    config = function()
      vim.cmd("colorscheme spacecamp")
    end,
  },
  -- {
  --   "mcchrish/zenbones.nvim",
  --   dependencies = { "rktjmp/lush.nvim" },
  --   config = function()
  --     vim.cmd("colorscheme duckbones")
  --   end,
  -- },
  -- {
  --   "xero/miasma.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.cmd("colorscheme miasma")
  --   end,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme("catppuccin-macchiato")
  --   end,
  -- },
}, {
  git = {
    url_format = "git@github.com:%s.git",
  },
})
