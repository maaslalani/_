{ pkgs, ... }:
with pkgs; with pkgs.nodePackages; [
  bash-language-server
  fnlfmt
  proselint
  revive
  rnix-lsp
  serve
  solargraph
  terraform-ls
  typescript
  typescript-language-server
  write-good
  yaml-language-server
]
