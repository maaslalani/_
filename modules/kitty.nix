{
  config,
  pkgs,
  libs,
  ...
}: let
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
      window_border_width = 1;
      window_margin_width = 0;
      single_window_margin_width = 0;
      window_padding_width = 8;

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

      adjust_line_height = "120%";
      allow_remote_control = true;
      cursor_blink_interval = 0;

      macos_titlebar_color = "background";
      macos_option_as_alt = "left";
      macos_quit_when_last_window_closed = true;
      macos_show_window_title_in = "none";

      font_family = "SF Mono Medium";
      italic_font = "SF Mono Medium Italic";
      bold_font = "SF Mono Heavy";
      bold_italic_font = "SF Mono Heavy Italic";
      font_size = "15.0";

      selection_foreground = "none";
      selection_background = "#707880";

      background = "#171717";
      foreground = "#c5c8c6";

      color0 = "#282a2e"; # black
      color8 = "#4d4d4d"; # bright black
      color1 = "#D74E6F"; # red
      color9 = "#FE5F86"; # bright red
      color2 = "#31BB71"; # green
      color10 = "#00D787"; # bright green
      color3 = "#D3E561"; # yellow
      color11 = "#EBFF71"; # bright yellow
      color4 = "#8056FF"; # blue
      color12 = "#8F69FF"; # bright blue
      color5 = "#ED61D7"; # magenta
      color13 = "#FF7AEA"; # bright magenta
      color6 = "#04D7D7"; # cyan
      color14 = "#00FEFE"; # bright cyan
    };
    keybindings = {
      "cmd+w" = "no_op";
      "cmd+t" = "no_op";
      "cmd+enter" = "no_op";
    };
  };
}
