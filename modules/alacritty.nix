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
        normal.black = "0x15161E";
        normal.red = "0xf7768e";
        normal.green = "0x9ece6a";
        normal.yellow = "0xe0af68";
        normal.blue = "0x7aa2f7";
        normal.magenta = "0xbb9af7";
        normal.cyan = "0x7dcfff";
        normal.white = "0xa9b1d6";

        bright.black = "0x414868";
        bright.red = "0xf7768e";
        bright.green = "0x9ece6a";
        bright.yellow = "0xe0af68";
        bright.blue = "0x7aa2f7";
        bright.magenta = "0xbb9af7";
        bright.cyan = "0x7dcfff";
        bright.white = "0xc0caf5";

        primary.background = "0x1a1b26";
        primary.foreground = "0xc0caf5";
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
