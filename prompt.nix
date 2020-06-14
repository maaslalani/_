let
  directory = "%2~";
  # branch
  git = "\\$GIT_BRANCH";
  # conflicts
  # ahead / behind
  # untracked changes
  git_untracked = "\\$GIT_UNTRACKED";
  # stashes
  git_stash = "\\$GIT_STASH";
  # modified
  git_modified = "\\$GIT_MODIFIED";
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
          ${contains "$GIT_STATUS" "M"} && GIT_MODIFIED="x" || GIT_MODIFIED=""
          ${contains "$GIT_STATUS" "?"} && GIT_UNTRACKED="?" || GIT_UNTRACKED=""

        else
          unset GIT_BRANCH
          unset GIT_STASH
          unset GIT_STATUS
        fi
      }
    '';
    ps1 = "${blue directory} ${magenta git} ${red git_stash}${red git_modified}${red git_untracked}
    \n%(?.${green "❯"}.${red "❯"}) ";
  }
