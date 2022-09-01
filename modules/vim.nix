{
  config,
  pkgs,
  lib,
  ...
}: {
  config.programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
      lua <<EOF
      ${builtins.readFile "${pkgs.fnl}/init.lua"}
      EOF
      ${builtins.readFile "${pkgs.saturn}/saturn.vim"}
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
      nvim-lspconfig
      nvim-neorg
      nvim-spellsitter
      nvim-treesitter
      nvim-treesitter-playground
      plenary-nvim
      popup-nvim
      telescope-nvim
      vim-commentary
      vim-fugitive
      vim-hexokinase
      vim-rhubarb
      vim-sleuth
      vim-surround
      vim-test
      which-key-nvim
    ];
  };
}
