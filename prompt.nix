let
  directory = "%2~";

  gitBranch = "\\$GIT_BRANCH";
  gitDirty = "\\$GIT_DIRTY";

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
          [[ -n $(git status --porcelain) ]] && GIT_DIRTY="[?]" || GIT_DIRTY=""
        else
          unset GIT_BRANCH
          unset GIT_DIRTY
        fi
      }
    '';
    ps1 = "${blue directory} ${magenta gitBranch} ${red gitDirty} \n%(?.${green "❯"}.${red "❯"}) ";
  }
