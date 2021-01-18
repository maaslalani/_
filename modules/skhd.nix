{ config, pkgs, libs, ... }:
with builtins; let
  config = f: a: concatStringsSep "\n" (attrValues (mapAttrs f a));
  attrsToConfig = config (n: v: ("${n} : ${v}"));
  settings = {
    "hyper - a" = "open /Applications/Alacritty.app";
    "hyper - b" = "open /Applications/Brave\\ Browser.app";
    "hyper - c" = "open /System/Applications/Calendar.app";
    "hyper - s" = "open /Applications/Slack.app";
  };
in
{
  home.file.".config/skhd/skhdrc".text = attrsToConfig settings;
}
