let
  directory = "%2~";

  git_branch = "\\$GIT_BRANCH";
  git_untracked = "\\$GIT_UNTRACKED";
  git_stash = "\\$GIT_STASH";
  git_dirty = "\\$GIT_DIRTY";
  git_ahead = "\\$GIT_AHEAD";
  git_behind = "\\$GIT_BEHIND";
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
          [[ $(git status) =~ "ahead" ]] && GIT_AHEAD="⇡" || GIT_AHEAD=""
          [[ $(git status) =~ "behind" ]] && GIT_BEHIND="⇣" || GIT_BEHIND=""
        else
          unset GIT_BRANCH
          unset GIT_STASH
          unset GIT_DIRTY
          unset GIT_AHEAD
          unset GIT_BEHIND
        fi
      }
    '';
    ps1 = "${blue directory} ${magenta git_branch} ${red git_stash}${red git_dirty}${red git_untracked} ${red git_ahead}${red git_behind} \n%(?.${green "❯"}.${red "❯"}) ";
  }
