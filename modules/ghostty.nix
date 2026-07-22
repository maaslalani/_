{
  colors,
  config,
  lib,
  pkgs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/_";
  notes = "${config.home.homeDirectory}/icloud/Documents/notes";

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

    enableZshIntegration = false;

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

      font-size = 14;
      font-family = "JetBrains Mono";
      mouse-hide-while-typing = true;

      window-decoration = "none";
      macos-icon = "xray";
      title = "Terminal";

      window-padding-x = 12;
      window-padding-y = 12;

      shell-integration-features = "no-cursor";
      cursor-style = "block";

      unfocused-split-opacity = 1;
      split-divider-color = colors.normal.black;

      window-inherit-working-directory = true;
      working-directory = dotfiles;

      command = "${pkgs.tmux}/bin/tmux new-session -A -d -s Notes -c ${notes} ';' new-session -A -s Dotfiles -c ${dotfiles}";
    };
  };
}
