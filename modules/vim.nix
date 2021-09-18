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
    plugins = with pkgs; [
      awkward-nvim
      cmp-buffer
      cmp-luasnip
      cmp-nvim-lsp
      cmp-path
      fennel-vim
      friendly-snippets
      gitsigns-nvim
      hop-nvim
      luasnip
      neorg
      neorg-telescope
      nordbuddy-nvim
      nvim-autopairs
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter
      plenary-nvim
      popup-nvim
      telescope-nvim
      vim-commentary
      vim-crystal
      vim-eunuch
      vim-fugitive
      vim-rails
      vim-rhubarb
      vim-surround
      vim-test
      which-key-nvim
    ];
  };
}
