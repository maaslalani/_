{pkgs, ...}: let
  colors = import ./colors.nix;
  saturn = builtins.readFile "${pkgs.saturn}/saturn.vim";
in {
  config.programs.neovim = {
    enable = true;
    extraConfig = ''
      imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
      lua <<EOF
      ${builtins.readFile "${pkgs.fnl}/init.lua"}
      EOF

      ${builtins.replaceStrings [
          "foreground"
          "normal.background"
          "normal.black"
          "normal.blue"
          "normal.cyan"
          "normal.green"
          "normal.magenta"
          "normal.red"
          "normal.white"
          "normal.yellow"
          "bright.background"
          "bright.black"
          "bright.blue"
          "bright.cyan"
          "bright.green"
          "bright.magenta"
          "bright.red"
          "bright.white"
          "bright.yellow"
        ] [
          colors.foreground
          colors.normal.background
          colors.normal.black
          colors.normal.blue
          colors.normal.cyan
          colors.normal.green
          colors.normal.magenta
          colors.normal.red
          colors.normal.white
          colors.normal.yellow
          colors.bright.background
          colors.bright.black
          colors.bright.blue
          colors.bright.cyan
          colors.bright.green
          colors.bright.magenta
          colors.bright.red
          colors.bright.white
          colors.bright.yellow
        ]
        saturn}
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
