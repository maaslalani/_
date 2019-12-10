let
  status = {
    bg = "black";
    position = "top";
    justify = "left";
    right = " #[bg=white]  %H:%M %a ";
  };
  window = {
    status = {
      format = "#[fg=white] #I #W ";
      current.format = "#[bg=white,fg=black] #I #W ";
    };
  };
  pane = {
    border.style = "fg=black,bg=default";
    active.border.style = "fg=black,bg=default";
  };
in
  ''
    set -g status-bg ${status.bg}
    set -g status-position ${status.position}
    set -g status-justify ${status.justify}
    set -g status-right '${status.right}'

    setw -g window-status-format '${window.status.format}'
    setw -g window-status-current-format '${window.status.current.format}'

    set -g pane-border-style '${pane.border.style}'
    set -g pane-active-border-style '${pane.active.border.style}'

    bind \\ split-window -h
    bind - split-window
  ''
