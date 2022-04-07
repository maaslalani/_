"
" Saturn Colorscheme
"

" Boilerplate {{{

hi clear
syntax reset

let g:colors_name="saturn"

set background=dark
set foldmethod=marker
set t_Co=256

" }}}

" Colors {{{
" foreground #C5C8C6  background #1D1F21
" color0     #282A2E  color8     #373B41
" color1     #A54242  color9     #CC6666
" color2     #8C9440  color10    #B5BD68
" color3     #DE935F  color11    #F0C674
" color4     #5F819D  color12    #81A2BE
" color5     #85678F  color13    #B294BB
" color6     #5E8D87  color14    #8ABEB7
" color7     #707880  color15    #C5C8C6

abbr c0  #282A2E
abbr c1  #A54242
abbr c10 #B5BD68
abbr c11 #F0C674
abbr c12 #81A2BE
abbr c13 #B294BB
abbr c14 #8ABEB7
abbr c15 #C5C8C6
abbr c2  #8C9440
abbr c3  #DE935F
abbr c4  #5F819D
abbr c5  #85678F
abbr c6  #5E8D87
abbr c7  #707880
abbr c8  #373B41
abbr c9  #CC6666

" }}}

" Vim {{{

hi Identifier guifg=#C5C8C6 guibg=NONE
hi IncSearch guifg=#81A2BE guibg=NONE
hi Include guifg=#81A2BE guibg=NONE
hi Keyword guifg=#81A2BE guibg=NONE
hi Label guifg=#DE935F guibg=NONE
hi LineNr guifg=#5E6360 guibg=#1D1F21
hi Macro guifg=#DE935F guibg=NONE
hi MatchParen guifg=#8ABEB7 guibg=NONE
hi MoreMsg guifg=#DE935F guibg=NONE
hi NonText guifg=#373B41 guibg=#1D1F21
hi Normal guifg=#C5C8C6 guibg=#1D1F21
hi NormalFloat guifg=#C5C8C6 guibg=#1D1F21
hi Number guifg=#CC6666 guibg=NONE
hi Operator guifg=#5E8D87 guibg=NONE
hi PMenuSel guifg=#5F819D guibg=#373B41
hi Pmenu guifg=#C5C8C6 guibg=#282A2E
hi PreCondit guifg=#DE935F guibg=NONE
hi PreProc guifg=#A54242 guibg=NONE
hi Repeat guifg=#81A2BE guibg=NONE
hi Search guibg=#373B41 guifg=NONE
hi SignColumn guibg=#1D1F21
hi Special guifg=#DE935F guibg=NONE
hi SpecialChar guifg=#F0C674 guibg=NONE
hi SpecialComment guifg=#373B41 gui=italic guibg=NONE
hi Statement guifg=#5E8D87 guibg=NONE
hi StatusLine gui=bold guibg=#1D1F21 guifg=#C5C8C6
hi StatusLineNC gui=NONE guibg=#1D1F21 guifg=#C5C8C6
hi Storage guifg=#85678F guibg=NONE
hi String guifg=#B5BD68 guibg=NONE
hi TabLine guifg=#5E6360 guibg=#1D1F21 gui=NONE
hi TabLineFill gui=NONE guibg=#1D1F21
hi TabLineSel guifg=#8ABEB7 gui=NONE
hi Tag guifg=#DE935F guibg=NONE
hi Title guifg=#5F819D guibg=NONE
hi Title guifg=#C5C8C6
hi Todo guifg=#F0C674 guibg=NONE
hi Type guifg=#8ABEB7 guibg=NONE gui=NONE
hi VertSplit gui=NONE guifg=#282A2E guibg=NONE
hi Visual gui=NONE guibg=#282A2E
hi WarningMsg guifg=#DE935F guibg=NONE
hi Comment guifg=#707880 gui=italic
hi Conditional guifg=#81A2BE guibg=NONE
hi Constant guifg=#C5C8C6 guibg=NONE
hi CursorLine guibg=#282A2E
hi CursorLineNR guifg=#373B41 guibg=NONE
hi Debug guifg=#DE935F guibg=NONE
hi Define guifg=#81A2BE guibg=NONE
hi Delimiter guifg=#C5C8C6 guibg=NONE
hi DiagnosticError guifg=#A54242 guibg=NONE
hi DiffAdd guifg=#B5BD68 guibg=NONE
hi DiffChange guifg=#F0C674 guibg=NONE
hi DiffDelete guifg=#A54242 guibg=NONE
hi DiffText guifg=#A54242 guibg=NONE
hi Directory guifg=#81A2BE guibg=NONE
hi Error guifg=#CC6666 guibg=NONE
hi ErrorMsg guifg=#CC6666 guibg=NONE
hi Error guifg=#CC6666 guibg=NONE
hi Exception guifg=#A54242 guibg=NONE
hi Folded guifg=#5E6360 guibg=#1D1F21
hi Function guifg=#8ABEB7 guibg=NONE
hi Question guifg=#5E8D87 guibg=NONE

" }}}

" Git {{{

hi GitGutterAdd guifg=#B5BD68 guibg=NONE
hi GitGutterChange guifg=#F0C674 guibg=NONE
hi GitGutterChangeDelete guifg=#A54242 guibg=NONE
hi GitGutterDelete guifg=#A54242 guibg=NONE

" }}}

" Language {{{

hi cssAttr guifg=#5E8D87 guibg=NONE
hi cssClassName guifg=#85678F guibg=NONE
hi cssClassNameDot guifg=#85678F guibg=NONE
hi cssColor guifg=#DE935F guibg=NONE
hi cssIdentifier guifg=#A54242 guibg=NONE
hi cssImportant guifg=#A54242 guibg=NONE
hi cssIncludeKeyword guifg=#8C9440 guibg=NONE
hi javaScriptBoolean guifg=#85678F guibg=NONE
hi markdownLinkText guifg=#85678F guibg=NONE

" }}}

" Telescope {{{
hi TelescopeBorder guifg=#373B41 guibg=NONE
hi TelescopeMatching guifg=#81A2BE guibg=NONE
" }}}

" Completion {{{
hi CmpItemKind guifg=#81A2BE guibg=NONE
" }}}

" Hop {{{
hi HopNextKey guifg=#5F819D guibg=NONE
hi HopNextKey1 guifg=#81A2BE guibg=NONE
hi HopNextKey2 guifg=#81A2BE guibg=NONE
" }}}
