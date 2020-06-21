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
* [fd](https://github.com/sharkdp/fd)
* [ffmpeg](https://ffmpeg.org/)
* [fzf](https://github.com/junegunn/fzf)
* [ripgrep](https://github.com/BurntSushi/ripgrep)

## Plugins
### Neovim
![Vim Setup](../assets/vim.png?raw=true)
* [ale](https://github.com/dense-analysis/ale)
* [auto-pairs](https://github.com/jiangmiao/auto-pairs)
* [coc-nvim](https://github.com/neoclide/coc.nvim)
* [commentary](https://github.com/tpope/vim-commentary)
* [fugitive](https://github.com/tpope/vim-fugitive)
* [fzf-vim](https://github.com/junegunn/fzf.vim)
* [nord-vim](https://github.com/arcticicestudio/nord-vim)
* [polyglot](https://github.com/sheerun/vim-polyglot)
* [supertab](https://github.com/ervandew/supertab)
* [vim-dirvish](https://github.com/justinmk/vim-dirvish)
* [vim-go](https://github.com/fatih/vim-go)
