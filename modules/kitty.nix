{ config, pkgs, libs, ... }:
{
  programs.kitty = {
    enable = true;
    settings = {
      enable_audio_bell = false;
      copy_on_select = true;

      remember_window_size = false;
      initial_window_width = 680;
      initial_window_height = 720;
      window_border_width = 1;
      window_margin_width = 0;
      single_window_margin_width = 0;
      window_padding_width = 8;

      active_border_color = "#686868";
      inactive_border_color = "#4A4A4A";

      tab_bar_margin_width = 1;
      tab_bar_style = "separator";
      tab_separator = " │ ";

      active_tab_foreground = "#e6e6e6";
      active_tab_background = "#3a3a3a";
      active_tab_font_style = "normal";
      inactive_tab_foreground = "#bfbfbf";
      inactive_tab_background = "#171717";
      inactive_tab_font_style = "normal";

      allow_remote_control = true;

      macos_titlebar_color = "background";
      macos_option_as_alt = "left";
      macos_quit_when_last_window_closed = true;
      macos_traditional_fullscreen = true;
      macos_show_window_title_in = "none";

      selection_foreground = "#222222";
      selection_background = "#ccff00";

      foreground = "#dddddd";
      background = "#171717";

      # black
      color0 = "#000000";
      color8 = "#4d4d4d";

      # red
      color1 = "#c73b1d";
      color9 = "#e82100";

      # green
      color2 = "#00a800";
      color10 = "#00db00";

      # yellow
      color3 = "#acaf15";
      color11 = "#e5e900";

      # blue
      color4 = "#3854FC";
      color12 = "#566BF9";

      # magenta
      color5 = "#d533ce";
      color13 = "#e83ae9";

      # cyan
      color6 = "#2cbac9";
      color14 = "#00e6e7";

      # white
      color7 = "#bfbfbf";
      color15 = "#e6e6e6";

      font_family = "Hack Nerd Font Mono";
      italic_font = "Hack Nerd Font Mono Italic";
      bold_font = "Hack Nerd Font Mono Bold";
      bold_italic_font = "Hack Nerd Font Mono Bold Italic";
    };
  };
}
