{ config, pkgs, ... }:
with builtins; {
  programs.home-manager.enable = true;

  home.packages = [
    pkgs.coreutils
    pkgs.docker
    pkgs.errcheck
    pkgs.exa
    pkgs.fd
    pkgs.ffmpeg
    pkgs.git
    pkgs.glow
    pkgs.gnupg
    pkgs.golint
    pkgs.google-cloud-sdk
    pkgs.htop
    pkgs.jq
    pkgs.kubectl
    pkgs.kubectx
    pkgs.lazydocker
    pkgs.lazygit
    pkgs.nodejs
    pkgs.pass
    pkgs.rename
    pkgs.ripgrep
    pkgs.rustup
    pkgs.sops
    pkgs.vault
    pkgs.yarn
  ];

  programs.bat = import ./programs/bat.nix;
  programs.fzf = import ./programs/fzf.nix;
  programs.git = import ./programs/git.nix;
  programs.taskwarrior = import ./programs/task.nix;
  programs.z-lua = import ./programs/z.nix;

  programs.alacritty = import ./terminal/alacritty.nix;
  programs.neovim = import ./editor/vim.nix { pkgs = pkgs; };
  programs.tmux = import ./terminal/tmux.nix;
  programs.zsh = import ./shell/zsh.nix { pkgs = pkgs; };

  xdg.configFile."nvim/coc-settings.json".text = toJSON(import ./editor/completion.nix);
}
