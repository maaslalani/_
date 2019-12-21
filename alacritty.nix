{
  window = {
    dimensions = {
      columns = 0;
      lines = 0;
    };

    padding = {
      x = 0;
      y = 0;
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
    size = 15;
    use_thin_strokes = true;
  };

  tabspaces = 4;

  draw_bold_text_with_bright_colors = false;
  colors = {
    primary = {
      background = "0x2E3440";
      foreground = "0xD8DEE9";
    };

    normal = {
      black = "0x3B4252";
      red = "0xBF616A";
      green = "0xA3BE8C";
      yellow = "0xEBCB8B";
      blue = "0x81A1C1";
      magenta = "0xB48EAD";
      cyan = "0x88C0D0";
      white = "0xE5E9F0";
    };

    bright = {
      black = "0x4C566A";
      red = "0xBF616A";
      green = "0xA3BE8C";
      yellow = "0xEBCB8B";
      blue = "0x81A1C1";
      magenta = "0xB48EAD";
      cyan = "0x8FBCBB";
      white = "0xECEFF4";
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
}
