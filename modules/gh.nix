{ config, pkgs, libs, ... }:
{
  programs.gh = {
    enable = true;
    aliases = {
      co = "pr checkout";
      open = "repo view --web";
    };
    editor = "vim";
  };
}
