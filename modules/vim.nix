{ config, pkgs, lib, ... }:
{
  config.programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      lua <<EOF
      ${builtins.readFile ../lua/init.lua}
      EOF
    '';
    vimAlias = true;
    viAlias = true;
    plugins = (
      with pkgs.unstable.vimPlugins; [
        hop-nvim
        nvim-lspconfig
        popup-nvim
        neogit
        vim-surround
      ]
    ) ++ (
      with pkgs; [
        gitsigns-nvim
        # neogit
        neorg
        nordbuddy-nvim
        nvim-compe
        nvim-treesitter
        plenary-nvim
        telescope-nvim
        which-key-nvim
      ]
    );
  };
}
