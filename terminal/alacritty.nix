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
    };

    font = {
      normal.family = "Hack";
      bold.family   = "Hack";
      italic.family = "Hack";

      normal.style  = "Regular";
      bold.style    = "Medium";
      italic.style  = "Italic";

      size = 15.5;
    };

    draw_bold_text_with_bright_colors = false;

    colors = {
      primary.background = "0x2E3440";
      primary.foreground = "0xD8DEE9";

      normal.black   = "0x3B4252";
      normal.red     = "0xBF616A";
      normal.green   = "0xA3BE8C";
      normal.yellow  = "0xEBCB8B";
      normal.blue    = "0x81A1C1";
      normal.magenta = "0xB48EAD";
      normal.cyan    = "0x88C0D0";
      normal.white   = "0xE5E9F0";

      bright.black   = "0x4C566A";
      bright.red     = "0xBF616A";
      bright.green   = "0xA3BE8C";
      bright.yellow  = "0xEBCB8B";
      bright.blue    = "0x81A1C1";
      bright.magenta = "0xB48EAD";
      bright.cyan    = "0x8FBCBB";
      bright.white   = "0xECEFF4";
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
