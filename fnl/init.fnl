(local g vim.g)
(set g.loaded_2html_plugin false)
(set g.loaded_gzip false)
(set g.loaded_man false)
(set g.loaded_matchit false)
(set g.loaded_remote_plugins false)
(set g.loaded_tarPlugin false)
(set g.loaded_zipPlugin false)
(set g.mapleader " ")
(set g.nord_minimal_mode true)

(local o vim.o)
(set o.autowrite true)
(set o.backspace "indent,eol,start")
(set o.backup false)
(set o.completeopt "menuone,noinsert,noselect")
(set o.cursorline true)
(set o.diffopt "filler,internal,algorithm:histogram,indent-heuristic")
(set o.expandtab true)
(set o.hidden true)
(set o.ignorecase true)
(set o.laststatus 2)
(set o.lazyredraw true)
(set o.number true)
(set o.omnifunc :v:lua.vim.lsp.omnifunc)
(set o.ruler true)
(set o.scrolloff 1000)
(set o.shadafile :NONE)
(set o.shiftwidth 2)
(set o.showmode false)
(set o.sidescrolloff 1000)
(set o.signcolumn :yes)
(set o.smartcase true)
(set o.softtabstop 2)
(set o.splitbelow true)
(set o.splitright true)
(set o.swapfile false)
(set o.synmaxcol 300)
(set o.syntax :off)
(set o.tabstop 2)
(set o.termguicolors true)
(set o.timeoutlen 350)
(set o.undofile true)
(set o.updatetime 300)
(set o.visualbell true)
(set o.wildmode "longest:full,full")
(set o.wrap false)
(set o.writebackup false)

(local wk (require :which-key))
(macro lua [module name]
  `(.. ":lua require'" ,module "'." ,name "()<cr>"))
(macro cmd [...]
  `(.. "<cmd>" (.. ,...) "<cr>"))
(macro pcmd [prefix cmd]
  `(.. "<cmd>" ,prefix (. " ") ,cmd "<cr>"))
(macro lspcmd [...]
  `(.. "<cmd>lua vim.lsp." (.. ,...) "()<cr>"))
