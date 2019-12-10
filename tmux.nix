let

  status = {
    bg = "black";
    position = "top";
    justify = "left";
    right = "' #[bg=white]  %H:%M %a '";
  };

  window = {
    status-format = "#[fg=white] #I #W ";
    status-current-format = "#[bg=white,fg=black] #I #W ";
  };

  pane = rec {
    border-style = "fg=black,bg=default";
    active-border-style = border-style;
  };

  attrsToConfig = setting: config:
    (f: attrs: map (name: f name attrs.${name})
    (builtins.attrNames attrs))
    (name: value: "set -g ${setting}-" + name + " " + value)
    config;

  statusString = builtins.concatStringsSep "\n"(attrsToConfig "status" status);
  windowString = builtins.concatStringsSep "\n"(attrsToConfig "window" window);
  paneString = builtins.concatStringsSep "\n"(attrsToConfig "pane" pane);

in
  ''
    ${statusString}
    ${windowString}
    ${paneString}

    bind \\ split-window -h
    bind - split-window
  ''
