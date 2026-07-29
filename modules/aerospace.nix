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

  # Terminals & editors
  ghostty = "com.mitchellh.ghostty";
  vscode = "com.microsoft.VSCode";

  # Productivity
  calendar = "com.apple.iCal";
  notion = "notion.id";
  numbers = "com.apple.iWork.Numbers";
  finder = "com.apple.finder";
  skim = "net.sourceforge.skim-app.skim";

  workspaces = {
    "#" = slack;
    "=" = numbers;
    "B" = chrome;
    "C" = calendar;
    "D" = discord;
    "M" = mail;
    "N" = notion;
    "S" = safari;
    "T" = [ghostty skim];
    "V" = vscode;
    "Z" = zoom;
  };

  launch = {
    "alt-r" = slack;
    "alt-s" = safari;
    "alt-b" = chrome;
    "alt-t" = ghostty;
    "alt-c" = calendar;
    "alt-d" = discord;
    "alt-v" = vscode;
    "alt-f" = finder;
    "alt-m" = messages;
    "alt-n" = notion;
    "alt-equal" = numbers;
    "alt-p" = skim;
  };

  floating = [ghostty finder];

  onWindowDetected = lib.concatLists (
    lib.mapAttrsToList (workspace: ids:
      map (id: {
        "if".app-id = id;
        run =
          ["move-node-to-workspace '${workspace}'"]
          ++ lib.optional (builtins.elem id floating) "layout floating";
      })
      (lib.toList ids))
    workspaces
  );

  bindings = lib.mapAttrs (_: open) launch;
in {
  programs.aerospace = {
    enable = true;
    launchd.enable = true;

    settings = {
      config-version = 2;

      key-mapping.preset = "colemak";

      on-window-detected = onWindowDetected;

      mode.main.binding = bindings;
    };
  };
}
