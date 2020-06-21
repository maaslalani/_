with builtins;
let
  togglesConfig = a: concatStringsSep "\n" (attrValues ((mapAttrs (n: v: ("set ${if v then "" else "no"}${n}"))) a));
  settingsConfig = a: concatStringsSep "\n" (attrValues ((mapAttrs (n: v: ("set ${n}=${toString v}"))) a));
  mapConfig = p: a: concatStringsSep "\n" (attrValues ((mapAttrs (n: v: ("${p}${n} ${v}"))) a));

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
    clipboard = "unnamed";
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
    q = ":q<CR>";
    r = ":Rg<CR>";
    t = ":tabnew<CR>";
    w = ":w<CR>";
  };

  maps.visual = {
    S = ":s//g<Left><Left>";
    s = ":sort<CR>";
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

  colorscheme = "nord";
in
''
  colorscheme ${colorscheme}

  ${settingsConfig settings}
  ${togglesConfig toggles}

  ${mapConfig ":command " commands}
  ${mapConfig "filetype " filetype}
  ${mapConfig "nmap " maps.normal}
  ${mapConfig "nnoremap <silent> " maps.silent}
  ${mapConfig "vmap " maps.visual}
  ${mapConfig "map <silent> ${leaderKey}" maps.leader}

  let loaded_netrw = 0
  let g:SuperTabDefaultCompletionType = "<c-n>"
  let g:ale_sign_error = '*'
  let g:ale_sign_warning = '~'
''
