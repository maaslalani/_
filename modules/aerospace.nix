{lib, ...}: let
  open = id: "exec-and-forget open -b '${id}'";

  # Communication
  slack = "com.tinyspeck.slackmacgap";
  messages = "com.apple.MobileSMS";
  mail = "com.apple.mail";
  zoom = "us.zoom.xos";

  # Browsers
  chrome = "com.google.Chrome";

  # Terminals & editors
  ghostty = "com.mitchellh.ghostty";
  kitty = "net.kovidgoyal.kitty";
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

  floating = [ghostty finder kitty];

  monitors = {
    "1" = "Built-in Retina Display";
    "2" = "Studio Display";
  };

  rule = id: run: {
    "if".app-id = id;
    inherit run;
  };
  floatingRun = id: lib.optional (builtins.elem id floating) "layout floating";
  workspaceApps = lib.concatMap lib.toList (lib.attrValues workspaces);

  onWindowDetected =
    lib.concatLists (
      lib.mapAttrsToList (workspace: ids:
        map (id: rule id (["move-node-to-workspace '${workspace}'"] ++ floatingRun id)) (lib.toList ids))
      workspaces
    )
    ++ map (id: rule id ["layout floating"]) (lib.subtractLists workspaceApps floating);

  bindings =
    lib.mapAttrs (_: open) launch
    // {"alt-y" = "exec-and-forget ~/.nix-profile/bin/stamp \"$(/usr/bin/pbpaste)\"";}
    // lib.mergeAttrsList (lib.mapAttrsToList (key: monitor: {
        "alt-${key}" = "focus-monitor '${monitor}'";
        "alt-shift-${key}" = "move-workspace-to-monitor '${monitor}'";
      })
      monitors);
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
