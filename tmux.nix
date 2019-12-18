with builtins;
let
  settings = concatStringsSep "\n" (attrValues (mapAttrs (name: value: "set -g ${name} ${value}") {
    default-terminal = "'tmux-256color-italic'";
    status-style = "bg=black";
    status-position = "bottom";
    status-justify = "left";
    status-right-style = "bg=white,fg=black";
    status-right = "'  %H:%M %a '";
    pane-border-style = "fg=black,bg=default";
    pane-active-border-style = "fg=black,bg=default";
    window-status-style = "bg=black,fg=white";
    window-status-current-style = "fg=black,bg=white";
    window-status-format = "' #I #W '";
    window-status-current-format = "' #I #W '";
  }));

  splits = {
    vertical = "\\";
    horiztonal = "-";
  };
in
''
  ${settings}

  bind ${splits.vertical} split-window -h
  bind ${splits.horiztonal} split-window

  bind -n C-p send-keys Up
  bind -n C-n send-keys Down

  set -as terminal-overrides ',xterm*:Tc:sitm=\E[3m'
''
