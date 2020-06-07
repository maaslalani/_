let
  directory = "%1~";
  git = "\\$GIT_BRANCH";

  color = color: text: "%F{${color}}${text}%f";

  blue = color "blue";
  cyan = color "cyan";
  green = color "green";
  magenta = color "magenta";
  red = color "red";
in
''${blue directory} ${magenta git}
%(?.${green "❯"}.${red "❯"}) ''
