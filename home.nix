{ config, pkgs, ... }:
{
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
    pkgs.kubectl
    pkgs.nodejs
    pkgs.pass
    pkgs.ripgrep
    pkgs.rustup
    pkgs.sd
    pkgs.sops
    pkgs.spotify-tui
    pkgs.tree
    pkgs.yarn
  ];

  programs.home-manager.enable = true;
  programs.alacritty = import ./terminal/alacritty.nix;
  programs.bat = import ./programs/bat.nix;
  programs.fzf = import ./programs/fzf.nix;
  programs.git = import ./programs/git.nix;
  programs.neovim = import ./editor/vim.nix { pkgs = pkgs; };
  programs.tmux = import ./terminal/tmux.nix;
  programs.zsh = import ./shell/zsh.nix { pkgs = pkgs; };
}
