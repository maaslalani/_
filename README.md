# Nix Configuration
This repository contains my dotfiles which are managed through [Nix](https://nixos.org/) and [home-manager](https://github.com/rycee/home-manager).

![]()

## Setup
Editor: [neovim](./vim.nix)
Shell: [zsh](./zsh.nix)
Terminal Emulator: [alacritty](./alacritty.nix)
Terminal Multiplexor: [tmux](./tmux.nix)

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
![]()

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
