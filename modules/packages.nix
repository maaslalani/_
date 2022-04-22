{ config, pkgs, lib, ... }:
let
  core = with pkgs; [
    difftastic
    entr
    exa
    fd
    git
    gnupg
    jq
    ripgrep
    sd
  ] ++ (import ./lsp.nix { pkgs = pkgs; });

  darwin = with pkgs; [
    cachix
    coreutils
    delve
    fennel
    ffmpeg
    git
    gopls
    hammerspoon
    htop
    nodejs-16_x
    openssl
    pinentry_mac
    rustup
    sc-im
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
