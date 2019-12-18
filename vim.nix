with builtins;
let
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

  maps = concatStringsSep "\n" (attrValues (mapAttrs (name: value: "${name} ${value}") {
    "nmap ${leaderKey}" = "<Nop>";
    "nmap ${leaderKey}t" = ":tabnew<CR>";
    "nmap ${leaderKey}e" = ":NERDTreeToggle<CR>";
    "nmap ${leaderKey}w" = ":w<CR>";
    "nmap ${leaderKey}q" = ":q<CR>";
    "nmap Q" = ":q<CR>";
    "nmap S" = ":%s//g<Left><Left>";
    "vmap S" = ":s//g<Left><Left>";
  }));

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
