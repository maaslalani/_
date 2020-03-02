# Nix Configuration
This repository contains my dotfiles which are managed through [Nix](https://nixos.org/) and [home-manager](https://github.com/rycee/home-manager).

![Home Setup](../assets/alacritty.png?raw=true)

## Setup
* Editor: [neovim](./vim.nix)
* Shell: [zsh](./zsh.nix)
* Terminal Emulator: [alacritty](./alacritty.nix)
* Terminal multiplexer: [tmux](./tmux.nix)

## Packages
All the packages I use are listed in [home.nix](./home.nix) inside `home.packages`.

My favourites include:
``` 
bat
exa
fd
pandoc
ripgrep
starship
z-lua
```

## Plugins
### Neovim
![Vim Setup](../assets/vim.png?raw=true)

```
coc-nvim
commentary
fugitive
fzf-vim
nerdtree
nord-vim
polyglot
supertab
vim-go
```

### Zsh
![]()

```
zsh-autosuggestions
zsh-syntax-highlighting
```
