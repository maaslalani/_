{ pkgs, ... }:
with pkgs; (import ./lsp.nix { pkgs = pkgs; }) ++ [
  entr
  exa
  fd
  jq
  sd
]
