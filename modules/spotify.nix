{ config, pkgs, libs, ... }:
let
  path = ".config/spotifyd";
  file = "spotifyd.conf";
  settings = {
    global = {
      username = "maaslalaniii";
      password_cmd = "gopass show root/spotify";
      backend = "portaudio";
    };
  };

  toml = pkgs.formats.toml {};
  config = toml.generate file settings;
in
{
  home.file."${path}/${file}".source = config;
}
