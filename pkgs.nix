{ pkgs }:
[
  pkgs.cachix
  pkgs.coreutils
  pkgs.docker
  pkgs.errcheck
  pkgs.exa
  pkgs.fd
  pkgs.ffmpeg
  pkgs.git
  pkgs.glow
  pkgs.gnupg
  pkgs.go
  pkgs.golint
  pkgs.google-cloud-sdk
  pkgs.htop
  pkgs.jq
  pkgs.kubectl
  pkgs.nodejs
  pkgs.pass
  pkgs.ripgrep
  pkgs.rustup
  pkgs.sops
  pkgs.tree
  pkgs.vault
  pkgs.yarn
] ++ [
  pkgs.gopls
  pkgs.nodePackages.typescript
  pkgs.nodePackages.typescript-language-server
  pkgs.rnix-lsp
  pkgs.solargraph
]
