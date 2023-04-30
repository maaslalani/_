"
" Saturn Colorscheme
"

" Boilerplate {{{
hi clear
syntax reset
let g:colors_name="saturn"
set foldmethod=marker
set t_Co=256
" }}}

" Vim {{{
hi Comment guifg=bright.black gui=italic
hi Conditional guifg=normal.blue guibg=NONE
hi Constant guifg=normal.white guibg=NONE
hi CursorLine guibg=normal.black
hi CursorLineNR guifg=NONE gui=NONE guibg=normal.black
hi Debug guifg=normal.yellow guibg=NONE
hi Define guifg=normal.blue guibg=NONE
hi Delimiter guifg=normal.white guibg=NONE
hi DiagnosticError guifg=normal.red guibg=NONE
hi DiffAdd guifg=normal.green guibg=NONE
hi DiffChange guifg=bright.yellow guibg=NONE
hi DiffDelete guifg=normal.red guibg=NONE
hi DiffText guifg=normal.red guibg=NONE
hi Directory guifg=normal.blue guibg=NONE
hi Error guifg=normal.red guibg=NONE
hi ErrorMsg guifg=normal.red guibg=NONE
hi Exception guifg=normal.red guibg=NONE
hi FoldColumn guifg=normal.black guibg=background
hi Folded guifg=normal.black guibg=background
hi Function guifg=normal.blue guibg=NONE
hi Identifier guifg=normal.white guibg=NONE
hi IncSearch guibg=normal.blue guibg=NONE
hi Include guifg=normal.blue guibg=NONE
hi Keyword guifg=normal.yellow guibg=NONE
hi Label guifg=normal.white guibg=NONE
hi LineNr guifg=bright.black guibg=background
hi Macro guifg=bright.yellow guibg=NONE
hi MatchParen guifg=normal.cyan guibg=NONE
hi MoreMsg guifg=normal.yellow guibg=NONE
hi NonText guifg=normal.black guibg=background
hi Normal guifg=normal.white guibg=background
hi NormalFloat guifg=normal.white guibg=background
hi Number guifg=normal.yellow guibg=NONE
hi NvimInternalError guifg=normal.white guibg=normal.red
hi Operator guifg=normal.cyan guibg=NONE
hi Pmenu guifg=normal.white guibg=bright.background
hi PmenuSbar guifg=normal.cyan guibg=bright.background
hi PmenuSel guifg=normal.cyan guibg=bright.black
hi PmenuThumb guifg=normal.cyan guibg=normal.background
hi PreCondit guifg=normal.yellow guibg=NONE
hi PreProc guifg=normal.red guibg=NONE
hi Question guifg=normal.cyan guibg=NONE
hi Repeat guifg=normal.blue guibg=NONE
hi Search guibg=bright.black guifg=NONE
hi SignColumn guibg=background
hi Special guifg=bright.yellow guibg=NONE
hi SpecialChar guifg=normal.yellow guibg=NONE
hi SpecialComment guifg=bright.black gui=italic guibg=NONE
hi SpellBad guifg=normal.red guibg=NONE
hi Statement guifg=normal.blue guibg=NONE
hi StatusLine gui=bold guibg=background guifg=bright.black
hi StatusLineNC gui=NONE guibg=background guifg=normal.white
hi Storage guifg=normal.magenta guibg=NONE
hi String guifg=normal.green guibg=NONE
hi TabLine guifg=normal.white guibg=background gui=NONE
hi TabLineFill gui=NONE guibg=background
hi TabLineSel guifg=normal.cyan gui=NONE
hi Tag guifg=normal.yellow guibg=NONE
hi Title guifg=normal.magenta guibg=NONE
hi Todo guifg=normal.magenta guibg=NONE
hi Type guifg=normal.cyan guibg=NONE gui=NONE
hi VertSplit gui=NONE guifg=normal.black guibg=NONE
hi Visual gui=NONE guibg=normal.black
hi WarningMsg guifg=bright.yellow guibg=NONE
" }}}

" Git {{{
hi GitGutterAdd guifg=bright.green guibg=NONE
hi GitGutterChange guifg=bright.yellow guibg=NONE
hi GitGutterChangeDelete guifg=bright.red guibg=NONE
hi GitGutterDelete guifg=normal.red guibg=NONE
" }}}

" Language {{{
hi cssAttr guifg=normal.cyan guibg=NONE
hi cssClassName guifg=normal.magenta guibg=NONE
hi cssClassNameDot guifg=normal.magenta guibg=NONE
hi cssColor guifg=normal.yellow guibg=NONE
hi cssIdentifier guifg=normal.red guibg=NONE
hi cssImportant guifg=bright.red guibg=NONE
hi cssIncludeKeyword guifg=normal.green guibg=NONE
hi javaScriptBoolean guifg=normal.magenta guibg=NONE
hi markdownLinkText guifg=normal.magenta guibg=NONE
" }}}

" Telescope {{{
hi TelescopeBorder guifg=normal.black guibg=NONE
hi TelescopeMatching guifg=normal.cyan guibg=NONE
" }}}

" Completion {{{
hi CmpItemKind guifg=normal.cyan guibg=NONE
" }}}

" Hop {{{
hi HopNextKey guifg=normal.magenta guibg=NONE
hi HopNextKey1 guifg=normal.magenta guibg=NONE
hi HopNextKey2 guifg=normal.magenta guibg=NONE
" }}}

" Treesitter {{{
hi TSBoolean guifg=normal.yellow guibg=NONE
hi TSField guifg=normal.cyan guibg=NONE
hi TSPunctSpecial guifg=normal.cyan guibg=NONE
hi TSPunctDelimiter guifg=normal.white guibg=NONE
hi TSTitle guifg=normal.cyan guibg=NONE gui=bold
hi TSStringSpecial guifg=bright.green guibg=NONE
hi TSUri guifg=bright.magenta gui=underline
hi TSLiteral guifg=normal.cyan guibg=NONE
" }}}
