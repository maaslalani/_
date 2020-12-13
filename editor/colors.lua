local vim = vim
local Color, c, Group = require'colorbuddy'.setup()
local s = require'colorbuddy.style'.styles
local M = {}

local merge = function(list)
  local acc = {}
  for _, result in ipairs(list) do vim.list_extend(acc, result) end
  return acc
end

local highlight_to_groups = function(highlight)
  return function(groups)
    local acc = {}
    for _, name in ipairs(groups) do
      table.insert(acc, {name, highlight[1], highlight[2], highlight[3]})
    end
    return acc
  end
end

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
    {'Boolean',c.lightblue,c.none,s.NONE},
    {'Character',c.green,c.none,s.NONE},
    {'ColorColumn', c.none, c.black},
    {'Comment',c.gray,c.none,s.NONE},
    {'Conceal',c.gray,c.none},
    {'Conditional',c.lightblue,c.none,s.NONE},
    {'Constant',c.fg,c.none,s.NONE},
    {'Cursor', c.bg, c.fg},
    {'CursorColumn',c.black,c.none,s.NONE},
    {'CursorLine', c.none, c.bg},
    {'CursorLineNr',c.white,c.none,s.NONE},
    {'Define',c.cyan,c.none,s.NONE},
    {'Delimiter',c.brightwhite,c.none,s.NONE},
    {'Directory',c.cyan,c.none,s.NONE},
    {'EndOfBuffer',c.black, c.none},
    {'Error',c.red,c.bg,s.NONE},
    {'ErrorMsg',c.fg,c.red,s.NONE},
    {'Exception',c.lightblue,c.none,s.NONE},
    {'Float',c.magenta,c.none,s.NONE},
    {'Function',c.lightblue,c.none,s.NONE},
    {'GitGutterAdd',c.green, c.none},
    {'GitGutterChange',c.yellow, c.none},
    {'GitGutterChangeDelete',c.red, c.none},
    {'GitGutterDelete',c.red, c.none},
    {'Identifier',c.lightcyan,c.none,s.NONE},
    {'Include',c.lightcyan,c.none,s.NONE},
    {'Keyword',c.lightblue,c.none,s.NONE},
    {'Label',c.lightblue,c.none,s.NONE},
    {'Folded',c.gray,c.black,s.NONE},
    {'FoldColumn',c.gray,c.bg,s.NONE},
    {'Line',c.orange,c.none,s.NONE},
    {'LineNr',c.gray,c.none,s.NONE},
    {'MatchParen',c.cyan,c.gray},
    {'NonText',c.none,c.none},
    {'Normal',c.fg,c.bg},
    {'Number',c.magenta,c.none,s.NONE},
    {'Operator',c.cyan,c.none,s.NONE},
    {'PMenu',c.fg,c.black},
    {'PMenuSel',c.magenta,c.brightblack},
    {'PmenuSbar',c.fg,c.brightblack},
    {'PmenuThumb',c.none,c.gray},
    {'PreProc',c.lightblue,c.none,s.NONE},
    {'Repeat',c.lightblue,c.none,s.NONE},
    {'SignColumn',c.none,c.none,s.NONE},
    {'Special',c.fg,c.none,s.NONE},
    {'SpecialChar',c.yellow,c.none,s.NONE},
    {'SpecialComment',c.cyan,c.none,s.NONE},
    {'SpecialKey',c.gray,c.gray},
    {'SpellBad',c.red,c.bg},
    {'SpellCap',c.yellow,c.bg},
    {'SpellLocal',c.white,c.bg},
    {'SpellRare',c.brightwhite,c.bg},
    {'Statement',c.blue,c.none,s.NONE},
    {'StorageClass',c.lightblue,c.none,s.NONE},
    {'String',c.green,c.none,s.NONE},
    {'Structure',c.lightblue,c.none,s.NONE},
    {'TabLine',c.fg,c.bg},
    {'TabLineFill',c.gray,c.bg},
    {'TabLineSel',c.lightcyan,c.gray,s.NONE},
    {'TabLineSeparator',c.brightblack,c.none},
    {'Tag',c.fg,c.none,s.NONE},
    {'Title',c.fg,c.none},
    {'Todo',c.yellow,c.none,s.NONE},
    {'Type',c.lightcyan,c.none,s.NONE},
    {'Typedef',c.lightcyan,c.none,s.NONE},
    {'VertSplit',c.gray,c.none},
    {'Visual',c.fg,c.brightblack},
    {'VisualNOS',c.brightblack,c.black},
    {'WarningMsg',c.white,c.orange,s.NONE},
    {'iCursor',c.bg, c.fg},
  }

  return merge({
    vim_groups,
    M:lsp(),
    M:health(),
    M:treesitter(),
    M:telescope(),
  })
