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
    backup = false;
    wb = false;
    swapfile = false;
    undofile = true;
    undodir = "~/.undo";
    clipboard = "unnamed";
    compatible = false;
    encoding = "utf-8";
    lazyredraw = true;
    ttyfast = true;
    synmaxcol = 300;
    wrap = false;
    errorbells = false;
    visualbell = true;
    t_vb = "";
    tabstop = 2;
    shiftwidth = 2;
    softtabstop = 2;
    expandtab = true;
    hlsearch = true;
    incsearch = true;
    ignorecase = true;
    smartcase = true;
    wildmode = "list:longest";
    number = true;
    numberwidth = 1;
    backspace = "indent,eol,start";
    printfont = "PragmataPro:h12";
    splitbelow = true;
    splitright = true;
    autoindent = true;
    autoread = true;
    autowrite = true;
    timeout = false;
    ttimeout = true;
    timeoutlen = 50;
    showmode = false;
    showcmd = true;
    updatetime = 300;
    hidden = true;
    cursorline = false;
    ruler = true;
    laststatus = 0;
    concealcursor = "\"\"";
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
    TTerm = "tabnew | term";
    VTerm = "vsp | term";
    Term = "sp | term";
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
