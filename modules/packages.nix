{
  config,
  pkgs,
  lib,
  ...
}: let
  core = with pkgs;
    [
      entr
      exa
      fd
      git
      gnupg
      jq
      pastel
      ripgrep
      sd
    ]
    ++ (import ./lsp.nix {pkgs = pkgs;});

  darwin = with pkgs; [
    alejandra
    awscli2
    bundix
    cachix
    chafa
    coreutils
    cowsay
    delve
    fennel
    ffmpeg_5
    fzf
    git
    git-lfs
    go-swagger
    go_1_19
    gopass
    gopls
    hammerspoon
    htop
    python310Packages.grip
    lolcat
    lsix
    nixpkgs-fmt
    nodePackages.expo-cli
    nodejs-16_x
    openssl
    optipng
    pandoc
    pinentry_mac
    postgresql
    redis
    ruby_3_1
    rustup
    rm-improved
    sc-im
    spotify-tui
    spotifyd
    tree-sitter
    ttyd
    twurl
    yarn
  ];

  linux = [];

  charmbracelet = with pkgs; [
    charm
    melt
    skate
    soft-serve
  ];
in {
  home.packages =
    core
    ++ charmbracelet
    ++ (
      if pkgs.stdenv.isDarwin
      then darwin
      else linux
    );

  programs.bat.config.theme = "Nord";
  programs.bat.enable = true;
  programs.home-manager.enable = true;
  programs.taskwarrior.colorTheme = "dark-16";
  programs.taskwarrior.enable = true;
  programs.z-lua.enable = true;
}
