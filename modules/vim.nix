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
    plugins = with pkgs; with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      cmp_luasnip
      copilot-vim
      friendly-snippets
      gitsigns-nvim
      hop-nvim
      luasnip
      nordic-nvim
      null-ls-nvim
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter
      plenary-nvim
      popup-nvim
      telescope-nvim
      vim-rhubarb
      vim-surround
      which-key-nvim
    ];
  };
}
