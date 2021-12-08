{ pkgs, ... }:
with pkgs; with pkgs.nodePackages; [
  bash-language-server
  dockerfile-language-server-nodejs
  efm-langserver
  gopls
  rnix-lsp
  serve
  terraform-ls
  typescript
  typescript-language-server
  yaml-language-server
]
