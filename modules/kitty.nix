{
  colors,
  lib,
  ...
}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      size = 20;
    };
    settings =
      {
        background = "#000000";
        foreground = colors.primary.foreground;
        window_padding_width = 24;
        macos_titlebar_color = "background";
        macos_show_window_title_in = "none";
        remember_window_position = true;
      }
      // lib.listToAttrs (lib.imap0 (i: lib.nameValuePair "color${toString i}") colors.palette);
  };
}
