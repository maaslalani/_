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
wk.register({c = {n = {("<cmd>" .. "cnext" .. "<cr>"), "next"}, name = "quickfix", o = {("<cmd>" .. "copen" .. "<cr>"), "open"}, p = {("<cmd>" .. "cprev" .. "<cr>"), "previous"}, q = {("<cmd>" .. "cclose" .. "<cr>"), "close"}}, d = {"<c-d>", "down"}, f = {b = {("<cmd>" .. "Telescope" .. " " .. "buffers" .. "<cr>"), "buffers"}, e = {("<cmd>" .. "Explore" .. "<cr>"), "explore"}, f = {("<cmd>" .. "Telescope" .. " " .. "find_files" .. "<cr>"), "file"}, n = {("<cmd>" .. "enew" .. "<cr>"), "new"}, name = "find", r = {("<cmd>" .. "Telescope" .. " " .. "live_grep" .. "<cr>"), "grep"}}, g = {b = {("<cmd>" .. "Gitsigns" .. " " .. "blame_line" .. "<cr>"), "blame"}, h = {n = {("<cmd>" .. "Gitsigns" .. " " .. "next_hunk" .. "<cr>"), "next"}, name = "hunk", p = {("<cmd>" .. "Gitsigns" .. " " .. "prev_hunk" .. "<cr>"), "previous"}, r = {("<cmd>" .. "Gitsigns" .. " " .. "reset_hunk" .. "<cr>"), "reset"}, s = {("<cmd>" .. "Gitsigns" .. " " .. "stage_hunk" .. "<cr>"), "stage"}, u = {("<cmd>" .. "Gitsigns" .. " " .. "undo_stage_hunk" .. "<cr>"), "undo"}}, name = "git"}, l = {a = {("<cmd>lua vim.lsp." .. "buf.code_action" .. "()<cr>"), "actions"}, d = {n = {("<cmd>lua vim.lsp." .. "diagnostic.goto_next" .. "()<cr>"), "next"}, name = "diagnostics", p = {("<cmd>lua vim.lsp." .. "diagnostic.goto_prev" .. "()<cr>"), "previous"}}, f = {("<cmd>lua vim.lsp." .. "buf.formatting" .. "()<cr>"), "format"}, l = {("<cmd>lua vim.lsp." .. "diagnostic.show_line_diagnostics" .. "()<cr>"), "line"}, name = "lsp", r = {("<cmd>lua vim.lsp." .. "buf.rename" .. "()<cr>"), "rename"}}, m = {("<cmd>" .. "make" .. "<cr>"), "make"}, p = {"\"*p<cr>", "paste"}, q = {("<cmd>" .. "q" .. "<cr>"), "quit"}, s = {i = {("<cmd>" .. "luafile" .. " " .. "lua/init.lua" .. "<cr>"), "init"}, l = {("<cmd>" .. "luafile" .. " " .. "%" .. "<cr>"), "lua"}, s = {("<cmd>" .. "vsplit" .. "<cr>"), "split"}}, t = {n = {("<cmd>" .. "tabnext" .. "<cr>"), "next"}, name = "tabs", p = {("<cmd>" .. "tabprevious" .. "<cr>"), "previous"}, t = {("<cmd>" .. "tabnew" .. "<cr>"), "new"}}, u = {"<c-u>", "up"}, w = {("<cmd>" .. "w" .. "<cr>"), "save"}, y = {"\"*y<cr>", "copy"}}, {mode = "n", prefix = "<leader>"})
wk.register({K = {("<cmd>lua vim.lsp." .. "buf.hover" .. "()<cr>"), "hover"}, Q = {"<nop>", "nope"}, S = {("<cmd>" .. "HopWord" .. "<cr>"), "hopword"}, ["<c-h>"] = {"<c-w>h", "left"}, ["<c-l>"] = {"<c-w>l", "right"}, ["<esc>"] = {("<cmd>" .. "nohl" .. "<cr>"), "nohl"}, g = {d = {("<cmd>lua vim.lsp." .. "buf.definition" .. "()<cr>"), "definition"}, name = "goto", r = {("<cmd>lua vim.lsp." .. "buf.reference" .. "()<cr>"), "reference"}}, gW = {("<cmd>" .. "w !sudo tee % > /dev/null" .. "<cr>"), "suwrite"}, s = {("<cmd>" .. "HopChar2" .. "<cr>"), "hop"}}, {mode = "n"})
wk.register({["<"] = {"<gv", "dedent"}, ["<c-l>"] = {"<nop>", "nope"}, ["<leader>p"] = {"\"*p", "paste"}, ["<leader>so"] = {":sort <bar>w<bar>e<cr>", "sort"}, ["<leader>y"] = {"\"*y", "copy"}, [">"] = {">gv", "indent"}}, {mode = "v"})
local function _0_()
  return wk.register({N = {"?[A-z]*.norg<cr>", "previous"}, ["<bs>"] = {"<c-o>", "back"}, ["<cr>"] = {("<cmd>" .. "e <cfile>" .. "<cr>"), "follow"}, ["<tab>"] = {"za", "fold"}, n = {"/[A-z]*.norg<cr>", "next"}}, {buffer = vim.api.nvim_get_current_buf(), mode = "n"})
