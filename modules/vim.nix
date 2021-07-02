{ config, pkgs, lib, ... }:
{
  config.programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''let g:aniseed#env = v:true'';
    vimAlias = true;
    viAlias = true;
    plugins = (
      with pkgs.unstable.vimPlugins; [
        colorbuddy-nvim
        commentary
        lualine-nvim
        nvim-autopairs
        nvim-colorizer-lua
        nvim-lspconfig
        popup-nvim
      ]
    ) ++ (
      with pkgs; [
        aniseed
        conjure
        gitsigns-nvim
        neorg
        nordbuddy-nvim
        nvim-compe
        nvim-dap
        nvim-treesitter
        plenary-nvim
        telescope-nvim
        vim-test
        which-key-nvim
      ]
    );
  };
  config.xdg.configFile."nvim/fnl".source = ../fnl;
}
