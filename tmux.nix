with builtins;
let
  bg = color: "bg=${color}";
  fg = color: "fg=${color}";

  colours = {
    default = "default";
    black = "black";
    white = "white";
    grey = "colour0";
    cyan = "cyan";
    bright.black = "brightblack";
  };

  attrsToConfig = attrs: concatStringsSep "\n" (attrsToSettings attrs);
  attrsToSettings = attrs: attrValues (mapAttrs (attrToSetting) attrs);
  attrToSetting = name: value: "set -g ${name} ${value}";

  settings = attrsToConfig (with colours; {
    default-terminal = "'xterm-256color'";

    status-style = bg black;
    status-right-style = "${bg bright.black},${fg white}";
    status-position = "bottom";
    status-justify = "left";
    status-right = "'  %H:%M  '";
    status-left = "''";

    pane-border-style = "${fg black},${bg default}";
    pane-active-border-style = "${fg black},${bg default}";
  });

  window = attrsToConfig (with colours; {
    window-status-style = "${fg white},${bg grey}";
    window-status-current-style = "${fg cyan},${bg bright.black}";
    window-status-current-format = "' #I:#W '";
    window-status-format = "' #I:#W '";
  });

  message = attrsToConfig (with colours; {
    message-command-style = "${fg white},${bg grey}";
    message-style = "${fg cyan},${bg grey}";
    mode-style = "${fg cyan},${bg grey}";
  });

  splits = {
    vertical = "=";
    horiztonal = "-";
  };
in
''
  ${settings}
  ${window}
  ${message}

  bind ${splits.vertical} split-window -h -c '#{pane_current_path}'
  bind ${splits.horiztonal} split-window -c '#{pane_current_path}'
  bind c new-window -c "#{pane_current_path}"

  bind -n C-p send-keys Up
  bind -n C-n send-keys Down
''