end
_G.wkneorg = _0_
local function rtc(s)
  return vim.api.nvim_replace_termcodes(s, true, true, true)
end
local function tab()
  if (1 == vim.fn.pumvisible()) then
    return rtc("<c-n>")
  else
    return rtc("<tab>")
  end
end
local function s_tab()
  if (1 == vim.fn.pumvisible()) then
    return rtc("<c-p>")
  else
    return rtc("<s-tab>")
  end
end
local function cr()
  return vim.fn["compe#confirm"]("\n")
end
wk.register({["<cr>"] = {cr, "cr", expr = true}, ["<s-tab>"] = {s_tab, "previous", expr = true}, ["<tab>"] = {tab, "next", expr = true}}, {mode = "i"})
wk.setup({plugins = {spelling = {enabled = true}}})
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
o.scrolloff = 10
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
  return (compe0).setup({autocomplete = true, debug = false, documentation = true, enabled = true, incomplete_delay = 400, max_abbr_width = 100, max_kind_width = 100, max_menu_width = 100, preselect = "disable", resolve_timeout = 800, source = {buffer = true, neorg = true, nvim_lsp = true, path = true}, source_timeout = 200, throttle_time = 80})
end
local function treesitter()
  local parsers = require("nvim-treesitter.parsers")
  local parser_configs = parsers.get_parser_configs()
  parser_configs.norg = {install_info = {branch = "main", files = {"src/parser.c"}, url = "https://github.com/vhyrro/tree-sitter-norg"}}
  local treesitter0 = require("nvim-treesitter.configs")
  return (treesitter0).setup({ensure_installed = {"bash", "clojure", "commonlisp", "dockerfile", "fennel", "go", "gomod", "graphql", "hcl", "html", "javascript", "latex", "lua", "nix", "norg", "ruby", "rust", "yaml", "zig"}, highlight = {enable = true}, indent = {enable = true}})
end
vim.defer_fn(compe, 10)
vim.defer_fn(gitsigns, 10)
vim.defer_fn(neorg, 10)
vim.defer_fn(treesitter, 10)
local g = vim.g
g.mapleader = " "
g.netrw_banner = 0
g.netrw_localcopycmdopt = "-r"
g.netrw_localmkdiropt = "-p"
g.netrw_localmovecmdopt = "-r"
g.nord_minimal_mode = true
vim.cmd("colorscheme nordbuddy")
return vim.cmd((("autocmd " .. "BufEnter" .. " " .. "*.graphql" .. " " .. "set ft=graphql" .. "\n") .. ("autocmd " .. "BufEnter" .. " " .. "*.lock" .. " " .. "set ft=json" .. "\n") .. ("autocmd " .. "BufEnter" .. " " .. "*.nix" .. " " .. "set ft=nix" .. "\n") .. ("autocmd " .. "FileType" .. " " .. "fennel" .. " " .. "set indentexpr=lisp" .. "\n") .. ("autocmd " .. "BufEnter" .. " " .. "*.norg" .. " " .. "hi clear Conceal | set nohls | lua wkneorg()" .. "\n") .. ("autocmd " .. "BufWrite" .. " " .. "*.go" .. " " .. "lua vim.lsp.buf.formatting()" .. "\n") .. ("autocmd " .. "TermOpen" .. " " .. "*" .. " " .. "setlocal nonumber nocursorline signcolumn=no" .. "\n") .. ("autocmd " .. "TermOpen" .. " " .. "*" .. " " .. "startinsert" .. "\n")))
