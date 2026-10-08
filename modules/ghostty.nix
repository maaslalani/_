{
  colors,
  config,
  lib,
  pkgs,
  ...
}: let
  dotfiles = "${config.home.homeDirectory}/_";
in {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;

    settings = {
      keybind = [
        "ctrl+super+f=toggle_fullscreen"
        "super+t=unbind"
        "super+d=unbind"
        "super+shift+d=unbind"
      ];
      # Explicit top-level colors would override both themes, so the custom
      # palette lives in the `dark` theme below and follows the macOS appearance.
      theme = "light:GitHub Light Default,dark:dark";
      window-theme = "system";

      font-size = 14;
      font-family = "JetBrains Mono";
      mouse-hide-while-typing = true;

      window-decoration = "none";
      macos-icon = "xray";
      macos-option-as-alt = true;
      title = "Terminal";

      window-padding-x = 12;
      window-padding-y = 12;

      shell-integration-features = "no-cursor";
      unfocused-split-opacity = 1;
      split-divider-color = colors.normal.black;

      working-directory = dotfiles;

      command = "${pkgs.herdr}/bin/herdr";
    };

    themes.dark = {
      background = colors.primary.background;
      foreground = colors.primary.foreground;
      palette = lib.imap0 (i: hex: "${toString i}=${hex}") colors.palette;
    };
  };
}
