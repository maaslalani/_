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
        gitsigns-nvim
        lualine-nvim
        nvim-autopairs
        nvim-colorizer-lua
        nvim-dap
        nvim-lspconfig
        nvim-treesitter
        plenary-nvim
        popup-nvim
        telescope-nvim
        vim-test
        vimwiki
        which-key-nvim
      ]
    ) ++ (
      with pkgs; [
        colorbuddy-nvim
        nordbuddy-nvim
        completion-nvim
      ]
    );
  };
}
