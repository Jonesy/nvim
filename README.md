# My NeoVim config from scratch

1. Set up options, like tabs, copy/paste, etc
2. Set up basic keybindings that are plugin independant
3. Install Lazy.vim and colour scheme
   Make sure you install git in nixos config.
4. Install Treesitter
   Make sure you read the docs and install a C compiler first
   This is done by adding `gcc` to compiler
5. Install LSPs
   - This could be done better than how I have set it up, but not sure I want all my config in nix yet.
   - Basically I install the LSP via Nix packages, instead of using Mason, but I want to integrate it tighter
   - Nix adds the command to your path, so you can install the bare minimum LSPs (lua and nix) and lean on flakes to sandbox the actual language servers as needed
   - Wire up formatters, we'll make sure first we can format using native LSP, then set up formatting for:
     - [ ] CSS
     - [x] TypeScript/JavaScript (prettierd most likely)
     - [x] Stylua
     - [ ] OCaml
     - [ ] HTML
     - [x] Format on save
   - I may need at add additional diagnostics for CSS/HTML
6. Install Telescope and other productive plugins
   - Make sure make or cmake is installed


#### NOTES:

When setting up Lua, just lua_ls and stylua seem to be all I need.
Since I am going to be using NixShell, I plan to only have the LSPs and formatters on my system
