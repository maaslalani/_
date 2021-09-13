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
    plugins = (
      with pkgs.unstable.vimPlugins; [
        fennel-vim
        friendly-snippets
        hop-nvim
        nvim-autopairs
        nvim-lspconfig
        popup-nvim
        vim-commentary
        vim-eunuch
        vim-fugitive
        vim-rails
        vim-rhubarb
        vim-surround
        vim-test
      ]
    ) ++ (
      with pkgs; [
        awkward-nvim
        cmp-buffer
        cmp-luasnip
        cmp-nvim-lsp
        cmp-path
        gitsigns-nvim
        luasnip
        neorg
        neorg-telescope
        nordbuddy-nvim
        nvim-cmp
        nvim-treesitter
        plenary-nvim
        telescope-nvim
        which-key-nvim
      ]
    );
  };
}
