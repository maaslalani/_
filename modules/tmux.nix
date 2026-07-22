{
  colors,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) concatMapAttrsStringSep concatStrings getExe;

  mkSetLines = concatMapAttrsStringSep "\n" (name: value: ''set -g ${name} "${value}"'');
  mkBindLines = table: concatMapAttrsStringSep "\n" (key: cmd: ''bind -T ${table} "${key}" ${cmd}'');

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

  style = fg: "fg=${fg},bg=default";
  paint = fg: bg: "#[fg=${fg}]#[bg=${bg}]";
  indicator = flag: color: label: "#{?${flag},${paint colors.primary.background color} ${label} #[default] ,}";

  sessionPrefix = paint colors.bright.white colors.normal.magenta;
  sessionCopy = paint colors.primary.background colors.normal.yellow;
  sessionRest = paint colors.normal.yellow colors.normal.blue;
  sessionStyle = "#{?client_prefix,${sessionPrefix},#{?pane_in_mode,${sessionCopy},${sessionRest}}}";

  settings = {
    automatic-rename = "off";
    detach-on-destroy = "off";
    extended-keys = "on";
    extended-keys-format = "csi-u";
    popup-border-lines = "rounded";
    popup-border-style = style colors.primary.foreground;
    renumber-windows = "on";
    set-clipboard = "on";

    message-command-style = style colors.bright.white;
    message-style = style colors.bright.white;
    mode-style = "fg=${colors.primary.background},bg=${colors.bright.yellow}";

    pane-active-border-style = style colors.normal.black;
    pane-border-style = style colors.normal.black;

    status-interval = "60";
    status-justify = "left";
    status-left = "${sessionStyle}#[bold]#S #[default] ";
    status-left-length = "1000";
    status-right = concatStrings [
      (indicator "pane_synchronized" colors.normal.red "sync")
      "${paint colors.separator colors.normal.black}%d %b "
      "${paint colors.primary.foreground colors.bright.black} %I:%M%p"
    ];
    status-style = "bg=${colors.normal.black}";

    window-status-current-format = " #I #W #{?window_zoomed_flag,+,*} ";
    window-status-current-style = "fg=${colors.bright.white},bg=${colors.bright.black},bold";
    window-status-format = " #I #W - ";
    window-status-separator = "";
    window-status-style = "fg=${colors.separator},bg=${colors.normal.black}";
  };

  cwd = ''-c "#{pane_current_path}"'';
  hsplit = "split-window -h ${cwd}";

  copyBinds = {
    "Enter" = ''send -X copy-pipe-and-cancel "pbcopy"'';
    "v" = "send -X begin-selection";
    "y" = ''send -X copy-pipe-and-cancel "pbcopy"'';
  };

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
    "s" = "display-popup -E ${getExe sessionPicker}";
    "'" = hsplit;
    "|" = hsplit;
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
      set -as terminal-features ",xterm-256color:RGB,ghostty:RGB"
      ${mkBindLines "copy-mode-vi" copyBinds}
      ${mkBindLines "prefix" binds}
    '';
  };
}
