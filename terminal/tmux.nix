with builtins;
let
  attrsToConfig = p: a: concatStringsSep "\n" ((a: attrValues (mapAttrs (n: v: "set -g ${p}${n} ${v}") a)) a);

  settings = {
    default-terminal = "'xterm-256color'";
    mouse            = "on";
  };

  pane = {
    border-style        = "fg=black,bg=default";
    active-border-style = "fg=black,bg=default";
  };

  status = {
    style       = "bg=black";
    right-style = "bg=brightblack,fg=white";
    justify     = "left";
    right       = "'  %H:%M  '";
    left        = "''";
  };

  window = {
    status-style          = "fg=white,bg=colour0";
    status-current-style  = "fg=cyan,bg=brightblack";
    status-current-format = "' #I:#W '";
    status-format         = "' #I:#W '";
  };

  message = {
    command-style = "fg=white,bg=colour0";
    style         = "fg=cyan,bg=colour0";
  };

  mode.style = "fg=cyan,bg=colour0";

  splits = {
    vertical   = "|";
    horiztonal = "-";
  };

in {
  baseIndex                     = 1;
  customPaneNavigationAndResize = true;
  disableConfirmationPrompt     = true;
  enable                        = true;
  escapeTime                    = 0;
  keyMode                       = "vi";
  secureSocket                  = false;
  shortcut                      = "a";
  terminal                      = "xterm-256color";
  extraConfig = ''
    ${attrsToConfig "" settings}
    ${attrsToConfig "pane-" pane}
    ${attrsToConfig "window-" window}
    ${attrsToConfig "message-" message}
    ${attrsToConfig "status-" status}
    ${attrsToConfig "mode-" mode}

    bind ${splits.vertical} split-window -h -c "#{pane_current_path}"
    bind ${splits.horiztonal} split-window -c "#{pane_current_path}"
    bind c new-window -c "#{pane_current_path}"
  '';
}
