local vim = vim
local lsp = require'nvim_lsp'
local completion = require'completion'

lsp.gopls.setup {
  on_attach = completion.on_attach,
  cmd = {'gopls', 'serve'},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

local servers = {
  'bashls',
  'dockerls',
  'omnisharp',
  'rnix',
  'solargraph',
  'sumneko_lua',
  'tsserver',
}

for _, server in pairs(servers) do
  lsp[server].setup { on_attach = completion.on_attach }
end

function Goimports()
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  local resp = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 1000)
  if resp and resp[1] and resp[1].result and resp[1].result[1] and resp[1].result[1].edit then
    vim.lsp.util.apply_workspace_edit(resp[1].result[1].edit)
  end
  vim.lsp.buf.formatting()
end

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
  local themeColors = {
    '#2E3440',
    '#3B4252',
    '#434C5E',
    '#4C566A',
    '#D8DEE9',
    '#E5E9F0',
    '#ECEFF4',
    '#8FBCBB',
    '#88C0D0',
    '#81A1C1',
    '#5E81AC',
    '#BF616A',
    '#D08770',
    '#EBCB8B',
    '#A3BE8C',
    '#B48EAD',
  }

  for i, color in ipairs(themeColors) do Color.new('nord' .. i - 1, color) end
  Color.new('fg', '#D8DEE9')
  Color.new('bg', '#2E3440')
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
    {'Boolean',c.nord9,c.none,s.NONE},
    {'Character',c.nord14,c.none,s.NONE},
    {'ColorColumn', c.none, c.nord1},
    {'Comment',c.nord3,c.none,s.NONE},
    {'Conceal',c.nord3,c.none},
    {'Conditional',c.nord9,c.none,s.NONE},
    {'Constant',c.nord4,c.none,s.NONE},
    {'Cursor', c.nord0, c.nord4},
    {'CursorColumn',c.nord1,c.none,s.NONE},
    {'CursorLine', c.none, c.nord0},
    {'CursorLineNr',c.nord5,c.none,s.NONE},
    {'Define',c.nord9,c.none,s.NONE},
    {'Delimiter',c.nord6,c.none,s.NONE},
    {'Directory',c.nord8,c.none,s.NONE},
    {'EndOfBuffer',c.none, c.none},
    {'Error',c.nord11,c.none,s.bold},
    {'ErrorMsg',c.nord5,c.nord11,s.bold},
    {'Exception',c.nord9,c.none,s.NONE},
    {'Float',c.nord15,c.none,s.NONE},
    {'Function',c.nord8,c.none,s.NONE},
    {'Function',c.nord8,c.none,s.bold},
    {'Identifier',c.nord4,c.none,s.NONE},
    {'Include',c.nord9,c.none,s.NONE},
    {'Keyword',c.nord9,c.none,s.NONE},
    {'Label',c.nord9,c.none,s.NONE},
    {'Line',c.nord12,c.none,s.bold},
    {'LineNr',c.nord3,c.none,s.NONE},
    {'MatchParen',c.nord8,c.nord3},
    {'NonText',c.none,c.none},
    {'Normal',c.fg,c.bg},
    {'Number',c.nord15,c.none,s.NONE},
    {'Operator',c.nord9,c.none,s.NONE},
    {'PMenu',c.nord4,c.nord2},
    {'PMenuSel',c.nord6,c.nord9},
    {'PmenuSbar',c.nord4,c.nord2},
    {'PmenuThumb',c.nord8,c.nord3},
    {'PreProc',c.nord9,c.none,s.NONE},
    {'Repeat',c.nord9,c.none,s.NONE},
    {'SignColumn',c.none,c.none,s.NONE},
    {'Special',c.nord4,c.none,s.NONE},
    {'SpecialChar',c.nord13,c.none,s.NONE},
    {'SpecialComment',c.nord8,c.none,s.NONE},
    {'SpecialKey',c.nord3,c.nord3},
    {'SpellBad',c.nord11,c.nord0},
    {'SpellCap',c.nord13,c.nord0},
    {'SpellLocal',c.nord5,c.nord0},
    {'SpellRare',c.nord6,c.nord0},
    {'Statement',c.nord9,c.none,s.NONE},
    {'StorageClass',c.nord9,c.none,s.NONE},
    {'String',c.nord14,c.none,s.NONE},
    {'Structure',c.nord9,c.none,s.NONE},
    {'TabLine',c.nord4,c.nord2},
    {'TabLineSel',c.fg,c.nord10,s.bold},
    {'TabLineSelSeparator',c.nord10,c.none},
    {'TabLineSeparator',c.nord2,c.none},
    {'Tag',c.nord4,c.none,s.NONE},
    {'Title',c.nord4,c.none},
    {'Todo',c.nord13,c.none,s.NONE},
    {'Type',c.nord9,c.none,s.italic},
    {'Typedef',c.nord9,c.none,s.NONE},
    {'VertSplit',c.nord3,c.none},
    {'Visual',c.nord4,c.nord2},
    {'VisualNOS',c.nord2,c.nord1},
    {'WarningMsg',c.nord5,c.nord12,s.bold},
    {'iCursor',c.nord0, c.nord4},
    {'GitGutterAdd',c.nord14, c.none},
    {'GitGutterChange',c.nord13, c.none},
    {'GitGutterDelete',c.nord11, c.none},
    {'GitGutterChangeDelete',c.nord11, c.none},
  }

  return merge({
    vim_groups,
    M:lsp(),
    M:treesitter(),
    M:telescope(),
  })
