with builtins;
let
  prefixString = prefix: string: prefix + string;
  combineAttr = name: value: "${name} ${value}";
  combineAttrs = attrs: attrValues (mapAttrs (combineAttr) attrs);
  config' = prefix: attrs: join (map (string: prefix + string) (combineAttrs attrs));
  config = prefix: attrs: config' "${prefix} " attrs;
  join = concatStringsSep "\n";

  optional = boolean: value: if boolean then (value) else "";
  no = value: optional (isBool value && !value) "no";
  equalValue = value: optional (!isBool value) "=${toString value}";
  settingsAttr = name: value: "set ${no value}${name}${equalValue value}";

  settings = {
    autoindent = true;
    autoread = true;
    autowrite = true;
    backspace = "indent,eol,start";
    backup = false;
    clipboard = "unnamed";
    cmdheight = 1;
    compatible = false;
    concealcursor = "\"\"";
    cursorline = true;
    encoding = "utf-8";
    errorbells = false;
    expandtab = true;
    hidden = true;
    hlsearch = true;
    ignorecase = true;
    incsearch = true;
    laststatus = 0;
    lazyredraw = true;
    number = true;
    numberwidth = 1;
    printfont = "PragmataPro:h12";
    ruler = true;
    shiftwidth = 2;
    showcmd = true;
    showmode = false;
    signcolumn = "yes";
    smartcase = true;
    softtabstop = 2;
    splitbelow = true;
    splitright = true;
    swapfile = false;
    synmaxcol = 300;
    t_vb = "";
    tabstop = 2;
    timeout = false;
    timeoutlen = 50;
    ttimeout = true;
    ttyfast = true;
    undodir = "~/.undo";
    undofile = true;
    updatetime = 300;
    visualbell = true;
    wb = false;
    wildmode = "list:longest";
    wrap = false;
    writebackup = false;
  };

  leaderKey = "<Space>";

  maps = {
    normal = {
      Q = ":q<CR>";
      S = ":%s//g<Left><Left>";
    };

    silent = {
      gd = "<Plug>(coc-definition)";
      gy = "<Plug>(coc-type-definition)";
      gi = "<Plug>(coc-implementation)";
      gr = "<Plug>(coc-references)";
    };

    leader = {
      "" = "<Nop>";
      a = ":ALEFix<CR>";
      t = ":tabnew<CR>";
      e = ":Dirvish<CR>";
      w = ":w<CR>";
      q = ":q<CR>";
      f = ":FZF --color=16,gutter:-1<CR>";
      r = ":Rg<CR>";
      sp = ":set spell!<CR>";
    };

    visual = {
      S = ":s//g<Left><Left>";
    };
  };

  commands = rec {
    W = "w";
    Q = "q";
    Wc = "!wc %";
    Af = "ALEFix";
  };

  filetype = {
    plugin = "on";
    indent = "on";
  };

  colorscheme = "nord";
in
''
  ${join (attrValues (mapAttrs (settingsAttr) settings))}

  ${config ":command" commands}
  ${config "filetype" filetype}

  ${config "nmap" maps.normal}
  ${config "nmap <silent>" maps.silent}
  ${config "vmap" maps.visual}
  ${config' "map <silent> ${leaderKey}" maps.leader}

  colorscheme ${colorscheme}

  let loaded_netrw = 0

  let g:SuperTabDefaultCompletionType = "<c-n>"
  let g:ale_sign_error = '*'
  let g:ale_sign_warning = '~'

  augroup Markdown
    autocmd!
    autocmd FileType markdown set wrap
  augroup END
''
