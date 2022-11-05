{
  config,
  pkgs,
  libs,
  ...
}: let
  colors = import ./colors.nix;
in {
  programs.kitty = {
    enable = true;
    darwinLaunchOptions = ["tmux new -DAs default"];
    settings = {
      enable_audio_bell = false;
      copy_on_select = true;

      mouse_hide_wait = "3.0";

      macos_traditional_fullscreen = true;
      remember_window_size = true;
      initial_window_width = 680;
      initial_window_height = 720;
      window_border_width = 0;
      window_margin_width = 0;
      single_window_margin_width = 0;
      window_padding_width = 8;

      # adjust_line_height = "120%";
      allow_remote_control = true;
      cursor_blink_interval = 0;

      macos_titlebar_color = "background";
      macos_option_as_alt = "left";
      macos_quit_when_last_window_closed = true;
      macos_show_window_title_in = "none";
      confirm_os_window_close = 0;

      font_family = "JetBrains Mono";
      font_size = "16.0";

      selection_foreground = "none";
      selection_background = "#707880";

      background = colors.background;
      foreground = colors.foreground;

      color0 = colors.normal.black;
      color8 = colors.bright.black;

      color1 = colors.normal.red;
      color9 = colors.bright.red;

      color2 = colors.normal.green;
      color10 = colors.bright.green;

      color3 = colors.normal.yellow;
      color11 = colors.bright.yellow;

      color4 = colors.normal.blue;
      color12 = colors.bright.blue;

      color5 = colors.normal.magenta;
      color13 = colors.bright.magenta;

      color6 = colors.normal.cyan;
      color14 = colors.bright.cyan;

      color7 = colors.normal.white;
      color15 = colors.bright.white;
    };
    keybindings = {
      "cmd+w" = "no_op";
      "cmd+t" = "no_op";
      "cmd+enter" = "no_op";
    };
  };
}
