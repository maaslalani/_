{ config, pkgs, lib, ... }:
let
  core = with pkgs; [
    entr
    exa
    fd
    git
    gnupg
    jq
    ripgrep
    sd
    sops
  ] ++ (import ./lsp.nix { pkgs = pkgs; });

  darwin = with pkgs; [
    cachix
    clang
    coreutils
    delve
    fennel
    ffmpeg
    git
    google-cloud-sdk
    graph-easy
    graphviz
    hammerspoon
    htop
    kubectl
    nodejs-16_x
    noti
    openssl
    pandoc
    pinentry
    pinentry_mac
    rename
    rustup
    sc-im
    sops
    spotify-tui
    spotifyd
    terraform
    yarn
  ];

  linux = [ ];
in
{
  home.packages = core ++
    (if pkgs.stdenv.isDarwin then darwin else linux);

  programs.bat.config.theme = "Nord";
  programs.bat.enable = true;
  programs.home-manager.enable = true;
  programs.taskwarrior.colorTheme = "dark-16";
  programs.taskwarrior.enable = true;
  programs.z-lua.enable = true;
}
