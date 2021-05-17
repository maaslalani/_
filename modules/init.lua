local o = vim.o
local g = vim.g
local cmd = vim.cmd

cmd 'autocmd BufEnter *.nix set ft=nix'
cmd 'autocmd BufEnter *.lock set ft=json'
cmd 'autocmd BufEnter *.graphql set ft=graphql'
cmd 'autocmd BufWrite *.go lua vim.lsp.buf.formatting()'
cmd 'autocmd CmdLineEnter : set nosmartcase'
cmd 'autocmd CmdLineLeave : set smartcase'
cmd 'autocmd TermOpen * setlocal nonumber signcolumn=no'

g.mapleader = ' '
g.completion_matching_strategy_list = "['exact', 'substring', 'fuzzy']"
g.diagnostic_auto_popup_while_jump = 0
g.diagnostic_enable_underline = 1
g.diagnostic_enable_virtual_text = 1
g.diagnostic_insert_delay = 0

g.netrw_banner = 0
g.netrw_localcopydircmd = 'cp -r'
g.netrw_localrmdir = 'rm -r'

o.autoindent = true
o.autoread = true
o.autowrite = true
o.backspace = 'indent,eol,start'
o.backup = false
o.cmdheight = 1
o.compatible = false
o.completeopt = 'menuone,noinsert,noselect'
o.concealcursor = ''
o.cursorline = true
o.diffopt = 'filler,internal,algorithm:histogram,indent-heuristic'
o.encoding = 'utf-8'
o.errorbells = false
o.expandtab = true
o.hidden = true
o.hlsearch = true
o.ignorecase = true
o.incsearch = true
o.laststatus = 2
o.lazyredraw = true
o.number = true
o.numberwidth = 1
o.omnifunc = 'v:lua.vim.lsp.omnifunc'
o.printfont = 'PragmataPro:h12'
o.ruler = true
o.shiftwidth = 2
o.shortmess = 'filnxtToOFc'
o.showcmd = true
o.showmode = false
o.signcolumn = 'yes'
o.smartcase = true
o.softtabstop = 2
o.splitbelow = true
o.splitright = true
o.statusline = '%<%t\\ %m%h\\ %=\\ %l,%c\\ %y'
o.swapfile = false
o.synmaxcol = 300
o.t_vb = ''
o.tabstop = 2
o.termguicolors = true
o.timeout = true
o.timeoutlen = 500
o.ttimeout = true
o.ttimeoutlen = 0
o.ttyfast = true
o.undofile = true
o.updatetime = 300
o.visualbell = true
o.wb = false
o.wildmenu = true
o.wildmode = 'longest:full,full'
o.wrap = false
o.writebackup = false

-- Nordbuddy
require'colorbuddy'.colorscheme'nordbuddy'

-- Autopairs
require'nvim-autopairs'.setup{}

-- Colorizer
require'colorizer'.setup{}

-- Gitsigns
require'gitsigns'.setup{}

-- Lualine
require'lualine'.setup{
  options = {
    theme = 'nord',
    icons_enabled = false,
  },
}

-- Treesitter
require'nvim-treesitter.configs'.setup{
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

-- LSP
local lsp = require'lspconfig'
local completion = require'completion'.on_attach

lsp.bashls.setup { on_attach = completion }
lsp.dockerls.setup { on_attach = completion }
lsp.omnisharp.setup { on_attach = completion }
lsp.rnix.setup { on_attach = completion }
lsp.solargraph.setup { on_attach = completion }
lsp.sorbet.setup { on_attach = completion }
lsp.terraformls.setup { on_attach = completion }
lsp.tsserver.setup { on_attach = completion }
lsp.gopls.setup {
  on_attach = completion,
  analyses = {
    unusedparams = true,
    staticcheck = true,
  },
}

local sumneko_root_path = "/Users/" .. vim.fn.expand('$USER') .. "/.config/nvim/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

lsp.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        globals = {'vim'}
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

-- Whichkey
local wk = require'which-key'

wk.register({
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
}, { prefix = "<leader>" })

wk.register({
  K = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
  g = {
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Goto Definition" },
    r = { "<cmd>lua vim.lsp.buf.references()<cr>", "Goto References" },
  },
  ["<bs>"] = { "-", "Back" },
})

wk.register({
  ["<"] = { "<gv", "Dedent" },
  [">"] = { ">gv", "Indent" },
  S = { ":s//g<left><left>", "Replace" },
  so = { ":sort <bar>w<bar>e<cr>", "Sort" }
}, { mode = "v" })

wk.register({
  ["<expr> <s-tab>"] = "pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"",
  ["<expr> <tab>"] = "pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"",
}, { mode = "i" })

wk.setup {
  ignore_missing = false,
}
