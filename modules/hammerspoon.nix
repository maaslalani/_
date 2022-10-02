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
    url = "https://raw.githubusercontent.com/daGrevis/PassChooser.spoon/master/init.lua";
    sha256 = "0awch0py1c3p3w57hl5hvqx8834px62c3h622gpl1g3zk3kxg92s";
  };
  home.file."${hammerspoonPath}/init.lua".source = "${pkgs.fnl}/hammerspoon.lua";
}
