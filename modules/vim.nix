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
}
