# Nix Configuration
This repository contains my dotfiles which are managed through [Nix](https://nixos.org/) and [home-manager](https://github.com/rycee/home-manager).

![Home Setup](../assets/alacritty.png?raw=true)

## Setup
* Editor: [neovim](./modules/vim.nix)
* Shell: [zsh](./modules/zsh.nix)
* Terminal Emulator: [alacritty](./modules/alacritty.nix)
* Terminal multiplexer: [tmux](./modules/tmux.nix)

## Packages
All the packages I have installed are listed in [packages.nix](./modules/packages.nix).

My favourites include:
* [bat](https://github.com/sharkdp/bat)
* [fd](https://github.com/sharkdp/fd)
* [ffmpeg](https://ffmpeg.org/)
* [fzf](https://github.com/junegunn/fzf)
* [ripgrep](https://github.com/BurntSushi/ripgrep)
* [entr](https://github.com/eradman/entr)

## Plugins
### Neovim
![Neovim Setup](../assets/vim.png?raw=true)
* [auto-pairs](https://github.com/jiangmiao/auto-pairs)
* [colorbuddy](https://github.com/tjdevries/colorbuddy.nvim)
* [commentary](https://github.com/tpope/vim-commentary)
* [neogit](https://github.com/TimUntersberger/neogit)
* [nordbuddy](https://github.com/maaslalani/nordbuddy)
* [nvim-telescope](https://github.com/nvim-telescope/telescope.nvim)
* [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
