-- THIS FILE WAS AUTO-GENERATED (source fnl/init.fnl)
local g = vim.g
g.mapleader = " "
g.nord_minimal_mode = true
g.loaded_netrw = 1
g.netrw_loaded_netrwPlugin = 1
g.loaded_2html_plugin = false
g.loaded_gzip = false
g.loaded_man = false
g.loaded_matchit = false
g.loaded_netrwPlugin = false
g.loaded_remote_plugins = false
g.loaded_tarPlugin = false
g.loaded_zipPlugin = false
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
o.scrolloff = 1000
o.shadafile = "NONE"
o.shiftwidth = 2
o.showmode = false
o.sidescrolloff = 1000
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
local wk = require("which-key")
wk.register({c = {n = {("<cmd>" .. "cnext" .. "<cr>"), "next"}, name = "quickfix", o = {("<cmd>" .. "copen" .. "<cr>"), "open"}, p = {("<cmd>" .. "cprev" .. "<cr>"), "previous"}, q = {("<cmd>" .. "cclose" .. "<cr>"), "close"}}, f = {b = {("<cmd>" .. "Telescope" .. " " .. "buffers" .. "<cr>"), "buffers"}, e = {("<cmd>" .. "Dirvish" .. "<cr>"), "explore"}, f = {("<cmd>" .. "Telescope" .. " " .. "find_files" .. "<cr>"), "file"}, n = {("<cmd>" .. "enew" .. "<cr>"), "new"}, name = "find", r = {("<cmd>" .. "Telescope" .. " " .. "live_grep" .. "<cr>"), "grep"}}, g = {b = {("<cmd>" .. "Gitsigns" .. " " .. "blame_line" .. "<cr>"), "blame"}, h = {n = {("<cmd>" .. "Gitsigns" .. " " .. "next_hunk" .. "<cr>"), "next"}, name = "hunk", p = {("<cmd>" .. "Gitsigns" .. " " .. "prev_hunk" .. "<cr>"), "previous"}, r = {("<cmd>" .. "Gitsigns" .. " " .. "reset_hunk" .. "<cr>"), "reset"}, s = {("<cmd>" .. "Gitsigns" .. " " .. "stage_hunk" .. "<cr>"), "stage"}, u = {("<cmd>" .. "Gitsigns" .. " " .. "undo_stage_hunk" .. "<cr>"), "undo"}}, name = "git"}, l = {a = {("<cmd>lua vim.lsp." .. "buf.code_action" .. "()<cr>"), "actions"}, d = {n = {("<cmd>lua vim.lsp." .. "diagnostic.goto_next" .. "()<cr>"), "next"}, name = "diagnostics", p = {("<cmd>lua vim.lsp." .. "diagnostic.goto_prev" .. "()<cr>"), "previous"}}, f = {("<cmd>lua vim.lsp." .. "buf.formatting" .. "()<cr>"), "format"}, l = {("<cmd>lua vim.lsp." .. "diagnostic.show_line_diagnostics" .. "()<cr>"), "line"}, name = "lsp", r = {("<cmd>lua vim.lsp." .. "buf.rename" .. "()<cr>"), "rename"}}, p = {"\"*p<cr>", "paste"}, q = {("<cmd>" .. "q" .. "<cr>"), "quit"}, s = {a = {("<cmd>" .. "Awkward" .. "<cr>"), "awkward"}, f = {("<cmd>" .. "make | luafile lua/init.lua" .. "<cr>"), "source"}, l = {("<cmd>" .. "luafile" .. " " .. "%" .. "<cr>"), "lua"}, name = "misc", r = {("<cmd>" .. "lua require'plenary.reload'.reload_module('awkward')" .. "<cr>"), "reload"}, t = {("<cmd>" .. "10split | terminal" .. "<cr>"), "terminal"}, v = {("<cmd>" .. "vsplit" .. "<cr>"), "split"}}, t = {n = {("<cmd>" .. "tabnext" .. "<cr>"), "next"}, name = "tabs", p = {("<cmd>" .. "tabprevious" .. "<cr>"), "previous"}, t = {("<cmd>" .. "tabnew" .. "<cr>"), "new"}}, w = {("<cmd>" .. "up" .. "<cr>"), "save"}, y = {"\"*y<cr>", "copy"}}, {mode = "n", prefix = "<leader>"})
wk.register({H = {("<cmd>lua vim.lsp." .. "buf.hover" .. "()<cr>"), "hover"}, J = {"10j", "down"}, K = {"10k", "up"}, M = {"J", "merge"}, Q = {"<nop>", "nope"}, S = {("<cmd>" .. "HopWord" .. "<cr>"), "hopword"}, ["<c-h>"] = {"<c-w>h", "left"}, ["<c-l>"] = {"<c-w>l", "right"}, ["<esc>"] = {("<cmd>" .. "nohl" .. "<cr>"), "nohl"}, g = {d = {("<cmd>lua vim.lsp." .. "buf.definition" .. "()<cr>"), "definition"}, name = "goto", r = {("<cmd>lua vim.lsp." .. "buf.reference" .. "()<cr>"), "reference"}}, s = {("<cmd>" .. "HopChar2" .. "<cr>"), "hop"}}, {mode = "n"})
wk.register({J = {"10j", "down"}, K = {"10k", "up"}, ["<"] = {"<gv", "dedent"}, ["<c-l>"] = {"<nop>", "nope"}, ["<leader>p"] = {"\"*p", "paste"}, ["<leader>so"] = {":sort <bar>w<bar>e<cr>", "sort"}, ["<leader>y"] = {"\"*y", "copy"}, [">"] = {">gv", "indent"}}, {mode = "v"})
local function wkneorg()
  return wk.register({N = {"?[A-z]*.norg<cr>", "previous"}, ["<bs>"] = {"<c-o>", "back"}, ["<cr>"] = {("<cmd>" .. "e <cfile>" .. "<cr>"), "follow"}, ["<tab>"] = {"za", "fold"}, n = {"/[A-z]*.norg<cr>", "next"}}, {buffer = vim.api.nvim_get_current_buf(), mode = "n"})
