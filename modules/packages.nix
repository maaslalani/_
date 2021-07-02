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
    docker
    entr
    exa
    fd
    ffmpeg
    git
    gnupg
    go
    google-cloud-sdk
    graph-easy
    graphviz
    htop
    imgcat
    jq
    kubectl
    mosh
    ninja
    nodejs
    pandoc
    ripgrep
    rustup
    sd
    skhd
    sops
    spotify-tui
    spotifyd
    terraform
    tree
    vault
    yabai
    yarn
  ] ++ (
    with pkgs; with pkgs.nodePackages; [
      bash-language-server
      dockerfile-language-server-nodejs
      gopls
      rnix-lsp
      solargraph
      terraform-ls
      texlab
      texlive.combined.scheme-medium
      typescript
      typescript-language-server
      yaml-language-server
    ]
  );
}
