{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      lua <<EOF
      ${import ../lua/init.nix}
      EOF
    '';
    vimAlias = true;
    viAlias = true;
    plugins = (
      with pkgs.unstable.vimPlugins; [
        commentary
        friendly-snippets
        gitsigns-nvim
        lualine-nvim
        nvim-autopairs
        nvim-colorizer-lua
        nvim-compe
        nvim-dap
        nvim-lspconfig
        nvim-treesitter
        plenary-nvim
        popup-nvim
        telescope-nvim
        vim-test
        vim-vsnip
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
