{ config, pkgs, libs, ... }:
{
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.config/pass";
      PASSWORD_STORE_CLIP_TIME = "60";
    };
  };
}
