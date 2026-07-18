{
  colors,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) concatStringsSep hasPrefix mapAttrsToList removePrefix;

  mkLines = f: attrs: concatStringsSep "\n" (mapAttrsToList f attrs);
  mkSetLines = prefix: mkLines (name: value: "set -g ${prefix}${name} ${value}");
  mkBindLines = mkLines (key: cmd:
    if hasPrefix "-r " key
    then ''bind -r "${removePrefix "-r " key}" ${cmd}''
    else ''bind "${key}" ${cmd}'');

  sessionPicker = pkgs.writeShellApplication {
    name = "tmux-session-picker";
    runtimeInputs = [pkgs.fzf pkgs.tmux];
    text = ''
      root="$HOME/Developer"
      worktrees=("Dotfiles")

      for repository in "$root"/*; do
        [[ -d "$repository" ]] || continue

        repositoryWorktrees=()
        for path in "$repository"/*; do
          [[ -d "$path" && -e "$path/.git" ]] && repositoryWorktrees+=("$path")
        done

        if ((''${#repositoryWorktrees[@]} == 0)); then
          worktrees+=("''${repository##*/}")
          continue
        fi

        for path in "''${repositoryWorktrees[@]}"; do
          worktrees+=("''${repository##*/}/''${path##*/}")
        done
      done

      if ((''${#worktrees[@]} == 0)); then
        echo "No worktrees found in $root" >&2
        exit 1
      fi

      if ! name=$(
        printf '%s\n' "''${worktrees[@]}" |
          fzf \
            --layout=reverse \
            --info=inline-right \
            --no-scrollbar \
            --color="separator:${colors.separator}" \
            --gutter=" " \
            --padding=0,1 \
            --pointer=">" \
            --prompt=""
      ); then
        exit 0
      fi

      if [[ "$name" == "Dotfiles" ]]; then
        directory="$HOME/_"
      else
        directory="$root/$name"
      fi

      session="''${name//\//-}"
      session="''${session//./-}"
      session="''${session//:/-}"

      if ! tmux has-session -t "=$session" 2>/dev/null; then
        tmux new-session -d -s "$session" -c "$directory"
      fi

      tmux switch-client -t "=$session"
    '';
  };

  settings = {
    automatic-rename = "off";
    detach-on-destroy = "off";
    extended-keys = "on";
    extended-keys-format = "csi-u";
    popup-border-lines = "rounded";
    popup-border-style = "fg=${tmuxColors.popupBorder},bg=default";
    renumber-windows = "on";
    set-clipboard = "on";
  };

  tmuxColors = {
    paneBorder = "#1a1b26";
    popupBorder = "#b9bcb9";
    statusAccent = "#7879a6";
    statusUser = "#515170";
    statusDim = "#44445e";
    windowInactive = "#58587a";
    messageFg = "#fcfcfc";
    modeBg = "#273457";
  };

  pane = {
    active-border-style = "fg=${tmuxColors.paneBorder},bg=default";
    border-style = "fg=${tmuxColors.paneBorder},bg=default";
  };

  status = {
    justify = "left";
    left = " '#S' ";
    left-length = "1000";
    left-style = "bg=default,fg=${tmuxColors.statusAccent},bold";
    right = "'#[fg=${tmuxColors.statusUser}] #(whoami) #[fg=${tmuxColors.statusDim}] %d %b %Y  %I:%M%p '";
    right-style = "bg=default,fg=${tmuxColors.statusDim}";
    style = "bg=default";
  };

  window = {
    status-current-format = "' #I #W * '";
    status-current-style = "fg=${tmuxColors.statusAccent},bg=default";
    status-format = "' #I #W - '";
    status-style = "fg=${tmuxColors.windowInactive},bg=default";
    status-separator = "''";
  };

  message = {
    command-style = "fg=white,bg=default";
    style = "fg=${tmuxColors.messageFg},bg=default";
  };

  mode.style = "fg=${tmuxColors.messageFg},bg=${tmuxColors.modeBg}";

  cwd = ''-c "#{pane_current_path}"'';

  binds = rec {
    "_" = "new-session -A -s Dotfiles -c ~/_";
    "-" = "split-window ${cwd}";
    "=" = "set-window-option synchronize-panes";
    "C-a" = "send-prefix";
    "N" = "new ${cwd}";
    "r" = ''command-prompt "rename-session -- '%%'"'';
    "C-r" = r;
    "R" = ''source-file ~/.config/tmux/tmux.conf \; display "• Reloaded"'';
    "S" = "set -g status";
    "c" = "new-window ${cwd}";
    "s" = "display-popup -E tmux-session-picker";
    "'" = "split-window -h ${cwd}";
    "|" = "split-window -h ${cwd}";
    "h" = "select-pane -L";
    "j" = "select-pane -D";
    "k" = "select-pane -U";
    "l" = "select-pane -R";
  };
in {
  home.packages = [sessionPicker];

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
