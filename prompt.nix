let
  directory = "%1~";
  git = "$vcs";

  color = color: text: "%F{${color}}${text}%f";
  green = color "green";
  red = color "red";
  magenta = color "magenta";
in
''${directory}
%(?.${green "❯"}.${red "❯"}) ''
