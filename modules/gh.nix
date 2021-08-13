{ config, pkgs, libs, ... }:
{
  programs.gh = {
    enable = true;
    aliases = {
      pr = "pr create";
      co = "pr checkout";
      open = "repo view --web";
    };
    editor = "vim";
  };
}
