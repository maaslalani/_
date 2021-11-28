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
      fennel-vim
      gitsigns-nvim
      hop-nvim
      neorg
      neorg-telescope
      nvim-autopairs
      nvim-lspconfig
      nvim-treesitter
      plenary-nvim
      popup-nvim
      telescope-nvim
      tokyonight-nvim
      vim-commentary
      vim-eunuch
      vim-fugitive
      vim-rails
      vim-rhubarb
      vim-surround
      vim-test
      which-key-nvim
    ] ++ [
      cmp-buffer
      cmp-luasnip
      cmp-nvim-lsp
      cmp-path
      friendly-snippets
      luasnip
      nvim-cmp
    ];
  };
}
