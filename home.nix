{ config, pkgs, ... }:
{
  home.packages = import ./pkgs.nix { inherit pkgs; };
  programs.alacritty = import ./terminal/alacritty.nix;
  programs.bat = import ./programs/bat.nix;
  programs.fzf = import ./programs/fzf.nix;
  programs.git = import ./programs/git.nix;
  programs.home-manager = import ./programs/home.nix;
  programs.neovim = import ./editor/vim.nix { inherit pkgs; };
  programs.taskwarrior = import ./programs/task.nix;
  programs.tmux = import ./terminal/tmux.nix;
  programs.z-lua = import ./programs/z.nix;
  programs.zsh = import ./shell/zsh.nix { inherit pkgs; };
}