end

function M:lsp()
  return {
    {'LspDiagnosticsDefaultHint', c.nord10, c.none},
    {'LspDiagnosticsDefaultError', c.nord11, c.none},
    {'LspDiagnosticsDefaultWarning', c.nord13, c.none},
    {'LspDiagnosticsDefaultInformation', c.nord8, c.none},
  }
end

function M:telescope()
  return {
    {'TelescopeNormal', c.nord4, c.nord0},
    {'TelescopePromptPrefix', c.fg:dark(.2)},
    {'TelescopeSelection', c.nord6:light(), c.nord3, s.bold},
    {'TelescopeMatching', c.nord6:light()},
  }
end

function M:treesitter()
  local error = {'TSError'}
  local punctuation = {'TSPunctDelimiter', 'TSPunctBracket', 'TSPunchSpecial'}
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
    {error, c.nord1:light(), c.nord9:dark(.5), s.none},
    {punctuation, c.nord3:dark(.35)},
    {constants, c.nord5:light()},
    {string, c.nord10:light():light():saturate(.25)},
    {boolean, c.nord2:light()},
    {functions, c.nord14},
    {methods, c.nord14:light(.1), c.none, s.italic},
    {fields, c.nord8:light()},
    {number, c.nord6:light()},
    {parameters, c.nord6:dark()},
    {operators, c.nord3:dark():dark()},
    {forwords, c.nord8:saturate(.1):light(), c.none},
    {keyword, c.nord4:dark(.2):saturate(.01):light(.2), c.none, s.italic},
    {constructors, c.nord10},
    {types, c.nord10},
    {includes, c.nord4},
    {labels, c.nord4:light()},
    {namespaces, c.nord14:light()},
    {variables, c.nord10:light(.2)},
    {tags, c.nord10:light()},
    {text, c.fg},
  }

  local highlights = {}

  for _, group in ipairs(groups) do
    highlights = merge({highlights, highlight_to_groups({group[2], group[3], group[4]})(group[1])})
  end

  return merge({
    highlights,
    {
      {'TSPunctDelimiter', c.nord3:dark():dark():saturate(.1)},
      {'TSTagDelimiter', c.nord8:dark(.15)},
      {'TSPunctSpecial', c.nord12:dark():dark():light(.3)},
      {'TSVariableBuiltin', c.nord6:dark(), c.none, s.bold},
      {'TSConstBuiltin', c.nord6:dark(.3), c.none, s.bold},
      {'TSTypeBuiltin', c.nord10:dark(.2), c.none, s.bold},
      {'TSFuncBuiltin', c.nord8:light(.1), c.none, s.bold},
      {'TSVariableBuiltin', c.nord12:dark(.2)},
      {'TSField', c.nord8},
    },
  })
end

M.use{}
