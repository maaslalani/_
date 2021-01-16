{ config, pkgs, libs, ... }:
{
  home.file.".config/yabai/yabairc".text = ''
    yabai -m config layout bsp
  '';
}
