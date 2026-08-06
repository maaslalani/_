{lib, ...}: let
  open = id: "exec-and-forget open -b '${id}'";

  # Communication
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
  devin = "com.exafunction.windsurf";
  devinInsiders = "com.exafunction.windsurfInsiders";

  # Productivity
  calendar = "com.apple.iCal";
  linear = "com.linear";
  notion = "notion.id";
  numbers = "com.apple.iWork.Numbers";
  finder = "com.apple.finder";
  skim = "net.sourceforge.skim-app.skim";

  workspaces = {
    "#" = slack;
    "=" = numbers;
    "B" = chrome;
    "C" = calendar;
    "D" = [devinInsiders devin];
    "L" = linear;
    "M" = mail;
    "N" = notion;
    "S" = slack;
    "T" = [ghostty skim];
    "V" = vscode;
    "Z" = zoom;
  };

  launch = {
    "alt-a" = chrome;
    "alt-r" = chrome;
    "alt-s" = slack;
    "alt-t" = ghostty;

    "alt-b" = chrome;
    "alt-c" = calendar;
    "alt-w" = devinInsiders;
    "alt-v" = vscode;
    "alt-f" = finder;
    "alt-l" = linear;
    "alt-m" = messages;
    "alt-n" = notion;
    "alt-equal" = numbers;
    "alt-p" = skim;
  };

  floating = [ghostty finder];

  monitors = {
    "1" = "Built-in Retina Display";
    "2" = "LG HDR 4K";
  };

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

  bindings =
    lib.mapAttrs (_: open) launch
    // lib.mergeAttrsList (lib.mapAttrsToList (key: monitor: {
      "alt-${key}" = "focus-monitor '${monitor}'";
      "alt-shift-${key}" = "move-workspace-to-monitor '${monitor}'";
    }) monitors);
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
