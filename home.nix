{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.coreutils
    pkgs.errcheck
    pkgs.exa
    pkgs.fd
    pkgs.ffmpeg
    pkgs.fortune
    pkgs.git
    pkgs.gnupg
    pkgs.go
    pkgs.golint
    pkgs.htop
    pkgs.pass
    pkgs.ripgrep
    pkgs.rustup
    pkgs.sd
    pkgs.sops
    pkgs.spotify-tui
    pkgs.tree
    pkgs.yarn
  ];

  programs.alacritty = import ./alacritty.nix;
  programs.bat = import ./bat.nix;
  programs.fzf = import ./fzf.nix;
  programs.git = import ./git.nix;
  programs.neovim = import ./vim.nix { pkgs = pkgs; };
  programs.tmux = import ./tmux.nix;
  programs.zsh = import ./zsh.nix { pkgs = pkgs; };
}
