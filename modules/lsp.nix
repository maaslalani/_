{pkgs, ...}:
with pkgs;
with pkgs.elmPackages;
with pkgs.nodePackages_latest; [
  bash-language-server
  cspell
  elm-language-server
  eslint
  fnlfmt
  golangci-lint
  golangci-lint-langserver
  gopls
  ltex-ls
  nil
  nixpkgs-fmt
  prettier
  proselint
  revive
  rnix-lsp
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
