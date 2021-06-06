{ config, pkgs, libs, ... }:
let
  settings = {
    global = {
      username = "maaslalaniii";
      password_cmd = "pass spotify";
    };
  };

  toml = pkgs.formats.toml {};
  config = toml.generate "spotifyd.conf" settings;
in
{
  home.file.".config/spotifyd/spotifyd.conf".source = config;
}
