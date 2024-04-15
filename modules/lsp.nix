{pkgs, ...}:
with pkgs;
with pkgs.elmPackages;
with pkgs.nodePackages_latest; [
  bash-language-server
  cspell
  delve
  eslint
  fnlfmt
  golangci-lint
  golangci-lint-langserver
  gopls
  gotools
  ltex-ls
  nil
  nixpkgs-fmt
  openscad-lsp
  prettier
  proselint
  revive
  sass
  serve
  solargraph
  sumneko-lua-language-server
  taplo
  terraform-ls
  typescript
  typescript-language-server
  vscode-css-languageserver-bin
  vscode-html-languageserver-bin
  vscode-json-languageserver
  vscode-langservers-extracted
  write-good
  yaml-language-server
  zls
]
