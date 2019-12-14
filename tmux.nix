let
in
''
  set -g status-style bg=black
  set -g status-position bottom
  set -g status-justify left
  set -g status-right-style bg=white,fg=black
  set -g status-right '  %H:%M %a '

  setw -g window-status-style bg=black,fg=white
  setw -g window-status-current-style fg=black,bg=white
  setw -g window-status-format ' #I #W '
  setw -g window-status-current-format ' #I #W '

  set -g pane-border-style fg=black,bg=default
  set -g pane-active-border-style fg=black,bg=default

  bind \\ split-window -h
  bind - split-window
''
