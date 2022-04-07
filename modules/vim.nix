{ config, pkgs, lib, ... }:
{
  config.programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
      ${builtins.readFile "${pkgs.saturn}/saturn.vim"}
      lua <<EOF
      ${builtins.readFile "${pkgs.fnl}/init.lua"}
      EOF
    '';
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs; [
      cmp-buffer
      cmp-luasnip
      cmp-nvim-lsp
      cmp-path
      copilot-vim
      friendly-snippets
      gitsigns-nvim
      hop-nvim
      luasnip
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-colorizer
      nvim-lspconfig
      nvim-neorg
      nvim-treesitter
      plenary-nvim
      popup-nvim
      telescope-nvim
      vim-commentary
      vim-fugitive
      vim-rhubarb
      vim-sleuth
      vim-surround
      vim-test
      which-key-nvim
    ];
  };
}
