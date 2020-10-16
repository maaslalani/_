{ pkgs }:
with builtins;
let
  config = f: a: concatStringsSep "\n" (attrValues (mapAttrs f a));

  autocmdConfig = config (n: v: ("autocmd ${n} ${v}"));
  mapConfig = p: config (n: v: ("${p}${n} ${v}"));
  settingsConfig = config (n: v: ("set ${n}=${toString v}"));
  togglesConfig = config (n: v: ("set ${if v then "" else "no"}${n}"));
  variablesConfig = config (n: v: ("let ${n}=${toString v}"));

  colorscheme = "nord";

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
    concealcursor = "\"\"";
    encoding = "utf-8";
    laststatus = 0;
    numberwidth = 1;
    printfont = "PragmataPro:h12";
    shiftwidth = 2;
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

  maps.normal = {
    "<BS>" = "<Plug>(dirvish_up)";
    Q = ":q<CR>";
    S = ":%s//g<Left><Left>";
  };

  maps.silent = {
    gd = "<Plug>(coc-definition)";
    gi = "<Plug>(coc-implementation)";
    gr = "<Plug>(coc-references)";
    gy = "<Plug>(coc-type-definition)";
  };

  maps.leader = {
    "" = "<Nop>";
    a = ":ALEFix<CR>";
    f = ":FZF<CR>";
    gb = ":Gblame<CR>";
    gd = ":Gdiff<CR>";
    o = ":silent !open <cWORD><CR>";
    p = "\"*p";
    q = ":q<CR>";
    r = ":Rg<CR>";
    t = ":tabnew<CR>";
    w = ":w<CR>";
    y = "\"*y";
    v = ":vsp+term<CR>i";
    s = ":sp+term<CR>i";
  };

  maps.visual = {
    S = ":s//g<Left><Left>";
    s = ":sort<CR>";
  };

  maps.insert = {

  };

  maps.terminal = {
    "<ESC>" = "<C-\\><C-n>";
    "${leaderKey}q" = "exit<CR><CR>";
  };

  commands = {
    W = "w";
    Q = "q";
    Wc = "!wc %";
    Af = "ALEFix";
    Tf = "TestFile";
  };

  filetype = {
    plugin = "on";
    indent = "on";
  };

  variables = {
    loaded_netrw = "'0'";
    ale_sign_error = "'*'";
    ale_sign_warning = "'~'";

    SuperTabDefaultCompletionType = "'<c-n>'";
    vimwiki_list = "[{'path': '~/wiki/', 'syntax': 'markdown', 'ext': '.wiki'}]";
  };

  autocmd = {
    TermOpen     = "* setlocal nonumber signcolumn=no";
    CmdLineEnter = ": set nosmartcase";
    CmdLineLeave = ": set smartcase";
  };

in {
  enable = true;
  extraConfig = ''
    colorscheme ${colorscheme}

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
    ${mapConfig "tmap " maps.terminal}
  '';
  vimAlias = true;
  viAlias = true;
  plugins = with pkgs.vimPlugins; [
    ale
    auto-pairs
    coc-nvim
    commentary
    emmet-vim
    fugitive
    fzf-vim
    gitgutter
    nord-vim
    polyglot
    supertab
    tabular
    vim-dirvish
    vim-go
    vim-signature
    vim-test
    vimwiki
  ];
}
