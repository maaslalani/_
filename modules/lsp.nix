{pkgs, ...}:
with pkgs;
with pkgs.elmPackages;
with pkgs.nodePackages; [
  bash-language-server
  elm-language-server
  fnlfmt
  golangci-lint
  golangci-lint-langserver
  prettier
  proselint
  rnix-lsp
  rust-analyzer
  serve
  solargraph
  sumneko-lua-language-server
  terraform-ls
  typescript
  typescript-language-server
  vscode-css-languageserver-bin
  vscode-html-languageserver-bin
  vscode-json-languageserver
  write-good
  yaml-language-server
]
