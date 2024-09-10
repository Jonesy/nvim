# NeoVim Config

NeoVim from the desk of Joshua Jones.

## Installation

This configuration has been tested and heavily used on MacOS and Linux systems,
so all requirements and instructions will assume as such.

```sh
$ mv ~/.config/nvim ~/.config/nvim.bak
$ rm -rf )
```

```sh
$ git clone git@github.com:Jonesy/nvim.git ~/.config/nvim
$ cd ~/.config/nvim
$ nvim
```

Launching NeoVim will install plugins via [Lazy](https://www.lazyvim.org/).

## Design

This config strives to strike a balance of minimalism and productivity, and is
the result of 15 years and going of programming in Vim. It has a slight bent
towards web development, primarily frontend-based, but also supports:

- Zig
- Lua
- Go & Templ (basic)
- Nix
- Swift
- PHP
- Bash
- and many others to come.

It works great for me, but your mileage may vary. My main motivation in sharing
publicly is educational reference.

[NeoVim Kickstart](https://github.com/nvim-lua/kickstart.nvim) was a valuable
resource in helping build the stable, minimalist foundation.

### Plugins

Plugins are managed following the file-based system, so `lua/core/lazy.lua` will
crawl the `lua/plugins` directory for files that return a Lazy-formatted table.

### Language Servers + Nix - Mason

This config is shared between a MacOS and Nix-based Linux workstation, and I've
found Nix devshells do a wonderful job of replacing Mason, so it is only enabled
on MacOS systems, and will likely be removed entirely if I end up installing
[Nix-Darwin](https://github.com/LnL7/nix-darwin) on my MacBook Pro. Mason is a
terrific plugin, but it's one less plugin and dependency that I need, and Nix
provides the added benefit of containerized LSP servers locked to specific
versions.

## Planned improvements

- [ ] Go projects tooling [x-ray](https://github.com/ray-x/go.nvim)
- [ ] Rust project tooling [Rustacean](https://github.com/mrcjkb/rustaceanvim)
- [ ] Investigate [Lua FZF](https://github.com/ibhagwan/fzf-lua)
