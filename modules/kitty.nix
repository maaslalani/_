{
  colors,
  lib,
  ...
}: let
  ansi = ["black" "red" "green" "yellow" "blue" "magenta" "cyan" "white"];
  paletteColors = lib.attrVals ansi colors.normal ++ lib.attrVals ansi colors.bright;
in {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 20;
    };
    settings =
      {
        background = colors.primary.background;
        foreground = colors.primary.foreground;
        window_padding_width = 24;
        macos_titlebar_color = "background";
        macos_show_window_title_in = "none";
        remember_window_position = true;
      }
      // builtins.listToAttrs (lib.imap0 (i: hex: {
          name = "color${toString i}";
          value = hex;
        })
        paletteColors);
  };
}
