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
    errcheck
    exa
    fd
    ffmpeg
    fira-code
    git
    gnupg
    go
    google-cloud-sdk
    graphviz
    htop
    jq
    kubectl
    mosh
    ninja
    nodejs
    pandoc
    pass
    ripgrep
    rustup
    sd
    skhd
    sops
    terraform
    texlive.combined.scheme-medium
    tree
    vault
    watch
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
      typescript
      typescript-language-server
    ]
  );
}
