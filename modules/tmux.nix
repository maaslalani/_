{lib, ...}: let
  inherit (lib) concatStringsSep hasPrefix mapAttrsToList removePrefix;

  mkLines = f: attrs: concatStringsSep "\n" (mapAttrsToList f attrs);
  mkSetLines = prefix: mkLines (name: value: "set -g ${prefix}${name} ${value}");
  mkBindLines = mkLines (key: cmd:
    if hasPrefix "-r " key
    then ''bind -r "${removePrefix "-r " key}" ${cmd}''
    else ''bind "${key}" ${cmd}'');

  settings = {
    automatic-rename = "off";
    detach-on-destroy = "off";
    extended-keys = "on";
    extended-keys-format = "csi-u";
    popup-border-lines = "rounded";
    popup-border-style = "fg=${colors.popupBorder},bg=default";
    renumber-windows = "on";
    set-clipboard = "on";
  };

  colors = {
    paneBorder = "#1a1b26";
    popupBorder = "#2a2b3d";
    statusAccent = "#7879a6";
    statusUser = "#515170";
    statusDim = "#44445e";
    windowInactive = "#58587a";
    messageFg = "#fcfcfc";
    modeBg = "#273457";
  };

  pane = {
    active-border-style = "fg=${colors.paneBorder},bg=default";
    border-style = "fg=${colors.paneBorder},bg=default";
  };

  status = {
    justify = "left";
    left = " '#S' ";
    left-length = "1000";
    left-style = "bg=default,fg=${colors.statusAccent},bold";
    right = "'#[fg=${colors.statusUser}] #(whoami) #[fg=${colors.statusDim}] %d %b %Y  %I:%M%p '";
    right-style = "bg=default,fg=${colors.statusDim}";
    style = "bg=default";
  };

  window = {
    status-current-format = "' #I #W * '";
    status-current-style = "fg=${colors.statusAccent},bg=default";
    status-format = "' #I #W - '";
    status-style = "fg=${colors.windowInactive},bg=default";
    status-separator = "''";
  };

  message = {
    command-style = "fg=white,bg=default";
    style = "fg=${colors.messageFg},bg=default";
  };

  mode.style = "fg=${colors.messageFg},bg=${colors.modeBg}";

  cwd = ''-c "#{pane_current_path}"'';

  binds = rec {
    "_" = "new-session -A -s Dotfiles -c ~/_";
    "-" = "split-window ${cwd}";
    "=" = "set-window-option synchronize-panes";
    "C-a" = "send-prefix";
    "N" = "new";
    "r" = ''command-prompt "rename-session -- '%%'"'';
    "C-r" = r;
    "R" = ''source-file ~/.config/tmux/tmux.conf \; display "• Reloaded"'';
    "S" = "set -g status";
    "c" = "new-window ${cwd} -n ''";
    "'" = "split-window -h ${cwd}";
    "|" = "split-window -h ${cwd}";
    "h" = "select-pane -L";
    "j" = "select-pane -D";
    "k" = "select-pane -U";
    "l" = "select-pane -R";
    "o" = "split-window -h -l 80 ${cwd} copilot";
  };
in {
  programs.tmux = {
    baseIndex = 1;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = true;
    enable = true;
    escapeTime = 0;
    focusEvents = true;
    historyLimit = 50000;
    keyMode = "vi";
    mouse = true;
    newSession = false;
    secureSocket = false;
    sensibleOnTop = false;
    shortcut = "a";
    terminal = "tmux-256color";
    extraConfig = ''
      ${mkSetLines "" settings}
      ${mkSetLines "pane-" pane}
      ${mkSetLines "window-" window}
      ${mkSetLines "message-" message}
      ${mkSetLines "status-" status}
      ${mkSetLines "mode-" mode}
      set -as terminal-features ",xterm-256color:RGB"
      set -as terminal-features ",ghostty:RGB"
      bind -T copy-mode-vi y     send -X copy-pipe-and-cancel "pbcopy"
      bind -T copy-mode-vi Enter send -X copy-pipe-and-cancel "pbcopy"
      ${mkBindLines binds}
    '';
  };
}
