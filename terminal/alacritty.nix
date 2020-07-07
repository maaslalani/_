{
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

      dynamic_padding = false;
      decorations = "full";

      startup_mode = "Maximized";
    };

    scrolling = {
      history = 10000;
      multiplier = 3;
      faux_multiplier = 3;
      auto_scroll = false;
    };

    font = {
      normal = {
        family = "Fira Code";
        style = "Regular";
      };
      bold = {
        family = "Fira Code";
        style = "Regular";
      };
      italic = {
        family = "Fira Code";
        style = "Italic";
      };
      size = 15;
      use_thin_strokes = true;
    };

    tabspaces = 4;

    draw_bold_text_with_bright_colors = false;

    colors = {
      primary = {
        background = "0x282828";
        foreground = "0xebdbb2";
      };

      normal = {
        black =   "0x282828";
        red =     "0xcc241d";
        green =   "0x98971a";
        yellow =  "0xd79921";
        blue =    "0x458588";
        magenta = "0xb16286";
        cyan =    "0x689d6a";
        white =   "0xa89984";
      };

      bright = {
        black =   "0x928374";
        red =     "0xfb4934";
        green =   "0xb8bb26";
        yellow =  "0xfabd2f";
        blue =    "0x83a598";
        magenta = "0xd3869b";
        cyan =    "0x8ec07c";
        white =   "0xebdbb2";
      };
    };

    visual_bell = {
      animation = "EaseOutExpo";
      duration = 0;
      color = "0xffffff";
    };

    background_opacity = 1.0;

    mouse = {
      hide_when_typing = true;
    };

    cursor = {
      style = "Block";
    };

    live_config_reload = true;

    alt_send_esc = false;
  };
}