end
_G.wkneorg = wkneorg
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
wk.setup({plugins = {spelling = {enabled = true}}, window = {margin = {1, 0, -1, 0}, padding = {2, 2, 2, 2}}})
local border = {{"\226\148\140", "FloatBorder"}, {"\226\148\128", "FloatBorder"}, {"\226\148\144", "FloatBorder"}, {"\226\148\130", "FloatBorder"}, {"\226\148\152", "FloatBorder"}, {"\226\148\128", "FloatBorder"}, {"\226\148\148", "FloatBorder"}, {"\226\148\130", "FloatBorder"}}
local function on_attach(client, bufnr)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border})
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.hover, {border = border})
  return nil
end
local function lsp()
  local lsp0 = require("lspconfig")
  lsp0.bashls.setup({on_attach = on_attach})
  lsp0.dockerls.setup({on_attach = on_attach})
  lsp0.rnix.setup({on_attach = on_attach})
  lsp0.solargraph.setup({on_attach = on_attach})
  lsp0.sorbet.setup({on_attach = on_attach})
  lsp0.terraformls.setup({on_attach = on_attach})
  lsp0.tsserver.setup({on_attach = on_attach})
  lsp0.texlab.setup({on_attach = on_attach})
  lsp0.yamlls.setup({on_attach = on_attach})
  return lsp0.gopls.setup({analyses = {staticcheck = true, unusedparams = true}, flags = {debounce_text_changes = 500}, on_attach = on_attach})
end
local function awkward()
  local awkward0 = require("awkward")
  return (awkward0).setup({})
end
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
  return (compe0).setup({autocomplete = true, debug = false, documentation = true, enabled = true, incomplete_delay = 400, max_abbr_width = 100, max_kind_width = 100, max_menu_width = 100, preselect = "disable", resolve_timeout = 800, source = {buffer = {kind = " \239\144\142"}, neorg = {kind = " \239\163\170"}, nvim_lsp = {kind = " \238\156\150"}, path = {kind = " \238\151\191"}, vsnip = {kind = " \239\131\132"}}, source_timeout = 200, throttle_time = 80})
