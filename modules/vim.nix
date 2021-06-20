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
        vimwiki
      ]
    ) ++ (
      with pkgs; [
        aniseed
        completion-nvim
        gitsigns-nvim
        lua-snip
        nordbuddy-nvim
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
