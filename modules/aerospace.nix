{lib, ...}: let
  open = id: "exec-and-forget open -b '${id}'";

  # Communication
  discord = "com.hnc.Discord";
  slack = "com.tinyspeck.slackmacgap";
  messages = "com.apple.MobileSMS";
  mail = "com.apple.mail";
  zoom = "us.zoom.xos";

  # Browsers
  safari = "com.apple.Safari";
  chrome = "com.google.Chrome";
  firefox = "org.mozilla.firefox";
  arc = "company.thebrowser.Browser";

  # Terminals & editors
  ghostty = "com.mitchellh.ghostty";
  terminal = "com.apple.Terminal";
  vscode = "com.microsoft.VSCode";

  # Productivity
  notes = "com.apple.Notes";
  calendar = "com.apple.iCal";
  notion = "notion.id";
  numbers = "com.apple.iWork.Numbers";
  finder = "com.apple.finder";

  # Media
  music = "com.apple.Music";
  spotify = "com.spotify.client";

  workspaces = {
    "M" = mail;
    "D" = discord;
    "#" = slack;
    "S" = safari;
    "T" = ghostty;
    "C" = calendar;
    "N" = numbers;
    "P" = spotify;
    "V" = vscode;
    "Z" = zoom;
  };

  launch = {
    "alt-r" = slack;
    "alt-s" = safari;
    "alt-t" = ghostty;
    "alt-c" = calendar;
    "alt-d" = discord;
    "alt-v" = vscode;
    "alt-f" = finder;
    "alt-m" = messages;
    "alt-n" = numbers;
  };

  floating = [ghostty finder];

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
