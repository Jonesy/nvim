# NeoVim Config

The minimal years.

#### Goals

- minimal config, native-first approach, especially plugin-manager
- use least amount of bells and whistles (plugins)
- use nix for plugins on linux
- Try to keep it all to 1 or just a couple files

## First steps

I start by just setting up all the global options, which for my purposes are
generally found in `vim.g`, `vim.o` and vim.wo`, for global, options and window
options. Generally you find these settings to contain heavily commented notes
about the setting and why it is on/off, etc. I decided to leave these mainly
blank, not necessarily to dissuade other's copying and pasting, but moreso to
force myself and anyone using my config to intentionally lookup what the setting
actually does. I am eternally grateful for all the amazing configs I've found
over the years that have helped me become a competent NeoVim user, but I find
myself at a point where I would really like to fully understand my entire
environment and how it works so I can hone its functionality even tighter to my personal workflow.

Keymaps is another one that is pretty self-explanitory from reading each remap,
though here I like to group each remap by what it does with some heading
comments.

### Plugins

I switched to `vim.pack` for native plugin handling.

It's easy but there are little implementation details I found I needed to be
aware of. Overall being aware that `PackChanged` events don't run on install,
because Lua is a scripting language, you can just run post-install hooks simply
after the import is declared.

##### Treesitter

This is important: In `0.12` make sure you assign `nvim-treesitter` and
`nvim-treesitter-textobjects` to `version = "main"`. Requiring in the `main`
branch is slightly different, `require("nvim-treesitter")` instead of
`require("nvim-treesitter.configs")`.

##### Mini

Super easy, just add and require.

##### LSP

This part is more involved and will likely require more configuration
involvement. Main layout looks like this:

```lua
vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup()

vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", { ... })

-- keymaps
kset("n", "gd", vim.lsp.buf.definition, noremap_opts)
kset("n", "grt", vim.lsp.buf.type_definition, noremap_opts)
kset("n", "rn", vim.lsp.buf.rename, noremap_opts)
```

