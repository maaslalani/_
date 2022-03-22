{ pkgs, ... }:
with pkgs; with pkgs.nodePackages; with pkgs.rubyPackages_3_0; [
  dockerfile-language-server-nodejs
  efm-langserver
  expo-cli
  gopls
  rnix-lsp
  serve
  solargraph
  terraform-ls
  typescript
  typescript-language-server
  write-good
  yaml-language-server
]
