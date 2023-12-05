{pkgs, ...}: let
  colors = import ./colors.nix;
in {
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      copy_on_select = true;

      macos_traditional_fullscreen = true;
      remember_window_size = true;
      initial_window_width = 680;
      initial_window_height = 720;
      window_border_width = 1;
      window_margin_width = 0;
      single_window_margin_width = 0;
      window_padding_width =
        if pkgs.stdenv.isDarwin
        then 20
        else 8;

      active_border_color = "#282a2e";
      inactive_border_color = "#c5c8c6";

      tab_bar_margin_width = 1;
      tab_bar_style = "separator";
      tab_separator = " │ ";

      active_tab_foreground = "#5f819d";
      active_tab_background = "#1d1f21";
      active_tab_font_style = "normal";
      inactive_tab_foreground = "#c5c8c6";
      inactive_tab_background = "#1d1f21";
      inactive_tab_font_style = "normal";

      adjust_line_height = "100%";

      allow_remote_control = true;

      cursor_blink_interval = 0;

      shell = "zsh";

      macos_titlebar_color = "background";
      macos_option_as_alt = "left";
      macos_quit_when_last_window_closed = true;
      macos_show_window_title_in = "none";

      background = "#171717";
      foreground = "#c5c8c6";

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
    };

    environment = {
      DEMO = if pkgs.stdenv.isDarwin then "true" else "false";
    };

    shellIntegration.enableZshIntegration = true;
    keybindings = {
      "cmd+w" = "no_op";
      "cmd+t" = "no_op";
      "cmd+enter" = "no_op";
    };

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 16;
    };
  };
}
