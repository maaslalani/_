"
" Saturn Colorscheme
"

" Boilerplate {{{

hi clear
syntax reset

let g:colors_name="glamour"

set background=dark
set foldmethod=marker
set t_Co=256

" }}}

" Colors {{{

" abbr fg  #C5C8C6
" abbr bg  #171717
" abbr c0  #282A2E
" abbr c8  #373B41
" abbr c1  #A54242
" abbr c9  #CC6666
" abbr c2  #8C9440
" abbr c10 #B5BD68
" abbr c3  #DE935F
" abbr c11 #F0C674
" abbr c4  #5F819D
" abbr c12 #81A2BE
" abbr c5  #85678F
" abbr c13 #B294BB
" abbr c6  #5E8D87
" abbr c14 #8ABEB7
" abbr c7  #707880
" abbr c15 #C5C8C6

" }}}

" Vim {{{

hi Comment guifg=#707880 gui=italic
hi Conditional guifg=#81A2BE guibg=NONE
hi Constant guifg=#C5C8C6 guibg=NONE
hi CursorLine guibg=#282A2E
hi CursorLineNR guifg=NONE guibg=#282A2E gui=NONE
hi Debug guifg=#DE935F guibg=NONE
hi Define guifg=#81A2BE guibg=NONE
hi Delimiter guifg=#C5C8C6 guibg=NONE
hi DiagnosticError guifg=#A54242 guibg=NONE
hi DiffAdd guifg=#B5BD68 guibg=NONE
hi DiffChange guifg=#F0C674 guibg=NONE
hi DiffDelete guifg=#A54242 guibg=NONE
hi DiffText guifg=#A54242 guibg=NONE
hi Directory guifg=#81A2BE guibg=NONE
hi SpellBad guifg=#CC6666 guibg=NONE
hi Error guifg=#CC6666 guibg=NONE
hi Error guifg=#CC6666 guibg=NONE
hi ErrorMsg guifg=#CC6666 guibg=NONE
hi Exception guifg=#A54242 guibg=NONE
hi FoldColumn guifg=#5E6360 guibg=#171717
hi Folded guifg=#5E6360 guibg=#171717
hi Function guifg=#8ABEB7 guibg=NONE
hi Identifier guifg=#C5C8C6 guibg=NONE
hi IncSearch guifg=#81A2BE guibg=NONE
hi Include guifg=#81A2BE guibg=NONE
hi Keyword guifg=#81A2BE guibg=NONE
hi Label guifg=#81A2BE guibg=NONE
hi LineNr guifg=#5E6360 guibg=#171717
hi Macro guifg=#DE935F guibg=NONE
hi MatchParen guifg=#8ABEB7 guibg=NONE
hi MoreMsg guifg=#DE935F guibg=NONE
hi NonText guifg=#373B41 guibg=#171717
hi Normal guifg=#C5C8C6 guibg=#171717
hi NormalFloat guifg=#C5C8C6 guibg=#171717
hi Number guifg=#CC6666 guibg=NONE
hi NvimInternalError guifg=#707880 guibg=#A54242
hi Operator guifg=#5E8D87 guibg=NONE
hi Pmenu guifg=#C5C8C6 guibg=#282A2E
hi PmenuSbar guifg=#5F819D guibg=#282A2E
hi PmenuSel guifg=#5F819D guibg=#373B41
hi PmenuThumb guifg=#5F819D guibg=#373B41
hi PreCondit guifg=#DE935F guibg=NONE
hi PreProc guifg=#A54242 guibg=NONE
hi Question guifg=#5E8D87 guibg=NONE
hi Repeat guifg=#81A2BE guibg=NONE
hi Search guibg=#373B41 guifg=NONE
hi SignColumn guibg=#171717
hi Special guifg=#DE935F guibg=NONE
hi SpecialChar guifg=#F0C674 guibg=NONE
hi SpecialComment guifg=#373B41 gui=italic guibg=NONE
hi Statement guifg=#5E8D87 guibg=NONE
hi StatusLine gui=bold guibg=#171717 guifg=#C5C8C6
hi StatusLineNC gui=NONE guibg=#171717 guifg=#C5C8C6
hi Storage guifg=#85678F guibg=NONE
hi String guifg=#B5BD68 guibg=NONE
hi TabLine guifg=#5E6360 guibg=#171717 gui=NONE
hi TabLineFill gui=NONE guibg=#171717
hi TabLineSel guifg=#8ABEB7 gui=NONE
hi Tag guifg=#DE935F guibg=NONE
hi Title guifg=#5F819D guibg=NONE
hi Title guifg=#C5C8C6
hi Todo guifg=#F0C674 guibg=NONE
hi Type guifg=#8ABEB7 guibg=NONE gui=NONE
hi VertSplit gui=NONE guifg=#282A2E guibg=NONE
hi Visual gui=NONE guibg=#282A2E
hi WarningMsg guifg=#DE935F guibg=NONE

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

" Treesitter {{{
hi TSBoolean guifg=#DE935F guibg=NONE
hi TSField guifg=#81A2BE guibg=NONE
hi TSPunctSpecial guifg=#81A2BE guibg=NONE
hi TSPunctDelimiter guifg=#C5C8C6 guibg=NONE
hi TSTitle guifg=#81A2BE guibg=NONE gui=bold
hi TSStringSpecial guifg=#8C9440 guibg=NONE
hi TSUri guifg=#B294BB gui=underline
hi TSLiteral guifg=#5F819D guibg=NONE
" }}}

" Neorg {{{
hi NeorgHeading1Prefix guifg=#5F819D guibg=NONE
hi NeorgHeading1Title guifg=#5F819D guibg=NONE
hi NeorgHeading2Prefix guifg=#B294BB guibg=NONE
hi NeorgHeading2Title guifg=#B294BB guibg=NONE
hi NeorgHeading3Prefix guifg=#DE937F guibg=NONE
hi NeorgHeading3Title guifg=#DE937F guibg=NONE
hi NeorgLinkFile guifg=#5E8D87 guibg=NONE
hi Conceal guifg=NONE guibg=NONE
" }}}
