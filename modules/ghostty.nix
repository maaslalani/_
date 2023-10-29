{
  config,
  pkgs,
  ...
}: let
  colors = import ./colors.nix;
  ghosttyPath = "${config.xdg.configHome}/ghostty";
in {
  home.file."${ghosttyPath}/config".text = ''
    background = ${colors.primary.background}
    foreground = ${colors.primary.foreground}

    keybind = ctrl+z=close_surface
    keybind = ctrl+super+f=toggle_fullscreen

    macos-non-native-fullscreen = true

    font-size = 15
    font-family = JetBrains Mono
    mouse-hide-while-typing = true

    window-padding-x = 8
    window-padding-y = 8

    palette = 0=${colors.normal.black}
    palette = 1=${colors.normal.red}
    palette = 2=${colors.normal.green}
    palette = 3=${colors.normal.yellow}
    palette = 4=${colors.normal.blue}
    palette = 5=${colors.normal.magenta}
    palette = 6=${colors.normal.cyan}
    palette = 7=${colors.normal.white}
    palette = 8=${colors.bright.black}
    palette = 9=${colors.bright.red}
    palette = 10=${colors.bright.green}
    palette = 11=${colors.bright.yellow}
    palette = 12=${colors.bright.blue}
    palette = 13=${colors.bright.magenta}
    palette = 14=${colors.bright.cyan}
    palette = 15=${colors.bright.white}
  '';
}
