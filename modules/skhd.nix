{ config, pkgs, libs, ... }:
with builtins; let
  config = f: a: concatStringsSep "\n" (attrValues (mapAttrs f a));
  attrsToConfig = config (n: v: ("${n} : ${v}"));
  settings = {
    "hyper - return" = "open /Applications/Alacritty.app";
  };
in
{
  home.file.".config/skhd/skhdrc".text = attrsToConfig settings;
}
