{ config, pkgs, lib, ... }:
{
  config.programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
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
      nordic-nvim
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-colorizer
      nvim-lspconfig
      nvim-treesitter
      plenary-nvim
      popup-nvim
      telescope-nvim
      vim-commentary
      vim-fugitive
      vim-rhubarb
      vim-surround
      vim-test
      which-key-nvim
    ];
  };
}
