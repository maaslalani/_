{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;

  programs.bat = import ./programs/bat.nix;
  programs.fzf = import ./programs/fzf.nix;
  programs.git = import ./programs/git.nix;
  programs.taskwarrior = import ./programs/task.nix;
  programs.z-lua = import ./programs/z.nix;

  programs.alacritty = import ./terminal/alacritty.nix;
  programs.neovim = import ./editor/vim.nix { inherit pkgs; };
  programs.tmux = import ./terminal/tmux.nix;
  programs.zsh = import ./shell/zsh.nix { inherit pkgs; };

  home.packages = import ./pkgs.nix { inherit pkgs; };

  xdg.configFile."nvim/coc-settings.json".text = builtins.toJSON(import ./editor/completion.nix);
}
