{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    exa
    fd
    jq
    ripgrep
  ];
}
