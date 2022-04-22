{ pkgs, ... }:
with pkgs; with pkgs.nodePackages; with pkgs.rubyPackages_3_0; [
  efm-langserver
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
