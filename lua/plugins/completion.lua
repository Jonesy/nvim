return {
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function()
      local cmp = require("cmp")
      local auto_select = true
      return {
        auto_brackets = {}, -- configure any filetype to auto add brackets
        completion = {
          completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
        },
        preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,

        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete({}),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
        }),
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
      }
    end,
  },
  {
    "nvim-cmp",
    dependencies = {
      {
        "garymjr/nvim-snippets",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
          friendly_snippets = true,
        },
        keys = {
          {
            "<C-l>",
            function()
              if vim.snippet.active({ direction = 1 }) then
                vim.schedule(function()
                  vim.snippet.jump(1)
                end)
                return
              end
              return "<C-l>"
            end,
            expr = true,
            silent = true,
            mode = "i",
          },
          {
            "<C-h>",
            function()
              if vim.snippet.active({ direction = -1 }) then
                vim.schedule(function()
                  vim.snippet.jump(-1)
                end)
                return
              end
              return "<C-h>"
            end,
            expr = true,
            silent = true,
            mode = { "i", "s" },
          },
        },
      },
    },
    opts = function(_, opts)
      opts.snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
          table.insert(opts.sources, { name = "snippets" })
        end,
      }
    end,
  },
}
