{ config, pkgs, libs, ... }:
{
  home.file.".hammerspoon/Spoons/SpoonInstall.spoon/init.lua".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Source/SpoonInstall.spoon/init.lua";
  };
  home.file.".hammerspoon/init.lua".source = ../lua/hammerspoon.lua;
}
