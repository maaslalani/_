{ config, pkgs, libs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        dimensions = {
          columns = 0;
          lines = 0;
        };

        padding = {
          x = 10;
          y = 10;
        };

        decorations = "full";
        dynamic_padding = false;
        startup_mode = "Maximized";
      };

      scrolling = {
        history = 100000;
        multiplier = 3;
      };

      font = {
        normal.family = "Hack Nerd Font Mono";
        bold.style = "Bold";
        italic.style = "Italic";
        normal.style = "Regular";
        size = 18.5;
      };

      colors = {
        bright.black = "0x4C566A";
        bright.blue = "0x81A1C1";
        bright.cyan = "0x8FBCBB";
        bright.green = "0xA3BE8C";
        bright.magenta = "0xB48EAD";
        bright.red = "0xBF616A";
        bright.white = "0xECEFF4";
        bright.yellow = "0xEBCB8B";

        normal.black = "0x3B4252";
        normal.blue = "0x81A1C1";
        normal.cyan = "0x88C0D0";
        normal.green = "0xA3BE8C";
        normal.magenta = "0xB48EAD";
        normal.red = "0xBF616A";
        normal.white = "0xE5E9F0";
        normal.yellow = "0xEBCB8B";

        primary.background = "0x2E3440";
        primary.foreground = "0xD8DEE9";
      };

      bell = {
        animation = "EaseOutExpo";
        color = "0xffffff";
        duration = 0;
      };

      mouse = {
        hide_when_typing = true;
      };

      cursor = {
        style = "Block";
      };

      alt_send_esc = false;
      background_opacity = 1.0;
      draw_bold_text_with_bright_colors = false;
      live_config_reload = true;
    };
  };
}
