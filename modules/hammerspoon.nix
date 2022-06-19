{ config, pkgs, libs, ... }:
let
  # defaults write org.hammerspoon.Hammerspoon MJConfigFile ~/.config/hammerspoon/init.lua
  hammerspoonPath = "${config.xdg.configHome}/hammerspoon";
in
{
  home.file."${hammerspoonPath}/Spoons/SpoonInstall.spoon/init.lua".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Source/SpoonInstall.spoon/init.lua";
    sha256 = "0bm2cl3xa8rijmj6biq5dx4flr2arfn7j13qxbfi843a8dwpyhvk";
  };
  home.file."${hammerspoonPath}/Spoons/PassChooser.spoon/init.lua".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/maaslalani/PassChooser.spoon/master/init.lua";
    sha256 = "0phdy0m67fpj1pgrfhnfwshwrvm4x4sv4fvxzk2jxm9wkrycfnc1";
  };
  home.file."${hammerspoonPath}/init.lua".source = "${pkgs.fnl}/hammerspoon.lua";
}
