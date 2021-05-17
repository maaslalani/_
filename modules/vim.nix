{ config, pkgs, lib, ... }:
let
  joinLines = builtins.concatStringsSep "\n";
  joinValues = a: joinLines (builtins.attrValues a);

  boolToStr = v: if v then "true" else "false";
  toStr = v: if builtins.isBool v then boolToStr v else builtins.toString v;

  config = f: a: joinLines (builtins.attrValues (builtins.mapAttrs f a));
  configArray = f: a: joinLines (builtins.map f a);

  autocmdConfig = config (n: v: ("autocmd ${n} ${v}"));
  settingsConfig = config (n: v: ("set ${n}=${builtins.toString v}"));
  togglesConfig = config (n: v: ("set ${if v then "" else "no"}${n}"));
  variablesConfig = config (n: v: ("let ${n}=${builtins.toString v}"));

  leaderKey = "<Space>";

  toggles = {
    autoindent = true;
    autoread = true;
    autowrite = true;
    backup = false;
    compatible = false;
    cursorline = true;
    errorbells = false;
    expandtab = true;
    hidden = true;
    hlsearch = true;
    ignorecase = true;
    incsearch = true;
    lazyredraw = true;
    number = true;
    ruler = true;
    showcmd = true;
    showmode = false;
    smartcase = true;
    splitbelow = true;
    splitright = true;
    swapfile = false;
    termguicolors = true;
    timeout = true;
    ttimeout = true;
    ttyfast = true;
    undofile = true;
    visualbell = true;
    wb = false;
    wildmenu = true;
    wrap = false;
    writebackup = false;
  };

  settings = {
    backspace = "indent,eol,start";
    cmdheight = 1;
    completeopt = "menuone,noinsert,noselect";
    concealcursor = "\"\"";
    encoding = "utf-8";
    laststatus = 2;
    statusline = "%<%t\\ %m%h\\ %=\\ %l,%c\\ %y";
    numberwidth = 1;
    omnifunc = "v:lua.vim.lsp.omnifunc";
    diffopt = "filler,internal,algorithm:histogram,indent-heuristic";
    printfont = "PragmataPro:h12";
    shiftwidth = 2;
    shortmess = "filnxtToOFc";
    signcolumn = "yes";
    softtabstop = 2;
    synmaxcol = 300;
    t_vb = "";
    tabstop = 2;
    timeoutlen = 500;
    ttimeoutlen = 0;
    undodir = "~/.config/nvim/.undo";
    updatetime = 300;
    wildmode = "longest:full,full";
  };

  filetype = {
    indent = "on";
    plugin = "on";
  };

  variables = {
    completion_matching_strategy_list = "['exact', 'substring', 'fuzzy']";
    diagnostic_auto_popup_while_jump = 0;
    diagnostic_enable_underline = 1;

    diagnostic_enable_virtual_text = 1;
    diagnostic_insert_delay = 0;

    netrw_banner = 0;
    netrw_localcopydircmd = "'cp -r'";
    netrw_localrmdir = "'rm -r'";
  };

  autocmd = {
    "BufEnter *.nix" = "set ft=nix";
    "BufEnter *.lock" = "set ft=json";
    "BufEnter *.graphql" = "set ft=graphql";
    "BufWrite *.go" = "lua vim.lsp.buf.formatting()";
    "CmdLineEnter :" = "set nosmartcase";
    "CmdLineLeave :" = "set smartcase";
    "TermOpen *" = "setlocal nonumber signcolumn=no";
  };
in
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      ${autocmdConfig autocmd}
      ${settingsConfig settings}
      ${togglesConfig toggles}
      ${variablesConfig variables}

      colorscheme nordbuddy
      let mapleader="\<SPACE>"

      lua <<EOF
      ${builtins.readFile ./init.lua}
      EOF
    '';
    vimAlias = true;
    viAlias = true;
    plugins = (
      with pkgs.unstable.vimPlugins; [
        commentary
        completion-nvim
        gitsigns-nvim
        lualine-nvim
        nvim-autopairs
        nvim-colorizer-lua
        nvim-lspconfig
        nvim-treesitter
        plenary-nvim
        popup-nvim
        telescope-nvim
        vim-test
      ]
    ) ++ (
      with pkgs; [
        colorbuddy-nvim
        nordbuddy-nvim
        which-key-nvim
      ]
    );
  };
}
