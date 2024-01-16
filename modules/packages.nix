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
    cachix
    coreutils
    elmPackages.elm
    elmPackages.elm-format
    elmPackages.elm-live
    elmPackages.elm-review
    ffmpeg_5
    fzf
    git-lfs
    go_1_21
    htop
    imagemagick
    libwebp
    lolcat
    monitorcontrol
    nodejs
    openssl
    optipng
    redis
    rustup
    skhd
    yabai
    yq
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
    # soft-serve
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
