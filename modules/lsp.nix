{ pkgs, ... }:
with pkgs; with pkgs.nodePackages; [
  elmPackages.elm-language-server
  fnlfmt
  haskellPackages.haskell-language-server
  haskellPackages.ormolu
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
