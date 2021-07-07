-- THIS FILE WAS AUTO-GENERATED
-- See fnl/init.fnl for source
local function lsp()
  local lsp0 = require("lspconfig")
  lsp0.bashls.setup({})
  lsp0.dockerls.setup({})
  lsp0.rnix.setup({})
  lsp0.solargraph.setup({})
  lsp0.sorbet.setup({})
  lsp0.terraformls.setup({})
  lsp0.tsserver.setup({})
  lsp0.texlab.setup({})
  lsp0.yamlls.setup({})
  return lsp0.gopls.setup({analyses = {staticcheck = true, unusedparams = true}, flags = {debounce_text_changes = 500}})
end
vim.defer_fn(lsp, 10)
local wk = require("which-key")
local _0_
do
  local prefix_0_ = "Telescope"
  local cmd_0_ = "find_files"
  _0_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _1_
do
  local prefix_0_ = "Telescope"
  local cmd_0_ = "live_grep"
  _1_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _2_
do
  local prefix_0_ = "Gitsigns"
  local cmd_0_ = "blame_line"
  _2_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _3_
do
  local prefix_0_ = "Gitsigns"
  local cmd_0_ = "next_hunk"
  _3_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _4_
do
  local prefix_0_ = "Gitsigns"
  local cmd_0_ = "prev_hunk"
  _4_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _5_
do
  local prefix_0_ = "Gitsigns"
  local cmd_0_ = "reset_hunk"
  _5_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _6_
do
  local prefix_0_ = "Gitsigns"
  local cmd_0_ = "stage_hunk"
  _6_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _7_
do
  local prefix_0_ = "luafile"
  local cmd_0_ = "%"
  _7_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
local _8_
do
  local prefix_0_ = "luafile"
  local cmd_0_ = "lua/init.lua"
  _8_ = ("<cmd>" .. prefix_0_ .. " " .. cmd_0_ .. "<cr>")
end
wk.register({c = {n = {("<cmd>" .. "cnext" .. "<cr>"), "next"}, name = "quickfix", o = {("<cmd>" .. "copen" .. "<cr>"), "open"}, p = {("<cmd>" .. "cprev" .. "<cr>"), "previous"}, q = {("<cmd>" .. "cclose" .. "<cr>"), "close"}}, f = {e = {("<cmd>" .. "Explore" .. "<cr>"), "explore"}, f = {_0_, "file"}, n = {("<cmd>" .. "enew" .. "<cr>"), "new"}, name = "find", r = {_1_, "grep"}}, g = {b = {_2_, "blame"}, h = {n = {_3_, "next"}, name = "hunk", p = {_4_, "previous"}, r = {_5_, "reset"}, s = {_6_, "stage"}}, name = "git"}, l = {a = {("<cmd>lua vim.lsp." .. "buf.code_action" .. "()<cr>"), "actions"}, d = {n = {("<cmd>lua vim.lsp." .. "diagnostic.goto_next" .. "()<cr>"), "next"}, name = "diagnostics", p = {("<cmd>lua vim.lsp." .. "diagnostic.goto_prev" .. "()<cr>"), "previous"}}, f = {("<cmd>lua vim.lsp." .. "buf.formatting" .. "()<cr>"), "format"}, l = {("<cmd>lua vim.lsp." .. "diagnostic.show_line_diagnostics" .. "()<cr>"), "line"}, name = "lsp", r = {("<cmd>lua vim.lsp." .. "buf.rename" .. "()<cr>"), "rename"}}, m = {("<cmd>" .. "make" .. "<cr>"), "make"}, p = {"\"*p<cr>", "paste"}, q = {("<cmd>" .. "q" .. "<cr>"), "quit"}, s = {l = {_7_, "lua"}, name = "source", v = {_8_, "init"}}, t = {n = {("<cmd>" .. "tabnext" .. "<cr>"), "next"}, name = "tabs", p = {("<cmd>" .. "tabprevious" .. "<cr>"), "previous"}, t = {("<cmd>" .. "tabnew" .. "<cr>"), "new"}}, w = {("<cmd>" .. "w" .. "<cr>"), "save"}, y = {"\"*y<cr>", "copy"}}, {mode = "n", prefix = "<leader>"})
wk.register({K = {("<cmd>lua vim.lsp." .. "buf.hover" .. "()<cr>"), "hover"}, Q = {"<nop>", "nope"}, ["<c-l>"] = {"<nop>", "nope"}, g = {d = {("<cmd>lua vim.lsp." .. "buf.definition" .. "()<cr>"), "definition"}, name = __fnl_global__goto, r = {("<cmd>lua vim.lsp." .. "buf.reference" .. "()<cr>"), "reference"}}, gW = {("<cmd>" .. "w !sudo tee % > /dev/null" .. "<cr>"), "suwrite"}}, {mode = "n"})
wk.register({["<"] = {"<gv", "dedent"}, ["<c-l>"] = {"<nop>", "nope"}, ["<leader>p"] = {"\"*p", "paste"}, ["<leader>so"] = {":sort <bar>w<bar>e<cr>", "sort"}, ["<leader>y"] = {"\"*y", "copy"}, [">"] = {">gv", "indent"}}, {mode = "v"})
local function _9_()
  return wk.register({N = {"?[A-z]*.norg<cr>", "previous"}, ["<bs>"] = {"<c-o>", "back"}, ["<cr>"] = {("<cmd>" .. "e <cfile>" .. "<cr>"), "follow"}, ["<s-tab>"] = {"?[A-z]*.norg<cr>", "previous"}, ["<tab>"] = {"/[A-z]*.norg<cr>", "next"}, n = {"/[A-z]*.norg<cr>", "next"}}, {buffer = vim.api.nvim_get_current_buf(), mode = "n"})
