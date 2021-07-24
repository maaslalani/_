{ config, pkgs, libs, ... }:
{
  home.file.".hammerspoon/Spoons/SpoonInstall.spoon/init.lua".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Source/SpoonInstall.spoon/init.lua";
    sha256 = "1r3ka83yxmi65zg0x4x7v2hr96dg0y0p0si7q1grrwc2ygx38kvj";
  };
  home.file.".hammerspoon/init.lua".source = ../lua/hammerspoon.lua;
}
