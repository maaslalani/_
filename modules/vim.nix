{ config, pkgs, lib, ... }:
let
  joinLines = builtins.concatStringsSep "\n";
  joinValues = a: joinLines (builtins.attrValues a);

  boolToStr = v: if v then "true" else "false";
  toStr = v: if builtins.isBool v then boolToStr v else builtins.toString v;

  config = f: a: joinLines (builtins.attrValues (builtins.mapAttrs f a));
  configArray = f: a: joinLines (builtins.map f a);

  autocmdConfig = config (n: v: ("autocmd ${n} ${v}"));
  mapConfig = p: config (n: v: ("${p}${n} ${v}"));
  settingsConfig = config (n: v: ("set ${n}=${builtins.toString v}"));
  togglesConfig = config (n: v: ("set ${if v then "" else "no"}${n}"));
  variablesConfig = config (n: v: ("let ${n}=${builtins.toString v}"));

  expandAttr = k: v: if builtins.isAttrs v then "${k} = { ${expandAttrs v} }," else "${k} = ${toStr v},";
  expandAttrs = a: joinValues (builtins.mapAttrs (expandAttr) a);
  lspSetup = a: joinValues (builtins.mapAttrs (k: v: "require'lspconfig'.${k}.setup { ${expandAttrs v} }") a);
  treesitterSetup = a: "require'nvim-treesitter.configs'.setup { ${expandAttrs a} }; require('telescope').load_extension('fzy_native')";

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
      "<C-h>" = "<C-w>h";
      "<C-j>" = "<C-w>j";
      "<C-k>" = "<C-w>k";
      "<C-l>" = "<C-w>l";
      Q = "<Nop>";
      S = ":%s//g<Left><Left>";
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
      Q = "<cmd>q!<CR>";
      W = "<cmd>w!<CR>";
      a = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      cq = "<cmd>cclose<CR>";
      cd = "<cmd>cd %:p:h<CR><cmd>pwd<CR>";
      cn = "<cmd>cnext<CR>";
      co = "<cmd>copen<CR>";
      cp = "<cmd>cprev<CR>";
      e = "<cmd>Dirvish<CR>";
      f = "<cmd>Telescope fd<CR>";
      gb = "<cmd>Gblame<CR>";
      gd = "<cmd>Gdiff<CR>";
      ms = "<cmd>Mksession<CR>";
      n = "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>";
      o = "<cmd>silent !open <cWORD><CR>";
      p = "\"*p";
      q = "<cmd>q<CR>";
      r = "<cmd>Telescope live_grep<cr>";
      sl = "<cmd>luafile %<CR>";
      sp = "<cmd>setlocal spell!<CR>";
      t = "<cmd>tabnew<CR>";
      w = "<cmd>w<CR>";
      y = "\"*y";
    };

    visual = {
      "<" = "<gv";
      ">" = ">gv";
      ss = ":s//g<Left><Left>";
      so = ":sort <bar>w<bar>e<CR>";
    };

    insert = {
      "<expr> <S-Tab>" = "pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"";
      "<expr> <Tab>" = "pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"";
    };
  };

  abbrev = {
    insert = {
      iferr = "if err != nil {<CR><CR>}<Up><Tab>";
    };
  };

  commands = {
    E = "Dirvish";
    Q = "q";
    W = "w";
    Wc = "!wc %";
    Mksession = "mksession! $VIM_SESSION_PATH | qa";
    Rename = "lua vim.lsp.buf.rename()";
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
    "BufEnter *.graphql" = "set ft=graphql";
    "BufWrite *.go" = "lua vim.lsp.buf.formatting()";
    "CmdLineEnter :" = "set nosmartcase";
    "CmdLineLeave :" = "set smartcase";
    "TermOpen *" = "setlocal nonumber signcolumn=no";
  };

  nvim.treesitter = {
    highlight.enable = true;
    indent.enable = true;
    extensions = {
      fzy_native = {
        override_generic_sorter = true;
        override_file_sorter = true;
      };
    };
  };

  completion = "require'completion'.on_attach";

  nvim.lsp = {
    bashls.on_attach = completion;
    dockerls.on_attach = completion;
    omnisharp.on_attach = completion;
    rnix.on_attach = completion;
    solargraph.on_attach = completion;
    sumneko_lua.on_attach = completion;
    terraformls.on_attach = completion;
    tsserver.on_attach = completion;
    gopls.on_attach = completion;
    gopls.settings.gopls = {
      analyses = {
        unusedparams = true;
        staticcheck = true;
      };
    };
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

      ${mapConfig "iabbrev " abbrev.insert}

      lua <<EOF
      require'nordbuddy'.use{}
      ${lspSetup nvim.lsp}
      ${treesitterSetup nvim.treesitter}
      EOF
    '';
    vimAlias = true;
    viAlias = true;
    plugins = (
      with pkgs.unstable.vimPlugins; [
        auto-pairs
        commentary
        completion-nvim
        gitgutter
        nvim-lspconfig
        nvim-treesitter
        plenary-nvim
        popup-nvim
        telescope-fzy-native-nvim
        telescope-nvim
        vim-dirvish
        vim-fugitive
        vim-surround
      ]
    ) ++ (
      with pkgs; [
        colorbuddy-nvim
        nordbuddy-nvim
      ]
    );
  };
}
