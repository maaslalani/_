with builtins;
let
  settings = concatStringsSep "\n" (map (setting: "set " + setting) [
    "nobackup" "nowb" "noswapfile"
    "undodir=~/.undo" "undofile"
    "clipboard=unnamed" "nocompatible"
    "encoding=utf-8" "lazyredraw" "ttyfast"
    "synmaxcol=300" "nowrap"
    "noerrorbells" "visualbell" "t_vb="
    "tabstop=2" "shiftwidth=2" "softtabstop=2"
    "expandtab" "list listchars=tab:»·,trail:·"
    "hlsearch" "incsearch" "ignorecase" "smartcase"
    "wildmode=list:longest" "wildignore+=.git"
    "number" "numberwidth=1"
    "backspace=indent,eol,start"
    "printfont=PragmataPro:h12"
    "fillchars+=vert:│"
    "splitbelow" "splitright"
    "autoindent" "autoread" "autowrite"
    "notimeout" "ttimeout" "timeoutlen=50"
    "noshowmode" "showcmd" "hidden"
    "nocursorline" "ruler" "laststatus=0"
    "concealcursor=\"\""
  ]);

  leaderKey = "<Space>";

  attrsToConfig = prefix: attrs:
  concatStringsSep "\n"
  (attrValues (mapAttrs (name: value: prefix + "${name} ${value}") attrs));

  maps = concatStringsSep "\n" (attrValues {
    normal = attrsToConfig "nmap " {
      Q = ":q<CR>";
      S = ":%s//g<Left><Left>";
    };

    visual = attrsToConfig "vmap " {
      S = ":s//g<Left><Left>";
    };

    leader = attrsToConfig "map ${leaderKey}" {
      "" = "<Nop>";
      t = ":tabnew<CR>";
      e = ":NERDTreeToggle<CR>";
      w = ":w<CR>";
      q = ":q<CR>";
    };
  });

  commands = attrsToConfig ":command " {
    W = "w";
    Q = "q";
    Af = "ALEFix";
    Tf = "TestFile";
    TTerm = "tabnew | term";
    VTerm = "vsp | term";
    Term = "sp | term";
  };

  filetype = attrsToConfig "filetype " {
    plugin = "on";
    indent = "on";
  };

  colorscheme = "nord";
in
''
  ${settings}
  ${maps}
  ${commands}
  ${filetype}

  colorscheme ${colorscheme}

  let NERDTreeShowHidden = 1
  let g:SuperTabDefaultCompletionType = 'context'
  let g:SuperTabClosePreviewOnPopupClose = 1
  let g:ale_sign_error = '*'
  let g:ale_sign_warning = '~'

  augroup nvim
    au!
    au VimEnter * doautoa Syntax,FileType
  augroup END
''