end

function M:health()
  return {
    {"healthError",c.red,c.black},
    {"healthSuccess",c.green,c.black},
    {"healthWarning",c.yellow,c.black},
    {"TermCursorNC",c.black,c.black},
    {"IncSearch",c.brightwhite,c.blue,s.underline},
    {"Search",c.black,c.cyan},
  }
end

function M:lsp()
  return {
    {'LspDiagnosticsDefaultHint', c.cyan, c.none},
    {'LspDiagnosticsDefaultError', c.red, c.none},
    {'LspDiagnosticsDefaultWarning', c.yellow, c.none},
    {'LspDiagnosticsDefaultInformation', c.brightwhite, c.none},
  }
end

function M:telescope()
  return {
    {'TelescopeNormal', c.fg, c.bg},
    {'TelescopePromptPrefix', c.fg:dark(.2)},
    {'TelescopeSelection', c.magenta, c.brightblack, s.NONE},
    {'TelescopeMatching', c.magenta},
    {'TelescopeBorder', c.gray},
  }
end

function M:treesitter()
  local error = {'TSError'}
  local punctuation = {'TSPunctDelimiter', 'TSPunctBracket', 'TSPunctSpecial'}
  local constants = {'TSConstant', 'TsConstBuiltin', 'TSConstMacro'}
  local constructors = {'TSConstructor'}
  local string = {'TSStringRegex', 'TSString', 'TSStringEscape'}
  local boolean = {'TSBoolean'}
  local functions = {'TSFunction', 'TSFuncBuiltin', 'TSFuncMacro'}
  local methods = {'TSMethod'}
  local fields = {'TSField', 'TSProperty'}
  local number = {'TSNumber', 'TSFloat'}
  local parameters = {'TSParameter', 'TSParameterReference'}
  local operators = {'TSOperator'}
  local forwords = {'TSConditional', 'TSRepeat'}
  local keyword = {'TSKeyword', 'TSKeywordOperator'}
  local types = {'TSType', 'TSTypeBuiltin'}
  local labels = {'TSLabel'}
  local namespaces = {'TSNamespace'}
  local includes = {'TSInclude'}
  local variables = {'TSVariable', 'TSVariableBuiltin'}
  local tags = {'TSTag', 'TSTagDelimiter'}
  local text = {'TSText', 'TSStrong', 'TSEmphasis', 'TSUnderline', 'TSTitle', 'TSLiteral', 'TSURI'}

  local groups = {
    {boolean, c.lightblue},
    {constants, c.cyan},
    {constructors, c.white},
    {error, c.red, c.bg, s.NONE},
    {fields, c.cyan},
    {forwords, c.lightblue, c.none},
    {functions, c.lightblue},
    {includes, c.lightcyan},
    {keyword, c.lightblue},
    {labels, c.lightblue},
    {methods, c.lightblue},
    {namespaces, c.green:light()},
    {number, c.magenta},
    {operators, c.blue},
    {parameters, c.cyan},
    {punctuation, c.white},
    {string, c.green},
    {tags, c.blue:light()},
    {text, c.fg},
    {types, c.lightcyan},
    {variables, c.cyan},
  }

  local highlights = {}

  for _, group in ipairs(groups) do
    highlights = merge({highlights, highlight_to_groups({group[2], group[3], group[4]})(group[1])})
  end

  return merge({
    highlights,
    {
      {'TSPunctDelimiter', c.brightwhite},
      {'TSTagDelimiter', c.cyan},
      {'TSPunctSpecial', c.brightwhite},
      {'TSVariableBuiltin', c.brightwhite:dark(), c.none, s.NONE},
      {'TSConstBuiltin', c.brightwhite:dark(.3), c.none, s.NONE},
      {'TSTypeBuiltin', c.lightcyan, c.none, s.NONE},
      {'TSFuncBuiltin', c.magenta, c.none, s.NONE},
      {'TSVariableBuiltin', c.magenta},
      {'TSField', c.cyan},
    },
  })
end

M.use{}
