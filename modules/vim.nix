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
        fennel-vim
        hop-nvim
        nginx-vim
        nvim-lspconfig
        popup-nvim
        vim-dirvish
        vim-surround
      ]
    ) ++ (
      with pkgs; [
        gitsigns-nvim
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
