{ config, pkgs, libs, ... }:
{
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--color=${builtins.concatStringsSep "," [
        "bg+:0"
        "fg+:5"
        "header:4"
        "hl+:5"
        "hl:6"
        "info:6"
        "marker:5"
        "pointer:5"
        "prompt:6"
        "spinner:4"
        "gutter:-1"
      ]}"
    ];
    enableZshIntegration = true;
  };
}