end
local function telescope()
  local telescope0 = require("telescope")
  local sorters = require("telescope.sorters")
  local previewers = require("telescope.previewers")
  return (telescope0).setup({defaults = {border = {}, borderchars = {"\226\148\128", "\226\148\130", "\226\148\128", "\226\148\130", "\226\149\173", "\226\149\174", "\226\149\175", "\226\149\176"}, buffer_previewer_maker = previewers.buffer_previewer_maker, color_devicons = true, entry_prefix = "  ", file_ignore_patterns = {}, file_previewer = previewers.vim_buffer_cat.new, file_sorter = sorters.get_fuzzy_file, generic_sorter = sorters.get_generic_fuzzy_sorter, grep_previewer = previewers.vim_buffer_vimgrep.new, initial_mode = "insert", layout_config = {horizontal = {mirror = false}, vertical = {mirror = false}}, layout_strategy = "horizontal", path_display = {}, prompt_prefix = "\226\157\175 ", qflist_previewer = previewers.vim_buffer_qflist.new, selection_caret = "\226\134\146 ", selection_strategy = "reset", set_env = {COLORTERM = "truecolor"}, sorting_strategy = "descending", use_less = true, vimgrep_arguments = {"rg", "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case"}, winblend = 0}})
end
local function treesitter()
  local parsers = require("nvim-treesitter.parsers")
  local parser_configs = parsers.get_parser_configs()
  parser_configs.norg = {install_info = {branch = "main", files = {"src/parser.c"}, url = "https://github.com/vhyrro/tree-sitter-norg"}}
  local treesitter0 = require("nvim-treesitter.configs")
  return (treesitter0).setup({ensure_installed = {"bash", "clojure", "commonlisp", "dockerfile", "fennel", "go", "gomod", "graphql", "hcl", "html", "javascript", "latex", "lua", "nix", "norg", "ruby", "rust", "yaml", "zig"}, highlight = {enable = true}, indent = {enable = true}})
end
vim.cmd("colorscheme nordbuddy")
vim.cmd((("autocmd " .. "BufEnter" .. " " .. "*.graphql" .. " " .. "set ft=graphql" .. "\n") .. ("autocmd " .. "BufEnter" .. " " .. "*.lock" .. " " .. "set ft=json" .. "\n") .. ("autocmd " .. "BufEnter" .. " " .. "*.nix" .. " " .. "set ft=nix" .. "\n") .. ("autocmd " .. "BufEnter" .. " " .. "*.awkward" .. " " .. "Awkward" .. "\n") .. ("autocmd " .. "BufWrite" .. " " .. "*.awkward" .. " " .. "Awkward" .. "\n") .. ("autocmd " .. "FileType" .. " " .. "markdown" .. " " .. "setlocal spell" .. "\n") .. ("autocmd " .. "FileType" .. " " .. "gitcommit" .. " " .. "setlocal spell" .. "\n") .. ("autocmd " .. "FileType" .. " " .. "dirvish" .. " " .. "setlocal nonu" .. "\n") .. ("autocmd " .. "BufEnter" .. " " .. "*.norg" .. " " .. "hi clear Conceal | set nohls | lua wkneorg()" .. "\n") .. ("autocmd " .. "BufWrite" .. " " .. "*.go" .. " " .. "lua vim.lsp.buf.formatting()" .. "\n") .. ("autocmd " .. "TermOpen" .. " " .. "*" .. " " .. "setlocal nonumber nocursorline signcolumn=no laststatus=0" .. "\n") .. ("autocmd " .. "TermOpen" .. " " .. "*" .. " " .. "startinsert" .. "\n")))
local defer = vim.defer_fn
defer(awkward, 10)
defer(compe, 10)
defer(gitsigns, 10)
defer(lsp, 10)
defer(neorg, 10)
defer(treesitter, 10)
return defer(telescope, 10)
