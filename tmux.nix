with builtins;
let
  attrsToConfig = setting: config:
  (f: attrs: map (name: f name attrs.${name})
  (attrNames attrs))
  (name: value: "set -g ${setting}-" + name + " " + value)
  config;

  status = {
    bg = "black";
    position = "top";
    justify = "left";
    right = "' #[bg=white]  %H:%M %a '";
  };

  window = {
    status-format = "'#[fg=white] #I #W '";
    status-current-format = "'#[bg=white,fg=black] #I #W '";
  };

  pane = rec {
    border-style = "fg=black,bg=default";
    active-border-style = border-style;
  };

  statusString = concatStringsSep "\n"(attrsToConfig "status" status);
  windowString = concatStringsSep "\n"(attrsToConfig "window" window);
  paneString = concatStringsSep "\n"(attrsToConfig "pane" pane);
in
''
  ${statusString}
  ${windowString}
  ${paneString}

  bind \\ split-window -h
  bind - split-window
''
