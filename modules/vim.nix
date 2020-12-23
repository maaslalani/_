{ config, pkgs, lib, ... }:
let
  config = f: a: builtins.concatStringsSep "\n" (builtins.attrValues (builtins.mapAttrs f a));
  configArray = f: a: builtins.concatStringsSep "\n" (builtins.map f a);

  autocmdConfig = config (n: v: ("autocmd ${n} ${v}"));
  mapConfig = p: config (n: v: ("${p}${n} ${v}"));
  settingsConfig = config (n: v: ("set ${n}=${builtins.toString v}"));
  togglesConfig = config (n: v: ("set ${if v then "" else "no"}${n}"));
  variablesConfig = config (n: v: ("let ${n}=${builtins.toString v}"));
  lspConfig = configArray (s: "require'nvim_lsp'.${s}.setup { on_attach = require'completion'.on_attach }");

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
    diffopt = "filler,internal,algorithm:histogram,indent-heuristic";
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

  maps = {
    normal = {
      "<BS>" = "<Plug>(dirvish_up)";
      Q = ":q<CR>";
      S = ":%s//g<Left><Left>";
      "<C-j>" = "<C-w>j";
      "<C-k>" = "<C-w>k";
      "<C-h>" = "<C-w>h";
      "<C-l>" = "<C-w>l";
    };

    silent = {
      gh = "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>";
      K = "<cmd>lua vim.lsp.buf.hover()<CR>";
      gI = "<cmd>lua vim.lsp.buf.implementation()<CR>";
      gr = "<cmd>lua vim.lsp.buf.references()<CR>";
      gd = "<cmd>lua vim.lsp.buf.definition()<CR>";
    };

    leader = {
      "" = "<Nop>";
      "=" = "<cmd>lua vim.lsp.buf.formatting()<CR>";
      N = "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>";
      W = ":w!<CR>";
      a = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      e = ":Dirvish<CR>";
      f = "<cmd>Telescope fd<cr>";
      l = "<cmd>lua vim.lsp.buf.formatting()<CR>";
      n = "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>";
      o = ":silent !open <cWORD><CR>";
      p = "\"*p";
      q = ":q<CR>";
      r = "<cmd>Telescope live_grep<cr>";
      sl = ":luafile %<CR>";
      so = ":sort<CR>";
      t = ":tabnew<CR>";
      w = ":w<CR>";
      y = "\"*y";
    };

    visual = {
      "<" = "<gv";
      ">" = ">gv";
      s = ":s//g<Left><Left>";
    };

    insert = {
      "<expr> <S-Tab>" = "pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"";
      "<expr> <Tab>" = "pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"";
    };
  };

  commands = {
    E = "Dirvish";
    Q = "q";
    W = "w";
    Wc = "!wc %";
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
    loaded_netrw = 0;
  };

  autocmd = {
    "BufEnter *.nix" = "set ft=nix";
    "BufEnter *.lock" = "set ft=json";
    "CmdLineEnter :" = "set nosmartcase";
    "CmdLineLeave :" = "set smartcase";
    "TermOpen *" = "setlocal nonumber signcolumn=no";
  };

  lsp = {
    servers = [
      "bashls"
      "dockerls"
      "omnisharp"
      "rnix"
      "solargraph"
      "sumneko_lua"
      "tsserver"
    ];
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

      ${mapConfig ":command " commands}
      ${mapConfig "filetype " filetype}

      ${mapConfig "imap " maps.insert}
      ${mapConfig "map <silent> ${leaderKey}" maps.leader}
      ${mapConfig "nmap " maps.normal}
      ${mapConfig "nnoremap <silent> " maps.silent}
      ${mapConfig "vmap " maps.visual}

      lua <<EOF
      ${lspConfig lsp.servers}
      require'nordbuddy'.use{}
      require'nvim-treesitter.configs'.setup { highlight = { enable = true }, indent = { enable = true } }
      require'nvim_lsp'.gopls.setup {
        on_attach = require'completion'.on_attach,
        settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
      }
      EOF
    '';
    vimAlias = true;
    viAlias = true;
    plugins = (
      with pkgs.vimPlugins; [
        auto-pairs
        commentary
        completion-nvim
        gitgutter
        nvim-lspconfig
        vim-dirvish
        vim-surround
      ]
    ) ++ (
      with pkgs; [
        nordbuddy
        colorbuddy
        plenary
        popup
        telescope
        treesitter
      ]
    );
  };
}
