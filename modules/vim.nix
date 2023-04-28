{pkgs, ...}: {
  config.programs.neovim = {
    enable = true;
    extraConfig = ''
      imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
      lua <<EOF
      ${builtins.readFile "${pkgs.fnl}/init.lua"}
      EOF
      ${builtins.readFile "${pkgs.saturn}/glamour.vim"}
    '';
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      colorbuddy-nvim
      copilot-vim
      friendly-snippets
      gitsigns-nvim
      hop-nvim
      luasnip
      null-ls-nvim
      nvim-autopairs
      nvim-cmp
      nvim-lspconfig
      nvim-treesitter
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
