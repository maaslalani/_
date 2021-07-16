{ config, pkgs, lib, ... }:
{
  programs.bat.config.theme = "Nord";
  programs.bat.enable = true;
  programs.home-manager.enable = true;
  programs.taskwarrior.colorTheme = "dark-16";
  programs.taskwarrior.enable = true;
  programs.z-lua.enable = true;

  home.packages = with pkgs; [
    browsh
    cachix
    coreutils
    delve
    docker
    entr
    exa
    fd
    fennel
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
    openssl
    pandoc
    ripgrep
    rustup
    sd
    skhd
    sops
    spotify-tui
    terraform
    tree
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
