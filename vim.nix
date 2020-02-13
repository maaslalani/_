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
    Af = "ALEFix";
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
  let g:ale_sign_error = '*'
  let g:ale_sign_warning = '~'

  inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  set shortmess+=c

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  inoremap <silent><expr> <c-space> coc#refresh()
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  augroup nvim
    au!
    au VimEnter * doautoa Syntax,FileType
  augroup END
''
