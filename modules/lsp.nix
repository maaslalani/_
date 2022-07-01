{ pkgs, ... }:
with pkgs; with pkgs.nodePackages; [
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
