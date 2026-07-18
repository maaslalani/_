{lib, ...}: let
  open = id: "exec-and-forget open -b '${id}'";

  mail = "com.apple.mail";
  discord = "com.hnc.Discord";
  slack = "com.tinyspeck.slackmacgap";
  safari = "com.apple.Safari";
  ghostty = "com.mitchellh.ghostty";

  workspaces = {
    "M" = mail;
    "D" = discord;
    "#" = slack;
    "S" = safari;
    "T" = ghostty;
  };

  launch = {
    "alt-r" = slack;
    "alt-s" = safari;
    "alt-t" = ghostty;
  };

  floating = [ghostty];

  onWindowDetected =
    lib.mapAttrsToList (workspace: id: {
      "if".app-id = id;
      run =
        ["move-node-to-workspace '${workspace}'"]
        ++ lib.optional (builtins.elem id floating) "layout floating";
    })
    workspaces;

  bindings = lib.mapAttrs (_: id: open id) launch;
in {
  xdg.enable = true;

  programs.aerospace = {
    enable = true;
    launchd.enable = true;

    settings = {
      config-version = 2;

      key-mapping.preset = "colemak";

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
