{pkgs, ...}:
with pkgs;
with pkgs.elmPackages;
with pkgs.nodePackages_latest; [
  bash-language-server
  cspell
  elm-language-server
  fnlfmt
  golangci-lint
  golangci-lint-langserver
  ltex-ls
  proselint
  rnix-lsp
  rust-analyzer
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
]
