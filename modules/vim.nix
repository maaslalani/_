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
        colorbuddy-nvim
        lualine-nvim
        nvim-autopairs
        nvim-lspconfig
        popup-nvim
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
