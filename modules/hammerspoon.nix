{
  config,
  pkgs,
  libs,
  ...
}: let
  # defaults write org.hammerspoon.Hammerspoon MJConfigFile ~/.config/hammerspoon/init.lua
  hammerspoonPath = "${config.xdg.configHome}/hammerspoon";
in {
  home.file."${hammerspoonPath}/Spoons/SpoonInstall.spoon/init.lua".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Source/SpoonInstall.spoon/init.lua";
    sha256 = "0bm2cl3xa8rijmj6biq5dx4flr2arfn7j13qxbfi843a8dwpyhvk";
  };
  home.file."${hammerspoonPath}/Spoons/PassChooser.spoon/init.lua".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/maaslalani/PassChooser.spoon/cdf1b996036934c7b9f3a836906204d68bc6e861/init.lua";
    sha256 = "0wchpl1cb9nm7n9bwnmhy4mvwl70jzfmihxwjj688z8f18vsr188";
  };
  home.file."${hammerspoonPath}/init.lua".source = "${pkgs.fnl}/hammerspoon.lua";
}
