{pkgs, ...}: {
  config.programs.neovim = {
    enable = true;
    extraConfig = ''
      imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
      lua <<EOF
      ${builtins.readFile "${pkgs.fnl}/init.lua"}
      EOF

      colorscheme tokyonight-night

      hi Normal guibg=#16161e
      hi NormalNC guibg=#16161e
      hi Pmenu guibg=#1a1b26
      hi StatusLine guibg=NONE
      hi SignColumn guibg=NONE
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
      tokyonight-nvim
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
