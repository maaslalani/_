with builtins;
let
  lib = import <nixpkgs/lib>;

  settings = concatStringsSep "\n" (map (setting: "set " + setting) [
    "nobackup" "nowb" "noswapfile" "undodir=~/.undo" "undofile"
    "nocompatible" "encoding=utf-8" "lazyredraw" "ttyfast"
    "synmaxcol=300" "nowrap"
    "clipboard=unnamed"
    "noerrorbells" "visualbell" "t_vb="
    "tabstop=2" "shiftwidth=2" "softtabstop=2" "expandtab"
    "list listchars=tab:»·,trail:·"
    "hlsearch" "incsearch" "ignorecase" "smartcase"
    "wildmode=list:longest,list:full" "wildignore+=.git"
    "number" "numberwidth=1"
    "notimeout" "ttimeout" "timeoutlen=50"
    "backspace=indent,eol,start" "printfont=PragmataPro:h12" "fillchars+=vert:│"
    "splitbelow" "splitright"
    "autoindent" "autoread" "autowrite"
    "noshowmode" "showcmd" "hidden"
    "nocursorline" "ruler" "laststatus=0" "concealcursor=\"\""
  ]);

  leaderKey = "<Space>";

  maps = mapsToConfig {
    n.L.t = ":tabnew<CR>";
    n.L.e = ":NERDTreeToggle<CR>";
    n.L.w = ":w<CR>";
    n.L.q = ":q<CR>";
    n.Q = ":q<CR>";
    n.S = ":%s//g<Left><Left>";
    v.S = ":s//g<Left><Left>";
  };

  tokens = {
    n = "nmap ";
    v = "vmap ";
    L = leaderKey;
  };

  mapAttrsToConfig = lib.mapAttrsRecursive (path: value: path ++ [value]);
  collectLists = lib.collect isList;
  parseTokens = map (parseToken);
  parseToken = tokens: concatStringsSep "" (map (getToken) tokens);
  getToken = token: if tokens ? ${token} then tokens.${token} else "${token} ";
  mapsToConfig = maps: concatStringsSep "\n" (parseTokens (collectLists (mapAttrsToConfig maps)));

  commands = concatStringsSep "\n" (attrValues (mapAttrs (name: value: ":command ${name} ${value}") {
    W = "w";
    Q = "q";
    Af = "ALEFix";
    Tf = "TestFile";
    TTerm = "tabnew | term";
    VTerm = "vsp | term";
    Term = "sp | term";
  }));

  filetype = concatStringsSep "\n" (attrValues (mapAttrs (name: value: "filetype ${name} ${if value then "on" else "off"}") {
    plugin = true;
    indent = true;
  }));

  colorscheme = "nord";

in
  ''
    ${settings}
    ${maps}
    ${commands}

    nmap ${leaderKey} <Nop>
    colorscheme ${colorscheme}

    ${filetype}

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
