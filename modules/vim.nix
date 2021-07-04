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
        lualine-nvim
        nvim-autopairs
        nvim-lspconfig
        popup-nvim
      ]
    ) ++ (
      with pkgs; [
        aniseed
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
  config.xdg.configFile."nvim/fnl".source = ../fnl;
}
