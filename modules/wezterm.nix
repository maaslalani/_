let
  colors = import ./colors.nix;
  normal = colors.normal;
  bright = colors.bright;
in {
  programs.wezterm = {
    enable = true;

    colorSchemes = {
      charm = {
        ansi = [normal.black normal.red normal.green normal.yellow normal.blue normal.magenta normal.cyan normal.white];
        brights = [bright.black bright.red bright.green bright.yellow bright.blue bright.magenta bright.cyan bright.white];
        background = colors.background;
        foreground = colors.foreground;
        cursor_bg = normal.white;
        cursor_fg = normal.black;
        selection_fg = "none";
        selection_bg = "#707880";
      };
    };

    extraConfig = ''
      return {
        window_frame = {
          active_titlebar_bg = '#171717',
          font = wezterm.font { family = 'JetBrains Mono' },
        },
        colors = {
          tab_bar = {
            background = '${colors.background}',
            active_tab = {
              bg_color = '${colors.background}',
              fg_color = '${normal.white}',
            },
            inactive_tab = {
              bg_color = '${colors.background}',
              fg_color = '${bright.black}',
            },
          },
        },
        keys = {
          {
            key = 'f',
            mods = 'CTRL|CMD',
            action = wezterm.action.ToggleFullScreen,
          }
        },
        window_decorations = "RESIZE",
        font = wezterm.font("JetBrains Mono"),
        font_size = 16.0,
        color_scheme = "charm",
        use_fancy_tab_bar = false,
        tab_bar_at_bottom = true,
        show_new_tab_button_in_tab_bar = false,
        hide_tab_bar_if_only_one_tab = true,
        default_prog = { "zsh", "-c", "tmux new -DAs default" },
        window_close_confirmation = "NeverPrompt",
      }
    '';
  };
}
