{
  config,
  lib,
  pkgs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/_";

  colors = {
    primary = {
      background = "#0D1116";
      foreground = "#C5C8C6";
    };

    normal = {
      black = "#282a2e";
      red = "#D74E6F";
      green = "#31BB71";
      yellow = "#D3E561";
      blue = "#8056FF";
      magenta = "#ED61D7";
      cyan = "#04D7D7";
      white = "#C5C8C6";
    };

    bright = {
      black = "#4B4B4B";
      red = "#FE5F86";
      green = "#00D787";
      yellow = "#EBFF71";
      blue = "#8F69FF";
      magenta = "#FF7AEA";
      cyan = "#00FEFE";
      white = "#FFFFFF";
    };
  };

  # ANSI palette colors 0-15: normal (0-7) followed by bright (8-15).
  ansi = ["black" "red" "green" "yellow" "blue" "magenta" "cyan" "white"];
  paletteColors = lib.attrVals ansi colors.normal ++ lib.attrVals ansi colors.bright;
in {
  programs.ghostty = {
    enable = true;
    package =
      if pkgs.stdenv.isDarwin
      then pkgs.ghostty-bin
      else pkgs.ghostty;

    enableZshIntegration = true;

    settings = {
      keybind = [
        "ctrl+super+f=toggle_fullscreen"
        "super+t=unbind"
        "super+d=unbind"
        "super+shift+d=unbind"
      ];
      background = colors.primary.background;
      foreground = colors.primary.foreground;

      palette = lib.imap0 (i: hex: "${toString i}=${hex}") paletteColors;

      font-size = 16;
      font-family = "JetBrains Mono";
      mouse-hide-while-typing = true;

      macos-titlebar-style = "tabs";
      title = "Terminal";

      window-padding-x = 24;
      window-padding-y = 24;

      shell-integration-features = "no-cursor";
      cursor-style = "block";

      unfocused-split-opacity = 1;
      split-divider-color = colors.normal.black;

      window-inherit-working-directory = true;
      working-directory = dotfiles;

      command = "${pkgs.tmux}/bin/tmux new-session -A -s Dotfiles -c ${dotfiles}";
    };
  };
}
