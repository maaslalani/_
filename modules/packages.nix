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
    act
    age
    alejandra
    awscli2
    bore-cli
    bun
    cachix
    coreutils
    docker
    elmPackages.elm
    ffmpeg_5
    fzf
    git-lfs
    go_1_21
    helix-gpt
    htop
    imagemagick
    libwebp
    lolcat
    lsd
    monitorcontrol
    nilaway
    nodejs
    ollama
    openssl
    optipng
    redis
    rustup
    skhd
    watch
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
    # mods
    # soft-serve
    # vhs
    charm
    melt
    pop
    skate
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
