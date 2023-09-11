{pkgs, ...}: let
  core = with pkgs;
    [
      entr
      fd
      git
      gnupg
      jq
      lsd
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
    deno
    docker
    fennel
    ffmpeg_5
    fzf
    git
    git-lfs
    go
    go-swagger
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
    monitorcontrol
    nil
    nixpkgs-fmt
    nodejs
    nushell
    openssl
    optipng
    pandoc
    postgresql
    python311Packages.grip
    redis
    revive
    rm-improved
    rustup
    sc-im
    simple-http-server
    spotify-tui
    spotifyd
    tree-sitter
    twurl
    yarn
    yq
    zig
  ];

  linux = [];

  charmbracelet = with pkgs; [
    # gum
    # vhs
    charm
    melt
    pop
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
