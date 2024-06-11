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
    crystal
    delta
    deno
    docker
    elvish
    ffmpeg_5
    fish
    fzf
    git
    git-lfs
    gnupg
    go
    htop
    imagemagick
    kbt
    librsvg
    libwebp
    lolcat
    lsd
    monitorcontrol
    nodejs
    ollama
    openssl
    optipng
    postgresql
    python312Packages.grip
    python312Packages.west
    redis
    rustup
    skhd
    tree-sitter
    ttyd
    typioca
    unixtools.script
    watch
    watchexec
    yabai
    yq
    z-lua
    zig
  ];

  linux = with pkgs; [
    brave
    brightnessctl
    dunst
    gcc
    go
    mpv
    networkmanager
    pavucontrol
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
