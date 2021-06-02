-- maps are defined using whichkey
local whichkey = require'which-key'

local INSERT = 'i'
local LEADER = '<leader>'
local NORMAL = 'n'
local VISUAL = 'v'

whichkey.register({
  d = {
    name = "debug",
    c = { ":lua require'dap'.continue()<cr>", "Continue" },
    s = {
      name = "step",
      s = { ":lua require'dap'.step_over()<cr>", "Step Over" },
      i = { ":lua require'dap'.step_into()<cr>", "Step Into" },
      o = { ":lua require'dap'.step_out()<cr>", "Step Out" },
    },
    b = {
      name = "breakpoint",
      t = { ":lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
      s = { ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", "Set Breakpoint" },
      l = { ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", "Set Logpoint" },
    },
    r = { ":lua require'dap'.repl.open()<cr>", "REPL" },
    ["."] = { ":lua require'dap'.run_last()<cr>", "Run Last" },
  },
  f = {
    name = "file",
    e = { "<cmd>Explore<cr>", "File Explorer" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    n = { "<cmd>enew<cr>", "New File" },
    r = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    s = {
      name = "source",
      l = { "<cmd>luafile %<cr>", "Lua" },
    },
  },
  l = {
    name = "lsp",
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format Buffer" },
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Actions" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    d = {
      name = "diagnostics",
      n = { "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>", "Next Diagnostic" },
      p = { "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
      h = { "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", "Line Diagnostics" },
    },
  },
  t = {
    name = "tabs",
    t = { "<cmd>tabnew<cr>", "New Tab" },
    n = { "<cmd>tabnext<cr>", "Next Tab" },
    p = { "<cmd>tabprevious<cr>", "Previous Tab" },
  },
  c = {
    name = "quickfix",
    n = { "<cmd>cnext<cr>", "Next Item" },
    p = { "<cmd>cprev<cr>", "Previous Item" },
    q = { "<cmd>cclose<cr>", "Close List" },
    o = { "<cmd>copen<cr>", "Open List" },
  },
  s = {
    name = "search",
    r = { ":%s//g<left><left>", "Replace" }
  },
  q = { "<cmd>q<cr>", "Quit" },
  w = { "<cmd>w<cr>", "Save" },
  p = { "\"*p<cr>", "Paste" },
  y = { "\"*y<cr>", "Copy" },
}, { prefix = LEADER, mode = NORMAL })

whichkey.register({
  K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
  g = {
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
    r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto References" },
    c = "Commentary",
  },
  ["<bs>"] = { "-", "Back" },
  [";"] = {
    name = "test",
    f = { "<cmd>TestFile<cr>", "Test File" },
    l = { "<cmd>TestLast<cr>", "Test Last" },
    n = { "<cmd>TestNearest<cr>", "Test Nearest" },
    s = { "<cmd>TestSuite<cr>", "Test Suite" },
    v = { "<cmd>TestVisit<cr>", "Test Visit" },
  },
}, { mode = NORMAL })

_G.whichkeyvimwiki = function()
  whichkey.register({
    ["<cr>"] = { "<Plug>VimwikiFollowLink", "Follow Link" },
    ["<bs>"] = { "<Plug>VimwikiGoBackLink", "Back Link" },
    ["<c-o>"] = { "<Plug>VimwikiGoBackLink", "Back Link" },
    ["<tab>"] = { "<Plug>VimwikiNextLink", "Next Link" },
    ["<s-tab>"] = { "<Plug>VimwikiPrevLink", "Prev Link" },
    n = { "<Plug>VimwikiNextLink", "Next Link" },
    N = { "<Plug>VimwikiPrevLink", "Prev Link" },
    [","] = {
      t = {
        name = "task",
        d = { "<Plug>VimwikiToggleListItem", "Toggle Task" },
        n = { "<Plug>VimwikiNextTask", "Next Task" },
      },
    },
  }, { mode = NORMAL, buffer = vim.api.nvim_get_current_buf()})
end

whichkey.register({
  [","] = {
    name = "wiki",
    [","] = { "<Plug>VimwikiIndex", "Open Wiki" },
    n = { "<Plug>VimwikiGoto", "Goto Wiki Page" },
    x = { "<Plug>VimwikiDeleteFIle", "Delete Wiki Page" },
    r = { "<Plug>VimwikiRenameFIle", "Rename Wiki Page" },
  },
}, { mode = NORMAL })

whichkey.register({
  ["<"] = { "<gv", "Dedent" },
  [">"] = { ">gv", "Indent" },
  S = { ":s//g<left><left>", "Replace" },
  so = { ":sort <bar>w<bar>e<cr>", "Sort" },
  ["<leader>y"] = { "\"*y", "Copy" },
  ["<leader>p"] = { "\"*p", "Paste" },
}, { mode = VISUAL })

whichkey.setup {
  ignore_missing = false,
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
}
