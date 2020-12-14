{ config, pkgs, lib, ... }:
with builtins; let
  config = f: a: concatStringsSep "\n" (attrValues (mapAttrs f a));
  configArray = f: a: concatStringsSep "\n" (map f a);

  autocmdConfig = config (n: v: ("autocmd ${n} ${v}"));
  mapConfig = p: config (n: v: ("${p}${n} ${v}"));
  settingsConfig = config (n: v: ("set ${n}=${toString v}"));
  togglesConfig = config (n: v: ("set ${if v then "" else "no"}${n}"));
  variablesConfig = config (n: v: ("let ${n}=${toString v}"));

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
    timeout = false;
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
    laststatus = 0;
    numberwidth = 1;
    omnifunc = "v:lua.vim.lsp.omnifunc";
    printfont = "PragmataPro:h12";
    shiftwidth = 2;
    shortmess = "filnxtToOFc";
    signcolumn = "yes";
    softtabstop = 2;
    synmaxcol = 300;
    t_vb = "";
    tabstop = 2;
    timeoutlen = 50;
    undodir = "~/.config/nvim/.undo";
    updatetime = 300;
    wildmode = "longest:full,full";
  };

  leaderKey = "<Space>";
  navigationKey = "<C-a>";
  terminalEscapeKey = "<C-\\><C-n>";

  maps.normal = {
    "<BS>" = "<Plug>(dirvish_up)";
    Q = ":q<CR>";
    S = ":%s//g<Left><Left>";
    "<C-j>" = "<C-w>j";
    "<C-k>" = "<C-w>k";
    "<C-h>" = "<C-w>h";
    "<C-l>" = "<C-w>l";
  };

  maps.silent = {
    gh = "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>";
    gD = "<cmd>lua vim.lsp.buf.definition()<CR>";
    K = "<cmd>lua vim.lsp.buf.hover()<CR>";
    gI = "<cmd>lua vim.lsp.buf.implementation()<CR>";
    gr = "<cmd>lua vim.lsp.buf.references()<CR>";
    gd = "<cmd>lua vim.lsp.buf.declaration()<CR>";
  };

  maps.leader = {
    "" = "<Nop>";
    "=" = "migg=G`imi";
    "/" = ":BLines!<CR>";
    N = "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>";
    c = ":Commands<CR>";
    e = ":Dirvish<CR>";
    f = "<cmd>Telescope find_files<cr>";
    gb = ":Gblame<CR>";
    gd = ":Gdiff<CR>";
    l = "<cmd>lua vim.lsp.buf.formatting()<CR>";
    n = "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>";
    o = ":silent !open <cWORD><CR>";
    p = "\"*p";
    q = ":q<CR>";
    r = "<cmd>Telescope live_grep<cr>";
    t = ":tabnew<CR>";
    w = ":w<CR>";
    W = ":w!<CR>";
    y = "\"*y";
  };

  maps.visual = {
    "<" = "<gv";
    ">" = ">gv";
    S = ":s//g<Left><Left>";
    s = ":sort | w | e<CR>";
  };

  maps.insert = {
    "<expr> <S-Tab>" = "pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"";
    "<expr> <Tab>" = "pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"";
  };

  commands = {
    E = "Dirvish";
    Q = "q";
    Tf = "TestFile";
    W = "w";
    Wc = "!wc %";
  };

  filetype = {
    indent = "on";
    plugin = "on";
  };

  variables = {
    completion_matching_strategy_list = "['exact', 'substring', 'fuzzy']";
    diagnostic_auto_popup_while_jump = 1;
    diagnostic_enable_underline = 1;
    diagnostic_enable_virtual_text = 1;
    diagnostic_insert_delay = 0;
    loaded_netrw = 0;
    vimwiki_list = "[{'path': '~/wiki/', 'syntax': 'markdown', 'ext': '.wiki'}]";
  };

  autocmd = {
    CmdLineEnter = ": set nosmartcase";
    CmdLineLeave = ": set smartcase";
    TermOpen = "* setlocal nonumber signcolumn=no";
    "BufWritePre *.go" = "lua Goimports()";
  };

in {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = ''
      ${autocmdConfig autocmd}
      ${settingsConfig settings}
      ${togglesConfig toggles}
      ${variablesConfig variables}

      ${mapConfig ":command " commands}
      ${mapConfig "filetype " filetype}
      ${mapConfig "map <silent> ${leaderKey}" maps.leader}
      ${mapConfig "nmap " maps.normal}
      ${mapConfig "nnoremap <silent> " maps.silent}
      ${mapConfig "vmap " maps.visual}
      ${mapConfig "imap " maps.insert}
      lua <<EOF
      ${builtins.readFile ../configs/vim.lua}
      EOF

    '';
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; with pkgs.vimUtils; [
      auto-pairs
      commentary
      completion-nvim
      fugitive
      fzf-vim
      gitgutter
      nvim-lspconfig
      vim-dirvish
      vim-nix
      vim-signature
      vimwiki
      (buildVimPluginFrom2Nix {
        name = "nvim-telescope";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-telescope";
          repo = "telescope.nvim";
          rev = "6e6fbbc49eee19baeeea85c99aa8fb816fbd25e6";
          sha256 = "0X+OkkVDeGd8NR//jCxD1CCqAXFR+/usgUA24x7zPC0=";
        };
        dependencies = [];
      })
      (buildVimPluginFrom2Nix {
        name = "popup-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-lua";
          repo = "popup.nvim";
          rev = "6f8f4cf35278956de1095b0d10701c6b579a2a57";
          sha256 = "n0htGwrYWro5SUP+A45J2O+mwLyXAWULvZMoFoOubFc=";
        };
        dependencies = [];
      })
      (buildVimPluginFrom2Nix {
        name = "plenary-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-lua";
          repo = "plenary.nvim";
          rev = "16eb57376ce62fbb86ebbd721fb7d2c1b1a0164f";
          sha256 = "9YZro3QXh216P4BafWQ9JSEfUL+ibi2CbdR1EGlcwVo=";
        };
        dependencies = [];
      })
      (buildVimPluginFrom2Nix {
        name = "colorbuddy-nvim";
        src = pkgs.fetchFromGitHub {
          owner = "tjdevries";
          repo = "colorbuddy.nvim";
          rev = "ee11ea2e0305de55f3a8ba9e9996ed72bbdc99e5";
          sha256 = "cEzT9RhE+voYgwY53xjNH5j88Uk+L/DmIDsFMN5plm8=";
        };
        dependencies = [];
      })
      (buildVimPluginFrom2Nix {
        name = "nvim-treesitter";
        src = pkgs.fetchFromGitHub {
          owner = "nvim-treesitter";
          repo = "nvim-treesitter";
          rev = "a5baf151bd78a88c88078b197657f277bcf06058";
          sha256 = "2Sf6+qO4T26IcHaMGSaKmYbvR6pWkgmLXsJFA/HH/W4=";
        };
        dependencies = [];
      })
    ];
  };
}
