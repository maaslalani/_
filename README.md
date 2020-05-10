# Nix Configuration
This repository contains my dotfiles which are managed through [Nix](https://nixos.org/) and [home-manager](https://github.com/rycee/home-manager).

![Home Setup](../assets/alacritty.png?raw=true)

## Setup
* Editor: [neovim](./vim.nix)
* Shell: [zsh](./zsh.nix)
* Terminal Emulator: [alacritty](./alacritty.nix)
* Terminal multiplexer: [tmux](./tmux.nix)
* Operating System: [darwin](./darwin.nix)

## Packages
All the packages I use are listed in [home.nix](./home.nix) inside `home.packages`.

My favourites include:
* [bat](https://github.com/sharkdp/bat)
* [exa](https://github.com/ogham/exa)
* [fd](https://github.com/sharkdp/fd)
* [pandoc](https://github.com/jgm/pandoc)
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [starship](https://github.com/starship/starship)
* [z-lua](https://github.com/skywind3000/z.lua)

## Plugins
### Neovim
![Vim Setup](../assets/vim.png?raw=true)
* [commentary](https://github.com/tpope/vim-commentary)
* [fugitive](https://github.com/tpope/vim-fugitive)
* [fzf-vim](https://github.com/junegunn/fzf.vim)
* [nerdtree](https://github.com/preservim/nerdtree)
* [nord-vim](https://github.com/arcticicestudio/nord-vim)
* [polyglot](https://github.com/sheerun/vim-polyglot)
* [supertab](https://github.com/ervandew/supertab)
* [vim-go](https://github.com/fatih/vim-go)

### Zsh
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
