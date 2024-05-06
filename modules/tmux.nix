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
    active-border-style = "fg=#1a1b26,bg=default";
    border-style = "fg=#1a1b26,bg=default";
  };

  status = {
    justify = "left";
    left = " '#S' ";
    left-style = "bg=default,fg=#7879a6,bold";
    right = "'#[fg=#515170] #(whoami).#(hostname) #[fg=#44445e] %d %b %Y  %I:%M%p '";
    right-style = "bg=default,fg=#44445e";
    style = "bg=default";
  };

  window = {
    status-current-format = "' #I #W * '";
    status-current-style = "fg=#7879a6,bg=default";
    status-format = "' #I #W - '";
    status-style = "fg=#58587a,bg=default";
    status-separator = "''";
  };

  message = {
    command-style = "fg=white,bg=default";
    style = "fg=#fcfcfc,bg=default";
  };

  mode.style = "fg=#fcfcfc,bg=#273457";

  currentPath = "-c \"#{pane_current_path}\"";

  binds = rec {
    "_" = "attach -t dotfiles";
    "-" = "split-window ${currentPath}";
    "=" = "set-window-option synchronize-panes";
    "C-a" = "send-prefix";
    "C-t" = t;
    "N" = "new";
    "R" = "source-file ~/.config/tmux/tmux.conf";
    "S" = "set -g status";
    "c" = "new-window ${currentPath} -n ''";
    "t" = "popup -E zsh -lic tss";
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
