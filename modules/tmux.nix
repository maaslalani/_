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
      root="$HOME/Developer"
      worktrees=("Dotfiles" "Notes")

      for repository in "$root"/*; do
        [[ -d "$repository" ]] || continue

        found=0
        for path in "$repository"/*; do
          if [[ -d "$path" && -e "$path/.git" ]]; then
            worktrees+=("''${repository##*/}/''${path##*/}")
            found=1
          fi
        done

        ((found)) || worktrees+=("''${repository##*/}")
      done

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

      case "$name" in
        Dotfiles) directory="$HOME/_" ;;
        Notes) directory="$HOME/icloud/Documents/notes" ;;
        *) directory="$root/$name" ;;
      esac

      session="''${name//[\/.:]/-}"

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
