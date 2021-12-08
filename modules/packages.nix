{ config, pkgs, lib, ... }:
{
  programs.bat.config.theme = "Nord";
  programs.bat.enable = true;
  programs.home-manager.enable = true;
  programs.taskwarrior.colorTheme = "dark-16";
  programs.taskwarrior.enable = true;
  programs.z-lua.enable = true;

  home.packages = with pkgs; (import ./core.nix { pkgs = pkgs; }) ++ [
    cachix
    coreutils
    delve
    fennel
    ffmpeg
    git
    gnupg
    google-cloud-sdk
    graph-easy
    graphviz
    hammerspoon
    htop
    kubectl
    noti
    openssl
    pandoc
    pinentry
    pinentry_mac
    rename
    rustup
    sops
    spotify-tui
    spotifyd
    terraform
    yarn
  ];
}
