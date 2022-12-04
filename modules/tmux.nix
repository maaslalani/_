{
  config,
  pkgs,
  libs,
  ...
}:
with builtins; let
  config = f: a: concatStringsSep "\n" (attrValues (mapAttrs f a));
  attrsToConfig = p: config (n: v: "set -g ${p}${n} ${v}");
  bindToConfig = config (n: v: "bind ${n} ${v}");

  settings = {
    automatic-rename = "off";
    default-terminal = "'xterm-256color'";
    focus-events = "on";
    mouse = "on";
    terminal-overrides = "',xterm-256color:Tc'";
  };

  pane = {
    active-border-style = "fg=black,bg=default";
    border-style = "fg=black,bg=default";
  };

  status = {
    justify = "left";
    left = " '#S' ";
    left-style = "bg=default,fg=#cccccc,bold";
    right = "'#[fg=#595959] #(whoami).#(hostname) #[fg=#494949] %d %b %Y  %I:%M%p '";
    right-style = "bg=default,fg=#444444";
    style = "bg=default";
  };

  window = {
    status-current-format = "' #I #W * '";
    status-current-style = "fg=#aaaaaa,bg=default";
    status-format = "' #I #W - '";
    status-style = "fg=#595959,bg=default";
    status-separator = "''";
  };

  message = {
    command-style = "fg=white,bg=default";
    style = "fg=#fcfcfc,bg=default";
  };

  mode.style = "fg=#fcfcfc,bg=#292929";

  currentPath = "-c \"#{pane_current_path}\"";

  binds = {
    "-" = "split-window ${currentPath}";
    "=" = "set-window-option synchronize-panes";
    "C-a" = "send-prefix";
    "N" = "new";
    "R" = "source-file ~/.config/tmux/tmux.conf";
    "S" = "set -g status";
    "c" = "new-window ${currentPath} -n ''";
    "|" = "split-window -h ${currentPath}";
  };
in {
  programs.tmux = {
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    newSession = true;
    secureSocket = false;
    sensibleOnTop = false;
    shortcut = "a";
    terminal = "xterm-256color";
    extraConfig = ''
      ${attrsToConfig "" settings}
      ${attrsToConfig "pane-" pane}
      ${attrsToConfig "window-" window}
      ${attrsToConfig "message-" message}
      ${attrsToConfig "status-" status}
      ${attrsToConfig "mode-" mode}
      ${bindToConfig binds}
    '';
  };
}
