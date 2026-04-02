with builtins; let
  mkLines = f: a: concatStringsSep "\n" (attrValues (mapAttrs f a));
  mkSetLines = prefix: mkLines (n: v: "set -g ${prefix}${n} ${v}");
  mkBindLines = mkLines (n: v: "bind \"${n}\" ${v}");

  settings = {
    automatic-rename = "off";
    default-terminal = "'xterm-256color'";
    focus-events = "on";
    mouse = "on";
    popup-border-lines = "rounded";
    popup-border-style = "fg=#2a2b3d,bg=default";
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
    right = "'#[fg=#515170] #(whoami) #[fg=#44445e] %d %b %Y  %I:%M%p '";
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

  cwd = "-c \"#{pane_current_path}\"";

  binds = rec {
    "_" = "attach -t dotfiles";
    "-" = "split-window ${cwd}";
    "=" = "set-window-option synchronize-panes";
    "C-a" = "send-prefix";
    "C-t" = t;
    "N" = "new";
    "R" = "source-file ~/.config/tmux/tmux.conf";
    "S" = "set -g status";
    "c" = "new-window ${cwd} -n ''";
    "t" = "popup -E -w 82 -h 26 $SHELL";
    "'" = "split-window -h ${cwd}";
    "|" = "split-window -h ${cwd}";
    "h" = "select-pane -L";
    "j" = "select-pane -D";
    "k" = "select-pane -U";
    "l" = "select-pane -R";
    "o" = "split-window -h -l 80 ${cwd} opencode";
    "i" = ''
      {
        copy-mode
        send -X clear-selection
        send -X start-of-line
        send -X start-of-line
        send -X cursor-up
        send -X start-of-line
        send -X start-of-line
        send -X cursor-up
        send -X start-of-line
        send -X start-of-line

        if -F "#{m/r:^> ,#{copy_cursor_line}}" {
          send -X search-forward "^> "
          send -X stop-selection
          send -X -N 2 cursor-right
          send -X begin-selection
          send -X end-of-line
          send -X end-of-line
          if "#{m/r:^> .,#{copy_cursor_line}}" {
            send -X cursor-left
          }
        } {
          send -X end-of-line
          send -X end-of-line
          send -X begin-selection
          send -X search-backward "^> "
          send -X end-of-line
          send -X end-of-line
          send -X cursor-right
          send -X stop-selection
        }
      }'';
  };
in {
  programs.tmux = {
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    enable = true;
    escapeTime = 0;
    keyMode = "vi";
    newSession = false;
    secureSocket = false;
    sensibleOnTop = false;
    shortcut = "a";
    terminal = "xterm-256color";
    extraConfig = ''
      ${mkSetLines "" settings}
      ${mkSetLines "pane-" pane}
      ${mkSetLines "window-" window}
      ${mkSetLines "message-" message}
      ${mkSetLines "status-" status}
      ${mkSetLines "mode-" mode}
      ${mkBindLines binds}
    '';
  };
}
