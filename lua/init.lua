-- THIS FILE WAS AUTO-GENERATED
-- See fnl/init.fnl for source
vim.api.nvim_command("augroup AutoCmds\nautocmd BufEnter *.nix set ft=nix\nautocmd BufEnter *.lock set ft=json\nautocmd BufEnter *.graphql set ft=graphql\nautocmd BufWrite *.go lua vim.lsp.buf.formatting()\nautocmd BufEnter *.norg hi clear Conceal | set nohlsearch | lua wkneorg()\nautocmd CmdLineEnter : set nosmartcase\nautocmd CmdLineLeave : set smartcase\nautocmd TermOpen * setlocal nonumber nocursorline signcolumn=no\nautocmd TermOpen * startinsert\naugroup END")
local lsp = require("lspconfig")
lsp.bashls.setup({})
lsp.dockerls.setup({})
lsp.rnix.setup({})
lsp.solargraph.setup({})
lsp.sorbet.setup({})
lsp.terraformls.setup({})
lsp.tsserver.setup({})
lsp.texlab.setup({})
lsp.yamlls.setup({})
lsp.gopls.setup({analyses = {staticcheck = true, unusedparams = true}, flags = {debounce_text_changes = 500}})
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
wk.register({Q = {("<cmd>" .. "q!" .. "<cr>"), "quit!"}, W = {("<cmd>" .. "w!" .. "<cr>"), "save!"}, c = {n = {("<cmd>" .. "cnext" .. "<cr>"), "next"}, name = "quickfix", o = {("<cmd>" .. "copen" .. "<cr>"), "open"}, p = {("<cmd>" .. "cprev" .. "<cr>"), "previous"}, q = {("<cmd>" .. "cclose" .. "<cr>"), "close"}}, f = {e = {("<cmd>" .. "Explore" .. "<cr>"), "explore"}, f = {_0_, "file"}, n = {("<cmd>" .. "enew" .. "<cr>"), "new"}, name = "find", r = {_1_, "grep"}}, g = {b = {_2_, "blame"}, h = {n = {_3_, "next"}, name = "hunk", p = {_4_, "previous"}, r = {_5_, "reset"}, s = {_6_, "stage"}}, name = "git"}, l = {a = {("<cmd>lua vim.lsp." .. "buf.code_action" .. "()<cr>"), "actions"}, d = {n = {("<cmd>lua vim.lsp." .. "diagnostic.goto_next" .. "()<cr>"), "next"}, name = "diagnostics", p = {("<cmd>lua vim.lsp." .. "diagnostic.goto_prev" .. "()<cr>"), "previous"}}, f = {("<cmd>lua vim.lsp." .. "buf.formatting" .. "()<cr>"), "format"}, l = {("<cmd>lua vim.lsp." .. "diagnostic.show_line_diagnostics" .. "()<cr>"), "line"}, name = "lsp", r = {("<cmd>lua vim.lsp." .. "buf.rename" .. "()<cr>"), "rename"}}, p = {"\"*p<cr>", "paste"}, q = {("<cmd>" .. "q" .. "<cr>"), "quit"}, r = {":%s//g<left><left>", "replace"}, t = {n = {("<cmd>" .. "tabnext" .. "<cr>"), "next"}, name = "tabs", p = {("<cmd>" .. "tabprevious" .. "<cr>"), "previous"}, t = {("<cmd>" .. "tabnew" .. "<cr>"), "new"}}, w = {("<cmd>" .. "w" .. "<cr>"), "save"}, y = {"\"*y<cr>", "copy"}}, {mode = "n", prefix = "<leader>"})
wk.register({K = {("<cmd>lua vim.lsp." .. "buf.hover" .. "()<cr>"), "hover"}, ["<bs>"] = {"-", "back"}, g = {d = {("<cmd>lua vim.lsp." .. "buf.definition" .. "()<cr>"), "definition"}, name = __fnl_global__goto, r = {("<cmd>lua vim.lsp." .. "buf.reference" .. "()<cr>"), "reference"}}}, {mode = "n"})
wk.register({["<"] = {"<gv", "dedent"}, ["<leader>p"] = {"\"*p", "paste"}, ["<leader>so"] = {":sort <bar>w<bar>e<cr>", "sort"}, ["<leader>y"] = {"\"*y", "copy"}, [">"] = {">gv", "indent"}}, {mode = "v"})
wk.register({["<s-tab>"] = {"pumvisible() ? \"\\<c-p>\" : \"\\<s-tab>\"", "Previous Completion"}, ["<tab>"] = {"pumvisible() ? \"\\<c-n>\" : \"\\<tab>\"", "Next Completion"}}, {expr = true, mode = "i"})
wk.register({[",,"] = {("<cmd>" .. ":e ~/wiki/index.norg" .. "<cr>"), "neorg"}}, {mode = "n"})
local function _7_()
  return wk.register({N = {"?[A-z]*.norg<cr>", "previous"}, ["<bs>"] = {"<c-o>", "back"}, ["<cr>"] = {("<cmd>" .. "e <cfile>" .. "<cr>"), "follow"}, ["<s-tab>"] = {"?[A-z]*.norg<cr>", "previous"}, ["<tab>"] = {"/[A-z]*.norg<cr>", "next"}, n = {"/[A-z]*.norg<cr>", "next"}}, {buffer = vim.api.nvim_get_current_buf(), mode = "n"})
