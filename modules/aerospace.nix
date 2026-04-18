{lib, ...}: let
  open = app: "exec-and-forget open -a '${app}'";

  appWorkspaces = {
    "com.microsoft.Outlook" = "M";
    "com.microsoft.teams2" = "T";
    "com.microsoft.edgemac" = "E";
    "com.mitchellh.ghostty" = "G";
    "com.hnc.Discord" = "D";
    "com.tinyspeck.slackmacgap" = "S";
  };

  onWindowDetected =
    lib.mapAttrsToList (appId: ws: {
      "if".app-id = appId;
      run =
        ["move-node-to-workspace ${ws}"]
        ++ lib.optional (appId == "com.mitchellh.ghostty") "layout floating";
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
      key-mapping.preset = "colemak";
      gaps = {
        inner.horizontal = 0;
        inner.vertical = 0;
        outer.left = 0;
        outer.bottom = 0;
        outer.top = 0;
        outer.right = 0;
      };
      mode.main.binding = {
        cmd-alt-m = open "Microsoft Outlook.app";
        cmd-alt-c = open "Microsoft Teams.app";
        cmd-alt-s = open "Microsoft Edge.app";
        cmd-alt-t = open "Ghostty.app";
        cmd-alt-p = open "Skim.app";

        cmd-alt-d = open "Discord.app";
      };
    };
  };
}
