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
    docker
    errcheck
    exa
    fd
    ffmpeg
    git
    glow
    gnupg
    go
    google-cloud-sdk
    htop
    jq
    kubectl
    nodejs
    pass
    ripgrep
    rustup
    sd
    sops
    tree
    vault
    yarn
  ] ++ (
    with pkgs; with pkgs.nodePackages; [
      rnix-lsp
      bash-language-server
      solargraph
      dockerfile-language-server-nodejs
      typescript
      typescript-language-server
      gopls
    ]
  );
}
