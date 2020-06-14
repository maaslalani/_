let
  directory = "%2~";

  git_branch = "\\$GIT_BRANCH";
  git_untracked = "\\$GIT_UNTRACKED";
  git_stash = "\\$GIT_STASH";
  git_dirty = "\\$GIT_DIRTY";
  # ahead / behind

  color = color: text: "%F{${color}}${text}%f";

  blue = color "blue";
  green = color "green";
  magenta = color "magenta";
  red = color "red";
in
  {
    precmd = ''
      precmd() {
        if test -d .git; then
          GIT_BRANCH=$(git branch --show-current)
          [[ -n $(git stash list) ]] && GIT_STASH="$" || GIT_STASH=""
          [[ -n $(git status --porcelain) ]] && GIT_DIRTY="?" || GIT_DIRTY=""
        else
          unset GIT_BRANCH
          unset GIT_STASH
          unset GIT_STATUS
        fi
      }
    '';
    ps1 = "${blue directory} ${magenta git_branch} ${red git_stash}${red git_dirty}${red git_untracked} \n%(?.${green "❯"}.${red "❯"}) ";
  }
