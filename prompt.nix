let
  directory = "%1~";

  color = color: text: "%F{${color}}${text}%f";
  green = color "green";
  red = color "red";
in
''${directory}
%(?.${green "❯"}.${red "❯"}) ''
