with builtins;
let
  attrsToConfig = attrs: concatStringsSep "\n" (attrsToSettings attrs);
  attrsToSettings = attrs: attrValues (mapAttrs (attrToSetting) attrs);
  attrToSetting = name: value: "set -g ${name} ${value}";

  settings = {
    default-terminal = "'xterm-256color'";
    status-style = "bg=black";
    status-right-style = "bg=brightblack,fg=white";
    status-justify = "left";
    status-right = "'  %H:%M  '";
    status-left = "''";
    pane-border-style = "fg=black,bg=default";
    pane-active-border-style = "fg=black,bg=default";
    mouse = "on";
  };

  window = {
    window-status-style = "fg=white,bg=colour0";
    window-status-current-style = "fg=cyan,bg=brightblack";
    window-status-current-format = "' #I:#W '";
    window-status-format = "' #I:#W '";
  };

  message = {
    message-command-style = "fg=white,bg=colour0";
    message-style = "fg=cyan,bg=colour0";
    mode-style = "fg=cyan,bg=colour0";
  };

  splits = {
    vertical = "|";
    horiztonal = "-";
  };
in
''
  ${attrsToConfig settings}
  ${attrsToConfig window}
  ${attrsToConfig message}

  bind ${splits.vertical} split-window -h -c "#{pane_current_path}"
  bind ${splits.horiztonal} split-window -c "#{pane_current_path}"
  bind c new-window -c "#{pane_current_path}"
''
