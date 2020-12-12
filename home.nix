{ pkgs, ... }:
{
  home.packages = [
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
    pkgs.nodePackages.bash-language-server
    pkgs.nodePackages.dockerfile-language-server-nodejs
    pkgs.rnix-lsp
    pkgs.solargraph
  ];
  programs = {
    alacritty = import ./terminal/alacritty.nix;
    bat = import ./programs/bat.nix;
    fzf = import ./programs/fzf.nix;
    git = import ./programs/git.nix;
    home-manager = import ./programs/manager.nix;
    neovim = import ./editor/vim.nix { inherit pkgs; };
    taskwarrior = import ./programs/task.nix;
    tmux = import ./terminal/tmux.nix;
    z-lua = import ./programs/z.nix;
    zsh = import ./shell/zsh.nix { inherit pkgs; };
  };
}
