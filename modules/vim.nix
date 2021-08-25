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
        vim-test
        vim-vsnip
        vim-vsnip-integ
      ]
    ) ++ (
      with pkgs; [
        awkward-nvim
        cmp-buffer
        gitsigns-nvim
        neorg
        nordbuddy-nvim
        nvim-cmp
        nvim-treesitter
        plenary-nvim
        telescope-nvim
        which-key-nvim
      ]
    );
  };
}
