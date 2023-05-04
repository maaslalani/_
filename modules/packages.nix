{pkgs, ...}: let
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
    age
    alejandra
    awscli2
    bore-cli
    bundix
    cachix
    chafa
    circumflex
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
    imagemagick
    kitty
    libwebp
    llvm
    lolcat
    lsix
    nil
    nixpkgs-fmt
    nushell
    openssl
    optipng
    pandoc
    postgresql
    redis
    revive
    rm-improved
    rustup
    sc-im
    simple-http-server
    spotify-tui
    spotifyd
    tree-sitter
    ttyd
    twurl
    yarn
    yq
  ];

  linux = [];

  charmbracelet = with pkgs; [
    charm
    # gum
    melt
    skate
    soft-serve
    # vhs
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
