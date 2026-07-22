{
  colors,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) concatStringsSep mapAttrsToList;

  mkLines = f: attrs: concatStringsSep "\n" (mapAttrsToList f attrs);
  mkSetLines = mkLines (name: value: ''set -g ${name} "${value}"'');
  mkBindLines = mkLines (key: cmd: ''bind "${key}" ${cmd}'');

  sessionPicker = pkgs.writeShellApplication {
    name = "tmux-session-picker";
    runtimeInputs = [pkgs.fzf pkgs.tmux];
    text = ''
      shopt -s nullglob
      cd "$HOME/Developer" || exit

      WORKTREES=("Dotfiles" "Notes")
      declare -A DIRECTORIES=([Dotfiles]="$HOME/_" [Notes]="$HOME/icloud/Documents/notes")

      for REPOSITORY in *; do
        [[ -d "$REPOSITORY" ]] || continue
        PATHS=("$REPOSITORY"/*/.git)
        WORKTREES+=("''${PATHS[@]%/.git}")
        ((''${#PATHS[@]})) || WORKTREES+=("$REPOSITORY")
      done

      NAME=$(
        printf '%s\n' "''${WORKTREES[@]}" |
          fzf --reverse --info=inline-right --no-scrollbar --gutter=" " \
            --color="separator:${colors.separator}" --padding=0,1 --pointer=">" --prompt=""
      ) || exit 0

      SESSION="''${NAME//[\/.:]/-}"
      tmux has-session -t "=$SESSION" 2>/dev/null ||
        tmux new-session -ds "$SESSION" -c "''${DIRECTORIES[$NAME]:-$PWD/$NAME}"
      tmux switch-client -t "=$SESSION"
    '';
  };

  settings = {
    automatic-rename = "off";
    detach-on-destroy = "off";
    extended-keys = "on";
    extended-keys-format = "csi-u";
    popup-border-lines = "rounded";
    popup-border-style = "fg=${colors.primary.foreground},bg=default";
    renumber-windows = "on";
    set-clipboard = "on";

    message-command-style = "fg=white,bg=default";
    message-style = "fg=${colors.bright.white},bg=default";
    mode-style = "fg=${colors.bright.white},bg=${colors.normal.black}";

    pane-active-border-style = "fg=${colors.normal.black},bg=default";
    pane-border-style = "fg=${colors.normal.black},bg=default";

    status-justify = "left";
    status-left = "#S";
    status-left-length = "1000";
    status-left-style = "bg=default,fg=${colors.primary.foreground},bold";
    status-right = "#[fg=${colors.separator}] #(whoami) #[fg=${colors.bright.black}] %d %b %Y  %I:%M%p ";
    status-right-style = "bg=default,fg=${colors.bright.black}";
    status-style = "bg=default";

    window-status-current-format = " #I #W * ";
    window-status-current-style = "fg=${colors.primary.foreground},bg=default";
    window-status-format = " #I #W - ";
    window-status-separator = "";
    window-status-style = "fg=${colors.separator},bg=default";
  };

  cwd = ''-c "#{pane_current_path}"'';

  binds = rec {
    "_" = "new-session -A -s Dotfiles -c ~/_";
    "-" = "split-window ${cwd}";
    "=" = "set-window-option synchronize-panes";
    "N" = "new ${cwd}";
    "r" = ''command-prompt "rename-session -- '%%'"'';
    "C-r" = r;
    "R" = ''source-file ~/.config/tmux/tmux.conf \; display "• Reloaded"'';
    "S" = "set -g status";
    "c" = "new-window ${cwd}";
    "s" = "display-popup -E tmux-session-picker";
    "'" = "split-window -h ${cwd}";
    "|" = "split-window -h ${cwd}";
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
    shortcut = "a";
    extraConfig = ''
      ${mkSetLines settings}
      set -as terminal-features ",xterm-256color:RGB"
      set -as terminal-features ",ghostty:RGB"
      bind -T copy-mode-vi y     send -X copy-pipe-and-cancel "pbcopy"
      bind -T copy-mode-vi Enter send -X copy-pipe-and-cancel "pbcopy"
      ${mkBindLines binds}
    '';
  };
}
