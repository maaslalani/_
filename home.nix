{ config, pkgs, ... }: {
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.chafa
    pkgs.coreutils
    pkgs.errcheck
    pkgs.exa
    pkgs.fd
    pkgs.ffmpeg
    pkgs.fortune
    pkgs.git
    pkgs.glow
    pkgs.gnupg
    pkgs.go
    pkgs.golint
    pkgs.google-cloud-sdk
    pkgs.htop
    pkgs.jq
    pkgs.kubectl
    pkgs.kubectx
    pkgs.nodejs
    pkgs.pass
    pkgs.ripgrep
    pkgs.rustup
    pkgs.sd
    pkgs.sops
    pkgs.spotify-tui
    pkgs.tree
    pkgs.watchexec
    pkgs.yarn
  ];

  programs.alacritty = import ./terminal/alacritty.nix;
  programs.bat       = import ./programs/bat.nix;
  programs.fzf       = import ./programs/fzf.nix;
  programs.git       = import ./programs/git.nix;
  programs.tmux      = import ./terminal/tmux.nix;

  programs.neovim    = import ./editor/vim.nix { pkgs = pkgs; };
  programs.zsh       = import ./shell/zsh.nix  { pkgs = pkgs; };
}
