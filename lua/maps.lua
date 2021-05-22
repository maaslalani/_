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
  g = {
    name = "git",
    b = { "<cmd>Gitsigns blame_line<cr>", "Blame Line" },
    h = {
      name = "hunk",
      r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
      s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
      n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
      p = { "<cmd>Gitsigns prev_hunk<cr>", "Previous Hunk" },
    },
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
}, { mode = NORMAL })

whichkey.register({
  ["<"] = { "<gv", "Dedent" },
  [">"] = { ">gv", "Indent" },
  S = { ":s//g<left><left>", "Replace" },
  so = { ":sort <bar>w<bar>e<cr>", "Sort" },
  ["<leader>y"] = { "\"*y", "Copy" },
  ["<leader>p"] = { "\"*p", "Paste" },
}, { mode = VISUAL })

whichkey.register({
  ["<expr><cr>"] = { "compe#confirm('<cr>')", "Confirm" },
}, { mode = INSERT })


whichkey.setup {
  ignore_missing = false,
  plugins = {
    spelling = {
      enabled = true,
      suggestions = 20,
    },
  },
}
