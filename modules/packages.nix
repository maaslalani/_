{pkgs, ...}: let
  core = with pkgs;
    [
      eza
      fd
      jq
      pastel
      ripgrep
      sd
      sops
    ]
    ++ (import ./lsp.nix {pkgs = pkgs;});

  darwin = with pkgs; [
    age
    alejandra
    awscli2
    bore-cli
    btop
    bundix
    cachix
    chafa
    circumflex
    coreutils
    cowsay
    delve
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-live
    elmPackages.elm-review
    fennel
    ffmpeg_5
    fzf
    git-lfs
    go-swagger
    go_1_21
    gopass
    hammerspoon
    htop
    imagemagick
    libfido2
    libwebp
    llvm
    lolcat
    lsix
    monitorcontrol
    nodejs
    nushell
    openssl
    optipng
    pandoc
    postgresql
    python311Packages.grip
    redis
    rm-improved
    rustup
    sc-im
    simple-http-server
    spotify-tui
    spotifyd
    twurl
    yarn
    yq
    yubikey-manager
    zig
  ];

  linux = with pkgs; [
    brave
    brightnessctl
    dunst
    gcc
    go_1_21
    mpv
    networkmanager
    pavucontrol
    pinentry
    plasma-pa
    pulseaudioFull
    rofi-wayland
    sof-firmware
    waybar
    wl-clipboard
    xclip
    zathura
  ];

  charmbracelet = with pkgs; [
    # gum
    # vhs
    charm
    melt
    mods
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
