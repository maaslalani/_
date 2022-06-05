{ pkgs, ... }:
with pkgs; with pkgs.nodePackages; [
  elmPackages.elm-language-server
  fnlfmt
  proselint
  rnix-lsp
  serve
  solargraph
  terraform-ls
  typescript
  typescript-language-server
  write-good
  yaml-language-server
]
