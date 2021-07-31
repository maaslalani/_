{ config, pkgs, lib, ... }:
{
  config.programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      lua <<EOF
      ${builtins.readFile "${pkgs.fnl}/init.lua"}
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
        vim-commentary
        vim-eunuch
        vim-fugitive
        vim-rhubarb
        vim-surround
      ]
    ) ++ (
      with pkgs; [
        awkward-nvim
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
