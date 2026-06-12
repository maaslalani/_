{lib, ...}: let
  open = app: "exec-and-forget open -a '${app}'";

  appWorkspaces = {
    "com.microsoft.Outlook" = "M";
    "com.microsoft.teams2" = "T";
    "com.microsoft.edgemac" = "E";
    "com.mitchellh.ghostty" = "G";
    "com.tinyspeck.slackmacgap" = "S";
    "com.hnc.Discord" = "D";
    "com.github.githubapp" = "H";

    "com.apple.Terminal" = "VT";
    "dev.warp.Warp-Stable" = "W";
    "com.googlecode.iterm2" = "i";
    "org.alacritty" = "O";
    "com.github.wez.wezterm" = "P";
  };

  onWindowDetected =
    lib.mapAttrsToList (appId: ws: {
      "if".app-id = appId;
      run =
        ["move-node-to-workspace ${ws}"]
        ++ lib.optional (lib.elem appId ["com.microsoft.teams2" "com.mitchellh.ghostty"]) "layout floating";
    })
    appWorkspaces;
in {
  xdg.enable = true;

  programs.aerospace = {
    enable = true;
    launchd.enable = true;

    settings = {
      after-startup-command = [];

      on-window-detected = onWindowDetected;

      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      gaps = {
        inner.horizontal = 0;
        inner.vertical = 0;
        outer.left = 0;
        outer.bottom = 0;
        outer.top = 0;
        outer.right = 0;
      };
      mode.main.binding = {
        cmd-alt-q = open "Slack.app";
        cmd-alt-w = open "Microsoft Teams.app";
        cmd-alt-e = open "Microsoft Edge.app";
        cmd-alt-r = open "Ghostty.app";
        cmd-alt-t = open "GitHub Copilot.app";

        cmd-alt-y = open "Terminal.app";
        cmd-alt-u = open "Warp.app";
        cmd-alt-i = open "iTerm2.app";
        cmd-alt-o = open "Alacritty.app";
        cmd-alt-p = open "WezTerm.app";
      };
    };
  };
}
