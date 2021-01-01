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
    entr
    errcheck
    exa
    fd
    ffmpeg
    git
    gitAndTools.gh
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
    terraform
    tree
    vault
    yarn
  ] ++ (
    with pkgs; with pkgs.nodePackages; [
      rnix-lsp
      bash-language-server
      dockerfile-language-server-nodejs
      gopls
      solargraph
      terraform-ls
      typescript
      typescript-language-server
    ]
  );
}
