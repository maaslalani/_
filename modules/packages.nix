{ config, pkgs, lib, ... }:
{
  programs.bat.enable = true;
  programs.home-manager.enable = true;
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
    gopls
    htop
    jq
    kubectl
    nodejs
    pass
    ripgrep
    rnix-lsp
    rustup
    solargraph
    sops
    tree
    vault
    yarn
  ] ++ (with pkgs.nodePackages; [
    bash-language-server
    dockerfile-language-server-nodejs
    typescript
    typescript-language-server
  ]);
}
