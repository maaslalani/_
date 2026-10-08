rec {
  primary.background = "#0D1116";
  primary.foreground = "#C5C8C6";

  separator = "#5a636e";

  normal.black = "#282a2e";
  normal.red = "#D74E6F";
  normal.green = "#31BB71";
  normal.yellow = "#D3E561";
  normal.blue = "#8056FF";
  normal.magenta = "#ED61D7";
  normal.cyan = "#04D7D7";
  normal.white = "#C5C8C6";

  bright.black = "#4B4B4B";
  bright.red = "#FE5F86";
  bright.green = "#00D787";
  bright.yellow = "#EBFF71";
  bright.blue = "#8F69FF";
  bright.magenta = "#FF7AEA";
  bright.cyan = "#00FEFE";
  bright.white = "#FFFFFF";

  # ANSI palette colors 0-15: normal (0-7) followed by bright (8-15).
  palette = let
    ansi = ["black" "red" "green" "yellow" "blue" "magenta" "cyan" "white"];
  in
    map (name: normal.${name}) ansi ++ map (name: bright.${name}) ansi;
}
