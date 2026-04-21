{
  config,
  pkgs,
  ...
}: let
  colors = {
    primary = {
      background = "#0D1116";
      foreground = "#C5C8C6";
    };

    normal = {
      black = "#282a2e";
      red = "#D74E6F";
      green = "#31BB71";
      yellow = "#D3E561";
      blue = "#8056FF";
      magenta = "#ED61D7";
      cyan = "#04D7D7";
      white = "#C5C8C6";
    };

    bright = {
      black = "#4B4B4B";
      red = "#FE5F86";
      green = "#00D787";
      yellow = "#EBFF71";
      blue = "#8F69FF";
      magenta = "#FF7AEA";
      cyan = "#00FEFE";
      white = "#FFFFFF";
    };
  };

  palette = with colors; [
    normal.black
    normal.red
    normal.green
    normal.yellow
    normal.blue
    normal.magenta
    normal.cyan
    normal.white
    bright.black
    bright.red
    bright.green
    bright.yellow
    bright.blue
    bright.magenta
    bright.cyan
    bright.white
  ];
in {
  programs.ghostty = {
    enable = true;
    package =
      if pkgs.stdenv.isDarwin
      then pkgs.ghostty-bin
      else pkgs.ghostty;

    enableZshIntegration = true;

    settings = {
      keybind = [
        "ctrl+super+f=toggle_fullscreen"
        # "ctrl+a>ctrl+a=text:\\x01"
        # "ctrl+a>c=new_tab"
        # "ctrl+a>n=next_tab"
        # "ctrl+a>p=previous_tab"
        # "ctrl+a>x=close_surface"
        # "ctrl+a>-=new_split:down"
        # "ctrl+a>'=new_split:right"
        # "ctrl+a>|=new_split:right"
        # "ctrl+a>h=goto_split:left"
        # "ctrl+a>j=goto_split:down"
        # "ctrl+a>k=goto_split:up"
        # "ctrl+a>l=goto_split:right"
      ];
      background = colors.primary.background;
      foreground = colors.primary.foreground;

      palette = builtins.genList (i: "${toString i}=${builtins.elemAt palette i}") (builtins.length palette);

      font-size = 16;
      font-family = "JetBrains Mono";
      mouse-hide-while-typing = true;

      macos-titlebar-style = "tabs";

      window-padding-x = 16;
      window-padding-y = 16;

      shell-integration-features = "no-cursor";
      cursor-style = "block";

      unfocused-split-opacity = 1;
      split-divider-color = colors.normal.black;

      window-inherit-working-directory = true;
      working-directory = "${config.home.homeDirectory}/_";

      command = "${pkgs.tmux}/bin/tmux new-session -A -s Dotfiles -c ${config.home.homeDirectory}/_";
    };
  };
}
