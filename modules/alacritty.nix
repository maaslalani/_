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
          x = 6;
          y = 6;
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
        normal.black = "0x000000";
        bright.black = "0x4D4D4D";

        normal.blue = "0x3854FC";
        bright.blue = "0x566BF9";

        normal.cyan = "0x2CBAC9";
        bright.cyan = "0x00E6E7";

        normal.green = "0x00A800";
        bright.green = "0x00DB00";

        normal.magenta = "0xD533CE";
        bright.magenta = "0xE83AE9";

        normal.red = "0xC73B1D";
        bright.red = "0xE82100";

        normal.white = "0xBFBFBF";
        bright.white = "0xE6E6E6";

        normal.yellow = "0xACAF15";
        bright.yellow = "0xE5E900";

        primary.background = "0x171717";
        primary.foreground = "0xDDDDDD";
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

      shell = {
        program = "${pkgs.tmux}/bin/tmux";
        args = [
          "new-session"
          "-A"
          "-D"
          "-s"
          "default"
        ];
      };
    };
  };
}
