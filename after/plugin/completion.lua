-- local ok, cmp = pcall(require, "cmp")
-- if not ok then
--   return
-- end
-- local lsOk, luasnip = pcall(require, "luasnip")
-- if not lsOk then
--   return
-- end
-- -- luasnip.loaders.from_vscode.lazy_load()
-- luasnip.config.setup({})
--
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--   completion = { completeopt = "menu,menuone,noinsert" },
--   mapping = cmp.mapping.preset.insert({
--     ["<C-j>"] = cmp.mapping.select_next_item(),
--     ["<C-k>"] = cmp.mapping.select_prev_item(),
--     ["<C-d>"] = cmp.mapping.scroll_docs(-4),
--     ["<C-f>"] = cmp.mapping.scroll_docs(4),
--     ["<C-Space>"] = cmp.mapping.complete({}),
--     ["<C-y>"] = cmp.mapping.confirm({
--       -- behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     }),
--     ["<C-l>"] = cmp.mapping(function()
--       if luasnip.expand_or_locally_jumpable() then
--         luasnip.expand_or_jump()
--       end
--     end, { "i", "s" }),
--     ["<C-h>"] = cmp.mapping(function()
--       if luasnip.locally_jumpable(-1) then
--         luasnip.jump(-1)
--       end
--     end, { "i", "s" }),
--   }),
--   sources = {
--     -- { name = "nvim_lsp" },
--     { name = "luasnip" },
--     { name = "path" },
--     -- { name = "nvim_buf" },
--     -- { name = "nvim_file" },
--   },
-- })
