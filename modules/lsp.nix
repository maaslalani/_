{pkgs, ...}:
with pkgs;
with pkgs.elmPackages;
with pkgs.nodePackages; [
  bash-language-server
  fnlfmt
  golangci-lint
  golangci-lint-langserver
  elm-language-server
  proselint
  rnix-lsp
  serve
  solargraph
  rust-analyzer
  terraform-ls
  typescript
  typescript-language-server
  vscode-html-languageserver-bin
  vscode-css-languageserver-bin
  write-good
  sumneko-lua-language-server
  vscode-json-languageserver
  yaml-language-server
]
