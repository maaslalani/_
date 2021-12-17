{ pkgs, ... }:
with pkgs; with pkgs.nodePackages; with pkgs.rubyPackages_3_0; [
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
  solargraph
]