end
_G.wkneorg = _9_
wk.setup({ignore_missing = false, plugins = {spelling = {enabled = true, suggestions = 20}}})
local o = vim.o
o.autowrite = true
o.backspace = "indent,eol,start"
o.backup = false
o.completeopt = "menuone,noinsert,noselect"
o.cursorline = true
o.diffopt = "filler,internal,algorithm:histogram,indent-heuristic"
o.expandtab = true
o.hidden = true
o.ignorecase = true
o.laststatus = 2
o.lazyredraw = true
o.number = true
o.omnifunc = "v:lua.vim.lsp.omnifunc"
o.ruler = true
o.shiftwidth = 2
o.showmode = false
o.signcolumn = "yes"
o.smartcase = true
o.softtabstop = 2
o.splitbelow = true
o.splitright = true
o.swapfile = false
o.synmaxcol = 300
o.syntax = "off"
o.tabstop = 2
o.termguicolors = true
o.timeoutlen = 350
o.undofile = true
o.updatetime = 300
o.visualbell = true
o.wildmode = "longest:full,full"
o.wrap = false
o.writebackup = false
o.foldmethod = "marker"
o.foldmarker = "FOLD,ENDFOLD"
local function gitsigns()
  local gitsigns0 = require("gitsigns")
  return (gitsigns0).setup({keymaps = {}})
end
local function neorg()
  local neorg0 = require("neorg")
  return (neorg0).setup({load = {["core.defaults"] = {}, ["core.keybinds"] = {}, ["core.norg.concealer"] = {}, ["core.norg.dirman"] = {config = {autochdir = true, autodetect = true, workspaces = {wiki = "~/wiki"}}}}})
end
local function compe()
  local compe0 = require("compe")
  return (compe0).setup({autocomplete = true, debug = false, documentation = true, enabled = true, incomplete_delay = 400, max_abbr_width = 100, max_kind_width = 100, max_menu_width = 100, preselect = "disable", resolve_timeout = 800, source = {buffer = true, nvim_lsp = true, path = true}, source_timeout = 200, throttle_time = 80})
end
local function treesitter()
  local treesitter0 = require("nvim-treesitter.configs")
  return (treesitter0).setup({ensure_installed = {"bash", "clojure", "commonlisp", "dockerfile", "fennel", "go", "gomod", "graphql", "hcl", "html", "javascript", "latex", "lua", "nix", "ruby", "rust", "yaml", "zig"}, highlight = {enable = true}, indent = {enable = true}})
end
vim.defer_fn(compe, 10)
vim.defer_fn(gitsigns, 10)
vim.defer_fn(neorg, 10)
vim.defer_fn(treesitter, 10)
local g = vim.g
g.localcoptydircmd = "cp -r"
g.mapleader = " "
g.netrw_banner = 0
g.rmdir_cmd = "rm -r"
vim.cmd("colorscheme nordbuddy")
return vim.cmd("augroup autocommands\nautocmd BufEnter *.nix set ft=nix\nautocmd BufEnter *.lock set ft=json\nautocmd BufEnter *.graphql set ft=graphql\nautocmd BufWrite *.go lua vim.lsp.buf.formatting()\nautocmd BufEnter *.norg hi clear Conceal | set nohlsearch | lua wkneorg()\nautocmd CmdLineEnter : set nosmartcase\nautocmd CmdLineLeave : set smartcase\nautocmd TermOpen * setlocal nonumber nocursorline signcolumn=no\nautocmd TermOpen * startinsert\naugroup END")
