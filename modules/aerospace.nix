{lib, ...}: let
  open = app: "exec-and-forget open -a '${app}'";
  mkApp = workspace: {inherit workspace;};
  mkLauncher = workspace: key: name: (mkApp workspace) // {inherit key name;};

  apps = {
    "com.microsoft.Outlook" = mkApp "M";
    "com.microsoft.teams2" = mkLauncher "T" "w" "Microsoft Teams.app" // {floating = true;};
    "com.microsoft.edgemac" = mkLauncher "E" "e" "Microsoft Edge.app";
    "com.mitchellh.ghostty" = mkLauncher "G" "r" "Ghostty.app" // {floating = true;};
    "com.tinyspeck.slackmacgap" = mkLauncher "S" "q" "Slack.app";
    "com.hnc.Discord" = mkApp "D";
    "com.github.githubapp" = mkLauncher "H" "t" "GitHub Copilot.app";

    "com.apple.Terminal" = mkLauncher "VT" "y" "Terminal.app";
    "dev.warp.Warp-Stable" = mkLauncher "W" "u" "Warp.app";
    "com.googlecode.iterm2" = mkLauncher "i" "i" "iTerm2.app";
    "org.alacritty" = mkLauncher "O" "o" "Alacritty.app";
    "com.github.wez.wezterm" = mkLauncher "P" "p" "WezTerm.app";
  };

  onWindowDetected =
    lib.mapAttrsToList (id: app: {
      "if".app-id = id;
      run =
        ["move-node-to-workspace ${app.workspace}"]
        ++ lib.optional (app.floating or false) "layout floating";
    })
    apps;

  bindings = builtins.listToAttrs (
    lib.mapAttrsToList (_: app:
      lib.nameValuePair "cmd-alt-${app.key}" (open app.name))
    (lib.filterAttrs (_: app: app ? key) apps)
  );
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
      mode.main.binding = bindings;
    };
  };
}
