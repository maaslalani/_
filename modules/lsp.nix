{pkgs, ...}:
with pkgs;
with pkgs.elmPackages;
with pkgs.nodePackages_latest; [
  bash-language-server
  crystalline
  cspell
  delve
  dot-language-server
  eslint
  fnlfmt
  golangci-lint
  golangci-lint-langserver
  gopls
  gotools
  ltex-ls
  nil
  nilaway
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
  vscode-langservers-extracted
  write-good
  yaml-language-server
  zls
]
