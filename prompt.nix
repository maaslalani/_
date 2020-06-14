let
  directory = "%2~";
  git = "\\$GIT_BRANCH";
  git_status = "\\$GIT_STATUS";

  color = color: text: "%F{${color}}${text}%f";

  blue = color "blue";
  cyan = color "cyan";
  green = color "green";
  magenta = color "magenta";
  red = color "red";
in
  {
    precmd = ''
      precmd() {
        if test -d .git; then
          GIT_BRANCH=$(git branch --show-current)
        else
          GIT_BRANCH=""
        fi
      }
    '';
    ps1 = "${blue directory} ${magenta git}\n%(?.${green "❯"}.${red "❯"}) ";
  }
