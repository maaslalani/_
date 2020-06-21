let
  directory = "%2~";

  gitBranch = "\\$GIT_BRANCH";
  gitStatus = "\\$GIT_STATUS";

  color = color: text: "%F{${color}}${text}%f";

  blue = color "blue";
  green = color "green";
  magenta = color "magenta";
  red = color "red";
in
  {
    precmd = ''
      precmd() {
        if [ $(git rev-parse --is-inside-work-tree 2>/dev/null) ]; then
          GIT_BRANCH="($(git branch --show-current))"
          GIT_STATUS=$(git status --porcelain | cut -c2 | tr -d ' \n')
        else
          unset GIT_BRANCH
          unset GIT_STATUS
        fi
      }
    '';
    ps1 = "${blue directory} ${magenta gitBranch} ${red gitStatus} \n%(?.${green "❯"}.${red "❯"}) ";
  }
