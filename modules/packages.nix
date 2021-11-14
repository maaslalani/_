{ config, pkgs, lib, ... }:
{
  programs.bat.config.theme = "Nord";
  programs.bat.enable = true;
  programs.home-manager.enable = true;
  programs.taskwarrior.colorTheme = "dark-16";
  programs.taskwarrior.enable = true;
  programs.z-lua.enable = true;

  home.packages = with pkgs; [
    cachix
    coreutils
    delve
    entr
    exa
    fd
    fennel
    ffmpeg
    git
    gnupg
    google-cloud-sdk
    graph-easy
    graphviz
    hammerspoon
    htop
    jq
    kubectl
    noti
    openssl
    pandoc
    rename
    rustup
    sd
    sops
    spotify-tui
    spotifyd
    terraform
    yarn
  ] ++ (
    with pkgs; with pkgs.nodePackages; [
      bash-language-server
      dockerfile-language-server-nodejs
      efm-langserver
      gopls
      rnix-lsp
      serve
      terraform-ls
      typescript
      typescript-language-server
      yaml-language-server
    ]
  );
}
