let
  directory = "%2~";
  # branch
  git = "\\$GIT_BRANCH";
  # conflicts
  # ahead / behind
  # untracked changes
  # stashes
  git_stash = "\\$GIT_STASH";
  # modified
  # staged
  # deleted

  color = color: text: "%F{${color}}${text}%f";
  contains = string: substring: ''[[ "${string}" =~ "${substring}" ]]'';

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
          GIT_STATUS=$(git status --porcelain)
          [[ -n $(git stash list) ]] && GIT_STASH="$" || GIT_STASH=""
          ${contains "$(git status --porcelain)" "M"} && echo Modified || echo "not modified"

        else
          unset GIT_BRANCH
          unset GIT_STASH
          unset GIT_STATUS
        fi
      }
    '';
    ps1 = "${blue directory} ${magenta git} ${red git_stash}\n%(?.${green "❯"}.${red "❯"}) ";
  }
