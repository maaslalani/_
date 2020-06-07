let
  directory = "%1~";
  git = "$(git symbolic-ref --short HEAD)";

  color = color: text: "%F{${color}}${text}%f";
  green = color "green";
  red = color "red";
  magenta = color "magenta";
in
''${directory} ${magenta git}
%(?.${green "❯"}.${red "❯"}) ''
