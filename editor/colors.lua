local vim = vim
local Color, c, Group = require'colorbuddy'.setup()
local s = require'colorbuddy.style'.styles
local M = {}

function M:setup()
  Color.new('black',       '#3B4252')
  Color.new('brightblack', '#434C5E')
  Color.new('gray',        '#4C566A')
  Color.new('fg',          '#D8DEE9')
  Color.new('white',       '#E5E9F0')
  Color.new('brightwhite', '#ECEFF4')
  Color.new('lightcyan',   '#8FBCBB')
  Color.new('cyan',        '#88C0D0')
  Color.new('lightblue',   '#81A1C1')
  Color.new('blue',        '#5E81AC')
  Color.new('red',         '#BF616A')
  Color.new('orange',      '#D08770')
  Color.new('yellow',      '#EBCB8B')
  Color.new('green',       '#A3BE8C')
  Color.new('magenta',     '#B48EAD')
  Color.new('fg',          '#D8DEE9')
  Color.new('bg',          '#2E3440')
end

function M:use()
  vim.cmd('set termguicolors')
  vim.cmd('hi! clear')
  M.setup(self)

  for _, group in ipairs(M:colors()) do
    local check_none = function(none_resp)
      return function(x)
        return not x and none_resp or x
      end
    end

    local cNone = check_none(c.none)
    local sNone = check_none(s.none)

    Group.new(group[1], cNone(group[2]), cNone(group[3]), sNone(group[4]))
  end
end