end
_G.wkneorg = _7_
wk.setup({ignore_missing = false, plugins = {spelling = {enabled = true, suggestions = 20}}})
vim.o.autoindent = true
vim.o.autoread = true
vim.o.autowrite = true
vim.o.backspace = "indent,eol,start"
vim.o.backup = false
vim.o.cmdheight = 1
vim.o.compatible = false
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.concealcursor = ""
vim.o.cursorline = true
vim.o.diffopt = "filler,internal,algorithm:histogram,indent-heuristic"
vim.o.encoding = "utf-8"
vim.o.errorbells = false
vim.o.expandtab = true
vim.o.hidden = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.laststatus = 2
vim.o.lazyredraw = true
vim.o.number = true
vim.o.numberwidth = 1
vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"
vim.o.ruler = true
vim.o.shiftwidth = 2
vim.o.showcmd = true
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.synmaxcol = 300
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.timeout = true
vim.o.timeoutlen = 350
vim.o.ttimeout = true
vim.o.ttimeoutlen = 0
vim.o.ttyfast = true
vim.o.undofile = true
vim.o.updatetime = 300
vim.o.visualbell = true
vim.o.wb = false
vim.o.wildmenu = true
vim.o.wildmode = "longest:full,full"
vim.o.wrap = false
vim.o.writebackup = false
local colorbuddy = require("colorbuddy")
local lualine = require("lualine")
local treesitter = require("nvim-treesitter.configs")
local gitsigns = require("gitsigns")
local neorg = require("neorg")
local compe = require("compe")
colorbuddy.colorscheme("nordbuddy")
lualine.setup({options = {theme = "nord"}})
treesitter.setup({highlight = {enable = true}, indent = {enable = true}})
gitsigns.setup({keymaps = {}})
neorg.setup({load = {["core.defaults"] = {}, ["core.keybinds"] = {}, ["core.norg.concealer"] = {}, ["core.norg.dirman"] = {config = {autochdir = true, autodetect = true, workspaces = {wiki = "~/wiki"}}}}})
compe.setup({autocomplete = true, debug = false, documentation = true, enabled = true, incomplete_delay = 400, max_abbr_width = 100, max_kind_width = 100, max_menu_width = 100, preselect = "disable", resolve_timeout = 800, source = {buffer = true, nvim_lsp = true, path = true}, source_timeout = 200, throttle_time = 80})
vim.g.mapleader = " "
vim.g.diagnostic_auto_popup_while_jump = 0
vim.g.diagnostic_enable_underline = 1
vim.g.diagnostic_enable_virtual_text = 1
vim.g.diagnostic_insert_delay = 0
vim.g.netrw_banner = 0
vim.g.localcoptydircmd = "cp -r"
vim.g.rmdir_cmd = "rm -r"
vim.g.completion_chain_complete_list = {default = {comment = {}, default = {{complete_items = {"lsp", "snippet"}}, {mode = "<c-p>"}, {mode = "<c-n>"}}, string = {{complete_items = {"path"}}}}}
return nil
