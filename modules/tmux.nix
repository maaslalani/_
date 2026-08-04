{
  colors,
  pkgs,
  ...
}: let
  workspacePicker = pkgs.writeShellApplication {
    name = "herdr-workspace-picker";
    runtimeInputs = [pkgs.coreutils pkgs.fzf pkgs.herdr pkgs.jq];
    text = ''
      shopt -s nullglob
      cd "$HOME/Developer" || exit

      WORKTREES=("Dotfiles" "Notes")
      declare -A DIRECTORIES=([Dotfiles]="$HOME/_" [Notes]="$HOME/icloud/Documents/notes")

      for REPOSITORY in *; do
        [[ -d "$REPOSITORY" ]] || continue
        PATHS=("$REPOSITORY"/*/.git "$REPOSITORY"/*/*/.git)
        WORKTREES+=("''${PATHS[@]%/.git}")
        ((''${#PATHS[@]})) || WORKTREES+=("$REPOSITORY")
      done

      NAME="''${1:-}"
      if [[ -z "$NAME" ]]; then
        NAME=$(
          printf '%s\n' "''${WORKTREES[@]}" |
            fzf --reverse --info=inline-right --no-scrollbar --gutter=" " \
              --color="separator:${colors.separator}" --padding=0,1 --pointer=">" --prompt=""
        ) || exit 0
      fi

      WORKSPACE_ID=$(
        herdr workspace list |
          jq -r --arg name "$NAME" '.result.workspaces[] | select(.label == $name) | .workspace_id' |
          head -n 1
      )

      if [[ -n "$WORKSPACE_ID" ]]; then
        herdr workspace focus "$WORKSPACE_ID" >/dev/null
      else
        herdr workspace create --cwd "''${DIRECTORIES[$NAME]:-$PWD/$NAME}" --label "$NAME" --focus >/dev/null
      fi
    '';
  };
in {
  home.packages = [workspacePicker];

  xdg.configFile."herdr/config.toml".text = ''
    onboarding = false

    [theme]
    name = "terminal"

    [theme.custom]
    accent = "${colors.separator}"
    panel_bg = "${colors.primary.background}"
    surface0 = "${colors.primary.background}"
    surface1 = "${colors.normal.black}"
    surface_dim = "${colors.normal.black}"
    overlay0 = "${colors.separator}"
    overlay1 = "${colors.primary.foreground}"
    text = "${colors.primary.foreground}"
    subtext0 = "${colors.separator}"
    mauve = "${colors.normal.magenta}"
    green = "${colors.normal.green}"
    yellow = "${colors.normal.yellow}"
    red = "${colors.normal.red}"
    blue = "${colors.normal.blue}"
    teal = "${colors.normal.cyan}"
    peach = "${colors.normal.yellow}"

    [terminal]
    shell_mode = "auto"
    new_cwd = "follow"

    [keys]
    prefix = "ctrl+a"
    workspace_picker = "prefix+s"
    next_workspace = "prefix+ctrl+j"
    previous_workspace = "prefix+ctrl+k"
    split_horizontal = "prefix+double_quote"
    split_vertical = "prefix+quote"

    [ui]
    confirm_close = false
    hide_tab_bar_when_single_tab = true
    pane_borders = false
    pane_gaps = true
    prompt_new_tab_name = false
  '';
}
