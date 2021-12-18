{ pkgs, ... }:
with pkgs; with pkgs.nodePackages; with pkgs.rubyPackages_3_0; [
  bash-language-server
  dockerfile-language-server-nodejs
  efm-langserver
  gopls
  prettier
  rnix-lsp
  serve
  solargraph
  terraform-ls
  typescript
  typescript-language-server
  write-good
  yaml-language-server
]
