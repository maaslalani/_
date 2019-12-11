with builtins;
let
  listToSettings = list:
  concatStringsSep "\n"(map (setting: "set " + setting) list);

  setToSettings = settings:
  concatStringsSep "\n\n"(map listToSettings (attrValues settings));

  setToMapping = {type ? "n", leader ? false, recursive ? true, trigger, action}:
  "${type}${if !recursive then "nore" else ""}map ${if leader then "<Leader>" else ""}${trigger} ${action}";

  mapsToMapping = maps:
  concatStringsSep "\n" (map setToMapping maps);

  boolToString = bool:
  if bool then "on" else "off";

  settings = {
    backups        = [ "nobackup" "nowb" "noswapfile" "undodir=~/.undo" "undofile" ];
    configuration  = [ "nocompatible" "encoding=utf-8" "lazyredraw" "ttyfast" ];
    wrap           = [ "synmaxcol=300" "nowrap" ];
    clipboard      = [ "clipboard=unnamed" ];
    bells          = [ "noerrorbells" "visualbell" "t_vb=" ];
    tabs           = [ "tabstop=2" "shiftwidth=2" "softtabstop=2" "expandtab" ];
    list           = [ "list listchars=tab:»·,trail:·" ];
    search         = [ "hlsearch" "incsearch" "ignorecase" "smartcase" ];
    wild           = [ "wildmode=list:longest,list:full" "wildignore+=.git" ];
    number         = [ "number" "numberwidth=1" ];
    timeout        = [ "notimeout" "ttimeout" "timeoutlen=50" ];
    characters     = [ "backspace=indent,eol,start" "printfont=PragmataPro:h12" "fillchars+=vert:│" ];
    split          = [ "splitbelow" "splitright" ];
    auto           = [ "autoindent" "autoread" "autowrite" ];
    show           = [ "noshowmode" "showcmd" "hidden" ];
    cursor         = [ "nocursorline" "ruler" "laststatus=0" "concealcursor=\"\"" ];
  };

  commands = {
    W      = "w";
    Q      = "q";
    Af     = "ALEFix";
    Tf     = "TestFile";
    TTerm  = "tabnew | term";
    VTerm  = "vsp | term";
    Term   = "sp | term";
  };

  leaderKey = "\"\\<Space>\"";

  maps = [
    { trigger = "S"; action = ":%s//g<Left><Left>"; }
    { trigger = "S"; action = ":s//g<Left><Left>"; type = "v"; }
    { trigger = "Q"; action = ":q<CR>"; }
    { trigger = "t"; action = ":tabnew<CR>"; leader = true; }
    { trigger = "e"; action = ":NERDTreeToggle<CR>"; leader = true; }
    { trigger = "w"; action = ":w<CR>"; leader = true; }
    { trigger = "q"; action = ":q<CR>"; leader = true; }
    { trigger = "${leaderKey}"; action = "<Nop>"; }
  ];

  filetype = {
    plugin = true;
    indent = true;
  };

  colorscheme = "nord";

  plugins = {
    NERDTree.ShowHidden = 1;
    SuperTab = {
      CompletionType = "\"context\"";
      ClosePreviewOnPopupClose = 1;
    };
    ALE = {
      sign.error = "\"*\"";
      sign.warning = "\"~\"";
    };
  };
in
''
  ${setToSettings settings}
  let mapleader=${leaderKey}
  ${mapsToMapping maps}
  filetype plugin ${boolToString filetype.plugin}
  filetype indent ${boolToString filetype.indent}
  colorscheme ${colorscheme}
  let NERDTreeShowHidden=${toString plugins.NERDTree.ShowHidden}
  let g:SuperTabDefaultCompletionType = ${plugins.SuperTab.CompletionType}
  let g:SuperTabClosePreviewOnPopupClose = ${toString plugins.SuperTab.ClosePreviewOnPopupClose}
  let g:ale_sign_error = ${plugins.ALE.sign.error}
  let g:ale_sign_warning = ${plugins.ALE.sign.warning}
  augroup nvim
    au!
    au VimEnter * doautoa Syntax,FileType
  augroup END
''
