# Nix Configuration
This repository contains my dotfiles which are managed through [Nix](https://nixos.org/) and [home-manager](https://github.com/rycee/home-manager).

![Home Setup](../assets/alacritty.png?raw=true)

## Setup
* Editor: [neovim](./editor/vim.nix)
* Shell: [zsh](./shell/zsh.nix)
* Terminal Emulator: [alacritty](./terminal/alacritty.nix)
* Terminal multiplexer: [tmux](./terminal/tmux.nix)
* Operating System: [darwin](./darwin.nix)

## Packages
All the packages I have installed are listed in [pkgs.nix](./pkgs.nix).

My favourites include:
* [bat](https://github.com/sharkdp/bat)
* [fd](https://github.com/sharkdp/fd)
* [ffmpeg](https://ffmpeg.org/)
* [fzf](https://github.com/junegunn/fzf)
* [ripgrep](https://github.com/BurntSushi/ripgrep)

## Plugins
### Neovim
![Vim Setup](../assets/vim.png?raw=true)
* [auto-pairs](https://github.com/jiangmiao/auto-pairs)
* [commentary](https://github.com/tpope/vim-commentary)
* [fugitive](https://github.com/tpope/vim-fugitive)
* [fzf-vim](https://github.com/junegunn/fzf.vim)
* [nord-vim](https://github.com/arcticicestudio/nord-vim)
* [polyglot](https://github.com/sheerun/vim-polyglot)
