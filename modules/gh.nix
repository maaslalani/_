{ config, pkgs, libs, ... }:
{
  programs.gh = {
    enable = true;
    aliases = {
      co = "pr checkout";
    };
    editor = "vim";
  };
}
