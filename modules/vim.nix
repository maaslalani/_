{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      lua <<EOF
      ${builtins.readFile ./init.lua}
      EOF
    '';
    vimAlias = true;
    viAlias = true;
    plugins = (
      with pkgs.unstable.vimPlugins; [
        commentary
        completion-nvim
        gitsigns-nvim
        lualine-nvim
        nvim-autopairs
        nvim-colorizer-lua
        nvim-lspconfig
        nvim-treesitter
        plenary-nvim
        popup-nvim
        telescope-nvim
        vim-test
      ]
    ) ++ (
      with pkgs; [
        colorbuddy-nvim
        nordbuddy-nvim
        which-key-nvim
      ]
    );
  };
}
