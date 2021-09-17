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
    crystal
    delve
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
    hammerspoon
    htop
    jq
    kubectl
    nodejs
    openssl
    pandoc
    ripgrep
    rustup
    sd
    sops
    spotify-tui
    terraform
    tree
    yarn
  ] ++ (
    with pkgs; with pkgs.nodePackages; [
      bash-language-server
      dockerfile-language-server-nodejs
      gopls
      rnix-lsp
      scry
      serve
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
