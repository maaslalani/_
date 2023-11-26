{ pkgs, config, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      general = {
        gaps_in = 2;
        gaps_out = 3;
      };

      misc = {
        disable_hyprland_logo = true;
      };

      decoration = {
        rounding = 2;
      };

      animations = {
        enabled = false;
      };

      input = {
        kb_layout = "us";
        kb_variant = "colemak";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };

        kb_options = "ctrl:nocaps";
      };

      "$mod" = "SUPER";

      bind = [
        "$mod, Q, exec, kitty"
        "$mod, B, exec, brave"

        "$mod, W, killactive"

        "$mod, M, exit"
        "$mod, h, movefocus, l"
        "$mod, l, movefocus, r"
        "$mod, k, movefocus, u"
        "$mod, j, movefocus, d"
      ];
    };
  };
}
