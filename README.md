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
