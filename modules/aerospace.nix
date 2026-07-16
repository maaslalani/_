{lib, ...}: let
  open = app: "exec-and-forget open -a '${app}'";
  mkApp = workspace: {inherit workspace;};
  mkLauncher = workspace: key: name: (mkApp workspace) // {inherit key name;};

  apps = {
    "com.microsoft.Outlook" = mkApp "M";
    "com.hnc.Discord" = mkApp "D";

    "com.tinyspeck.slackmacgap" = mkLauncher "S" "q" "Slack.app";
    # w
    "com.apple.mobilesafari" = mkLauncher "E" "e" "Safari.app";
    "com.mitchellh.ghostty" = mkLauncher "G" "r" "Ghostty.app" // {floating = true;};
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
      lib.nameValuePair "alt-${app.key}" (open app.name))
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
