{ pkgs, ... }:
{
  home = {
    packages = import ./pkgs.nix { inherit pkgs; };
  };

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
