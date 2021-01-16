{ config, pkgs, libs, ... }:
{
  home.file.".config/skhd/skhdrc".text = ''
    hyper - return : open /Applications/Alacritty.app
  '';
}