(macro plug [...]
  `(.. "<Plug>" (.. ,...)))

(wk.register
  {:f {:name :find
       :b [(pcmd :Telescope :buffers) :buffers]
       :e [(cmd :Explore) :explore]
       :f [(pcmd :Telescope :find_files) :file]
       :n [(cmd :enew) :new]
       :r [(pcmd :Telescope :live_grep) :grep]}
   :s {:name :misc
       :a [(cmd :Awkward) :awkward]
       :l [(pcmd :luafile :%) :lua]
       :v [(cmd :vsplit) :split]
       :t [(cmd "10split | terminal") :terminal]
       :r [(cmd "lua require'plenary.reload'.reload_module('awkward')") :reload]
       :f [(cmd "make | luafile lua/init.lua") :source]}
   :l {:name :lsp
       :f [(lspcmd :buf.formatting) :format]
       :a [(lspcmd :buf.code_action) :actions]
       :r [(lspcmd :buf.rename) :rename]
       :l [(lspcmd :diagnostic.show_line_diagnostics) :line]
       :d {:name :diagnostics
           :n [(lspcmd :diagnostic.goto_next) :next]
           :p [(lspcmd :diagnostic.goto_prev) :previous]}}
   :t {:name :tabs
       :t [(cmd :tabnew) :new]
       :n [(cmd :tabnext) :next]
       :p [(cmd :tabprevious) :previous]}
   :c {:name :quickfix
       :n [(cmd :cnext) :next]
       :p [(cmd :cprev) :previous]
       :q [(cmd :cclose) :close]
       :o [(cmd :copen) :open]}
   :g {:name :git
       :b [(pcmd :Gitsigns :blame_line) :blame]
       :h {:name :hunk
           :r [(pcmd :Gitsigns :reset_hunk) :reset]
           :s [(pcmd :Gitsigns :stage_hunk) :stage]
           :u [(pcmd :Gitsigns :undo_stage_hunk) :undo]
           :n [(pcmd :Gitsigns :next_hunk) :next]
           :p [(pcmd :Gitsigns :prev_hunk) :previous]}}
   :q [(cmd :q) :quit]
   :w [(cmd :up) :save]
   :W [(cmd "w ! sudo tee % >/dev/null") :save!]
   :p ["\"*p<cr>" :paste]
   :y ["\"*y<cr>" :copy]}
  {:prefix :<leader> :mode :n})

(wk.register
  {:<c-h> [:<c-w>h :left]
   :<c-l> [:<c-w>l :right]
   :<esc> [(cmd :nohl) :nohl]
   :H [(lspcmd :buf.hover) :hover]
   :J [:10j :down]
   :K [:10k :up]
   :M ["mzJ'z" :merge]
   :Q [:<nop> :nope]
   :S [(cmd :HopWord) :hopword]
   :s [(cmd :HopChar2) :hop]
   :g {:name :goto
       :d [(lspcmd :buf.definition) :definition]
       :r [(lspcmd :buf.reference) :reference]}}
  {:mode :n})

(wk.register
  {:< [:<gv :dedent]
   :<c-l> [:<nop> :nope]
   :<leader>so [":sort <bar>w<bar>e<cr>" :sort]
   :<leader>y ["\"*y" :copy]
   :> [:>gv :indent]
   :<leader>p ["\"*p" :paste]
   :J [:10j :down]
   :K [:10k :up]}
  {:mode :v})

(fn wkneorg []
  (wk.register
    {:<cr> [(cmd "e <cfile>") :follow]
     :<bs> [:<c-o> :back]
     :<tab> [:za :fold]
     :n ["/[A-z]*.norg<cr>" :next]
     :N ["?[A-z]*.norg<cr>" :previous]}
    {:mode :n :buffer (vim.api.nvim_get_current_buf)}))
(set _G.wkneorg wkneorg)

(fn rtc [s]
  (vim.api.nvim_replace_termcodes s true true true))

(fn tab []
  (if (= 1 (vim.fn.pumvisible))
    (rtc :<c-n>)
    (rtc :<tab>)))

(fn s-tab []
  (if (= 1 (vim.fn.pumvisible))
    (rtc :<c-p>)
    (rtc :<s-tab>)))

(fn cr []
  ((. vim.fn :compe#confirm) "\n"))

(wk.register
  {:<tab> {1 tab 2 :next :expr true}
   :<s-tab> {1 s-tab 2 :previous :expr true}
   :<cr> {1 cr 2 :cr :expr true}
   "," [",<c-g>u" ","]
   :! [:!<c-g>u :!]
   :. [:.<c-g>u :.]
   :? [:?<c-g>u :?]}
  {:mode :i})

(wk.setup {:window {:margin [1 0 -1 0] :padding [2 2 2 2]}
           :plugins {:spelling {:enabled true}}})

(local border
  [[:┌ :FloatBorder]
   [:─ :FloatBorder]
   [:┐ :FloatBorder]
   [:│ :FloatBorder]
   [:┘ :FloatBorder]
   [:─ :FloatBorder]
   [:└ :FloatBorder]
   [:│ :FloatBorder]])	

(fn on_attach [client bufnr]
  (tset vim.lsp.handlers :textDocument/hover
        (vim.lsp.with vim.lsp.handlers.hover {: border}))
  (tset vim.lsp.handlers :textDocument/signatureHelp
        (vim.lsp.with vim.lsp.handlers.hover {: border})))	

(fn lsp []
  (local lsp (require :lspconfig))
  (lsp.bashls.setup {:on_attach on_attach})
  (lsp.dockerls.setup {:on_attach on_attach})
  (lsp.rnix.setup {:on_attach on_attach})
  (lsp.solargraph.setup {:on_attach on_attach})
  (lsp.sorbet.setup {:on_attach on_attach})
  (lsp.terraformls.setup {:on_attach on_attach})
  (lsp.tsserver.setup {:on_attach on_attach})
  (lsp.texlab.setup {:on_attach on_attach})
  (lsp.yamlls.setup {:on_attach on_attach})
  (lsp.gopls.setup
    {:flags
     {:debounce_text_changes 500}
     :analyses
     {:unusedparams true
      :staticcheck true}
     :on_attach on_attach}))

(fn awkward []
  (local awkward (require :awkward))
  ((. awkward :setup) {}))

(fn gitsigns []
  (local gitsigns (require :gitsigns))
  ((. gitsigns :setup) {:keymaps {}}))

(fn neorg []
  (local neorg (require :neorg))
  ((. neorg :setup)
   {:load
    {:core.defaults {}
     :core.norg.concealer {}
     :core.keybinds {}
     :core.norg.dirman
     {:config
      {:workspaces
       {:wiki "~/wiki"}
       :autodetect true
       :autochdir true}}}}))

(fn compe []
  (local compe (require :compe))
  ((. compe :setup)
   {:enabled true
    :autocomplete true
    :debug false
    :preselect :disable
    :throttle_time 80
    :source_timeout 200
    :resolve_timeout 800
    :incomplete_delay 400
    :max_abbr_width 100
    :max_kind_width 100
    :max_menu_width 100
    :documentation true
    :source {:path {:kind " "}
             :buffer {:kind " "}
             :neorg {:kind " "}
             :vsnip {:kind " "}
             :nvim_lsp {:kind " "}}}))

(fn telescope []
  (local telescope (require :telescope))
  (local sorters (require :telescope.sorters))
  (local previewers (require :telescope.previewers))
  ((. telescope :setup)
   {:defaults
    {:border {}
     :borderchars [:─ :│ :─ :│  :╭ :╮ :╯ :╰]
     :buffer_previewer_maker (. previewers :buffer_previewer_maker)
     :color_devicons true
     :entry_prefix "  "
     :file_ignore_patterns {}
     :file_previewer (. (. previewers :vim_buffer_cat) :new)
     :file_sorter (. sorters :get_fuzzy_file)
     :generic_sorter (. sorters :get_generic_fuzzy_sorter)
     :grep_previewer (. (. previewers :vim_buffer_vimgrep) :new)
     :initial_mode :insert
     :layout_config {:horizontal {:mirror false} :vertical {:mirror false}}
     :layout_strategy :horizontal
     :path_display {}
     :prompt_prefix "❯ "
     :qflist_previewer (. (. previewers :vim_buffer_qflist) :new)
     :selection_caret "→ "
     :selection_strategy :reset
     :set_env {:COLORTERM :truecolor}
     :sorting_strategy :descending
     :use_less true
     :vimgrep_arguments [:rg
                         :--color=never
                         :--no-heading
                         :--with-filename
                         :--line-number
                         :--column
                         :--smart-case]
     :winblend 0 }}))

(fn treesitter []
  (local parsers (. (require :nvim-treesitter.parsers)))
  (local parser-configs ((. parsers :get_parser_configs)))
  (set parser-configs.norg
       {:install_info
        {:url :https://github.com/vhyrro/tree-sitter-norg
         :files [:src/parser.c]
         :branch :main}})
  (local treesitter (require :nvim-treesitter.configs))
  ((. treesitter :setup)
   {:ensure_installed
    [:bash
     :clojure
     :commonlisp
     :dockerfile
     :fennel
     :go
     :gomod
     :graphql
     :hcl
     :html
     :javascript
     :latex
     :lua
     :nix
     :norg
     :ruby
     :rust
     :yaml
     :zig]
    :highlight {:enable true}
    :indent {:enable true}}))

(vim.cmd "colorscheme nordbuddy")

(macro autocmd [enter ft command]
  `(.. "autocmd " ,enter " " ,ft " " ,command "\n"))

(vim.cmd
  (.. (autocmd :BufEnter :*.graphql "set ft=graphql")
      (autocmd :BufEnter :*.lock "set ft=json")
      (autocmd :BufEnter :*.nix "set ft=nix")
      (autocmd :BufEnter :*.awkward "Awkward")
      (autocmd :BufWrite :*.awkward "Awkward")
      (autocmd :FileType :markdown "setlocal spell")
      (autocmd :FileType :gitcommit "setlocal spell")
      (autocmd :BufEnter :*.norg "hi clear Conceal | set nohls | lua wkneorg()")
      (autocmd :BufWrite :*.go "lua vim.lsp.buf.formatting()")
      (autocmd :TermOpen :* "setlocal nonumber nocursorline signcolumn=no laststatus=0")
      (autocmd :TermOpen :* "startinsert")))

(local defer vim.defer_fn)
(defer awkward 10)
(defer compe 10)
(defer gitsigns 10)
(defer lsp 10)
(defer neorg 10)
(defer treesitter 10)
(defer telescope 10)
