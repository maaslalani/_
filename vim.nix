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
    compatible = false;
    concealcursor = "\"\"";
    cursorline = false;
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
      t = ":tabnew<CR>";
      e = ":NERDTreeToggle<CR>";
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
    Tf = "TestFile";
    Pdf = "silent !pandoc % -o %:r.pdf && open %:r.pdf";
    Preview = "${Pdf} && sleep 1 && rm %:r.pdf";
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

  let NERDTreeShowHidden = 1
  let g:SuperTabDefaultCompletionType = "<c-n>"
  let g:hardtime_default_on = 1

  augroup Markdown
    autocmd!
    autocmd FileType markdown set wrap
  augroup END
''