function M:colors()
  local vim_groups = {
    {'WarningMsg',c.white,c.orange,s.NONE},
    {'ColorColumn', c.none, c.black},
    {'Cursor', c.bg, c.white},
    {'CursorLine', c.none, c.black},
    {'Error', c.white, c.red},
    {'LineNr', c.gray, c.none},
    {'MatchParen', c.cyan, c.gray},
    {'NonText', c.brightblack, c.none},
    {'Normal', c.white, c.bg},
    {'Pmenu', c.white, c.brightblack},
    {'PmenuSbar', c.white, c.brightblack},
    {'PmenuSel', c.cyan, c.gray},
    {'PmenuThumb', c.cyan, c.gray},
    {'SpecialKey', c.gray, c.none},
    {'SpellBad', c.red, c.bg},
    {'SpellCap', c.yellow, c.cyan},
    {'SpellLocal', c.white, c.bg},
    {'SpellRare', c.brightwhite, c.bg},
    {'Visual', c.none, c.brightblack},
    {'VisualNOS', c.none, c.brightblack},
    {'QuickFixLine', c.bg, c.yellow},
    {'Terminal', c.brightwhite, c.bg},
    {'healthError', c.red, c.black},
    {'healthSuccess', c.green, c.black},
    {'healthWarning', c.yellow, c.black},
    {'CursorColumn', c.none, c.black},
    {'CursorLineNr', c.white, c.none},
    {'Folded', c.gray, c.bg},
    {'FoldColumn', c.gray, c.bg},
    {'SignColumn', c.black, c.bg},
    {'Directory', c.cyan, c.none},
    {'EndOfBuffer', c.black, c.none},
    {'ErrorMsg', c.white, c.red},
    {'ModeMsg', c.white, c.none},
    {'MoreMsg', c.cyan, c.none},
    {'Question', c.white, c.none},
    {'StatusLine', c.brightwhite, c.gray},
    {'StatusLineNC', c.white, c.gray},
    {'StatusLineTerm', c.cyan, c.gray},
    {'StatusLineTermNC', c.white, c.gray},
    {'WarningMsg', c.bg, c.yellow},
    {'WildMenu', c.cyan, c.black},
    {'IncSearch', c.bg, c.yellow},
    {'Search', c.bg, c.yellow},
    {'TabLine', c.white, c.black},
    {'TabLineFill', c.white, c.black},
    {'TabLineSel', c.cyan, c.gray},
    {'Title', c.white, c.none},
    {'VertSplit', c.brightblack, c.bg},
    {'Boolean', c.lightblue, c.none},
    {'Character', c.green, c.none},
    {'Comment', c.gray, c.none},
    {'Conditional', c.lightblue, c.none},
    {'Constant', c.cyan, c.none},
    {'Define', c.lightblue, c.none},
    {'Delimeter', c.brightwhite, c.none},
    {'Exception', c.lightblue, c.none},
    {'Float', c.magenta, c.none},
    {'Function', c.cyan, c.none},
    {'Identifier', c.white, c.none},
    {'Include', c.lightblue, c.none},
    {'Keyword', c.lightblue, c.none},
    {'Label', c.lightblue, c.none},
    {'Number', c.magenta, c.none},
    {'Operator', c.lightblue, c.none},
    {'PreProc', c.lightblue, c.none},
    {'Repeat', c.lightblue, c.none},
    {'Special', c.blue, c.none},
    {'SpecialChar', c.yellow, c.none},
    {'SpecialComment', c.cyan, c.none},
    {'Statement', c.magenta, c.none},
    {'StorageClass', c.lightblue, c.none},
    {'String', c.green, c.none},
    {'Structure', c.yellow, c.none},
    {'Tag', c.white, c.none},
    {'Todo', c.yellow, c.none},
    {'Type', c.lightblue, c.none},
    {'Typedef', c.lightblue, c.none},
    {'Macro', c.lightblue, c.none},
    {'PreCondit', c.lightblue, c.none},
    {'DiffAdd', c.green, c.black},
    {'DiffChange', c.yellow, c.black},
    {'DiffDelete', c.red, c.black},
    {'DiffText', c.lightblue, c.black},
    {'diffAdded', c.green, c.black},
    {'diffChanged', c.yellow, c.black},
    {'diffRemoved', c.red, c.black},
    {'diffFileId', c.blue, c.none},
    -- {'diffFile', #3b4048, c.none},
    {'diffNewFile', c.green, c.none},
    {'diffOldFile', c.red, c.none},
    {'gitconfigVariable', c.lightcyan, c.none},
    {'debugPc', c.none, c.lightcyan},
    {'debugBreakpoint', c.red, c.none},
    {'TSError', c.red, c.none},
    {'TSPunctDelimiter', c.lightblue, c.none},
    {'TSPunctBracket', c.brightwhite, c.none},
    {'TSPunctSpecial', c.brightwhite, c.none},
    {'TSConstant', c.cyan, c.none},
    {'TSConstBuiltin', c.lightblue, c.none},
    {'TSConstMacro', c.lightcyan, c.none},
    {'TSStringRegex', c.green, c.none},
    {'TSString', c.green, c.none},
    {'TSStringEscape', c.cyan, c.none},
    {'TSCharacter', c.green, c.none},
    {'TSNumber', c.magenta, c.none},
    {'TSBoolean', c.lightblue, c.none},
    {'TSFloat', c.magenta, c.none},
    {'TSAnnotation', c.orange, c.none},
    {'TSAttribute', c.lightcyan, c.none},
    {'TSNamespace', c.magenta, c.none},
    {'TSFuncBuiltin', c.cyan, c.none},
    {'TSFunction', c.cyan, c.none},
    {'TSFuncMacro', c.cyan, c.none},
    {'TSParameter', c.white, c.none},
    {'TSParameterReference', c.lightblue, c.none},
    {'TSMethod', c.cyan, c.none},
    {'TSField', c.white, c.none},
    {'TSProperty', c.lightblue, c.none},
    {'TSConstructor', c.lightcyan, c.none},
    {'TSConditional', c.lightblue, c.none},
    {'TSRepeat', c.magenta, c.none},
    {'TSLabel', c.cyan, c.none},
    {'TSKeyword', c.lightblue, c.none},
    {'TSKeywordFunction', c.lightblue, c.none},
    {'TSKeywordOperator', c.lightblue, c.none},
    {'TSOperator', c.lightblue, c.none},
    {'TSException', c.lightblue, c.none},
    {'TSType', c.lightcyan, c.none},
    {'TSTypeBuiltin', c.lightblue, c.none},
    {'TSStructure', c.magenta, c.none},
    {'TSInclude', c.lightblue, c.none},
    {'TSVariable', c.white, c.none},
    {'TSVariableBuiltin', c.lightblue, c.none},

    {'TSText', c.yellow, c.none},
    {'TSStrong', c.yellow, c.none},
    {'TSEmphasis', c.yellow, c.none},
    {'TSUnderline', c.yellow, c.none},
    {'TSTitle', c.yellow, c.none},
    {'TSLiteral', c.yellow, c.none},
    {'TSURI', c.yellow, c.none},

    {'TSTag', c.lightblue, c.none},
    {'TSTagDelimiter', c.gray, c.none},
    {'htmlArg', c.cyan, c.none},
    {'htmlBold', c.cyan, c.none},
    {'htmlEndTag', c.brightwhite, c.none},
    {'htmlH1', c.blue, c.none},
    {'htmlH2', c.blue, c.none},
    {'htmlH3', c.blue, c.none},
    {'htmlH4', c.blue, c.none},
    {'htmlH5', c.blue, c.none},
    {'htmlH6', c.blue, c.none},
    {'htmlItalic', c.magenta, c.none},
    {'htmlLink', c.lightcyan, c.none},
    {'htmlSpecialChar', c.cyan, c.none},
    {'htmlSpecialTagName', c.blue, c.none},
    {'htmlTag', c.brightwhite, c.none},
    {'htmlTagN', c.blue, c.none},
    {'htmlTagName', c.blue, c.none},
    {'htmlTitle', c.brightwhite, c.none},
    {'markdownBlockquote', c.gray, c.none},
    {'markdownBold', c.cyan, c.none},
    {'markdownCode', c.green, c.none},
    {'markdownCodeBlock', c.green, c.none},
    {'markdownCodeDelimiter', c.green, c.none},
    {'markdownH1', c.blue, c.none},
    {'markdownH2', c.blue, c.none},
    {'markdownH3', c.blue, c.none},
    {'markdownH4', c.blue, c.none},
    {'markdownH5', c.blue, c.none},
    {'markdownH6', c.blue, c.none},
    {'markdownHeadingDelimiter', c.red, c.none},
    {'markdownHeadingRule', c.gray, c.none},
    {'markdownId', c.magenta, c.none},
    {'markdownIdDeclaration', c.blue, c.none},
    {'markdownIdDelimiter', c.magenta, c.none},
    {'markdownItalic', c.magenta, c.none},
    {'markdownLinkDelimiter', c.magenta, c.none},
    {'markdownLinkText', c.blue, c.none},
    {'markdownListMarker', c.red, c.none},
    {'markdownOrdenord11ListMarker', c.red, c.none},
    {'markdownRule', c.gray, c.none},
    {'markdownUrl', c.lightcyan, c.none},
    {'CocExplorerIndentLine', c.gray, c.none},
    {'CocExplorerBufferRoot', c.lightcyan, c.none},
    {'CocExplorerFileRoot', c.lightcyan, c.none},
    {'CocExplorerBufferFullPath', c.gray, c.none},
    {'CocExplorerFileFullPath', c.gray, c.none},
    {'CocExplorerBufferReadonly', c.magenta, c.none},
    {'CocExplorerBufferModified', c.magenta, c.none},
    {'CocExplorerBufferNameVisible', c.orange, c.none},
    {'CocExplorerFileReadonly', c.magenta, c.none},
    {'CocExplorerFileModified', c.magenta, c.none},
    {'CocExplorerFileHidden', c.gray, c.none},
    {'CocExplorerHelpLine', c.magenta, c.none},
    {'EasyMotionTarget', c.red, c.none},
    {'EasyMotionTarget2First', c.red, c.none},
    {'EasyMotionTarget2Second', c.red, c.none},
    {'EasyMotionShade', c.none, c.none},
    {'StartifyNumber', c.magenta, c.none},
    {'StartifySelect', c.green, c.none},
    {'StartifyBracket', c.blue, c.none},
    {'StartifySpecial', c.lightcyan, c.none},
    {'StartifyVar', c.blue, c.none},
    {'StartifyPath', c.blue, c.none},
    {'StartifyFile', c.lightcyan, c.none},
    {'StartifySlash', c.blue, c.none},
    {'StartifyHeader', c.green, c.none},
    {'StartifySection', c.magenta, c.none},
    {'StartifyFooter', c.green, c.none},
    {'WhichKey', c.magenta, c.none},
    {'WhichKeySeperator', c.green, c.none},
    {'WhichKeyGroup', c.blue, c.none},
    {'GitGutterAdd', c.green, c.none},
    {'GitGutterChange', c.yellow, c.none},
    {'GitGutterChangeDelete', c.red, c.none},
    {'GitGutterDelete', c.red, c.none},
    {'gitcommitDiscardedFile', c.red, c.none},
    {'gitcommitSelectedFile', c.green, c.none},
    {'gitcommitUntrackedFile', c.red, c.none},
    {'LSPDiagnosticsDefaultWarning', c.yellow, c.none},
    {'LspDiagnosticsDefaultError', c.red, c.none},
    {'LspDiagnosticsDefaultInformation', c.cyan, c.none},
    {'LspDiagnosticsDefaultHint', c.blue, c.none},
    {'LspDiagnosticsUnderlineWarning', c.yellow, c.none},
    {'LspDiagnosticsUnderlineError', c.red, c.none},
    {'LspDiagnosticsUnderlineInformation', c.cyan, c.none},
    {'LspDiagnosticsUnderlineHint', c.blue, c.none},
    {'TelescopeNormal', c.fg, c.bg},
    {'TelescopePromptPrefix', c.fg:dark(.2)},
    {'TelescopeSelection', c.magenta, c.brightblack, s.NONE},
    {'TelescopeMatching', c.magenta},
    {'TelescopeBorder', c.gray},
    {"healthError",c.red,c.black},
    {"healthSuccess",c.green,c.black},
    {"healthWarning",c.yellow,c.black},
    {"TermCursorNC",c.black,c.black},
    {"IncSearch",c.brightwhite,c.blue,s.underline},
    {"Search",c.black,c.cyan},
  }

  return vim_groups
end

M.use{}
