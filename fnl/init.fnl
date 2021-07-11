;; LSP
(fn lsp []
  (local lsp (require :lspconfig))
  (lsp.bashls.setup {})
  (lsp.dockerls.setup {})
  (lsp.rnix.setup {})
  (lsp.solargraph.setup {})
  (lsp.sorbet.setup {})
  (lsp.terraformls.setup {})
  (lsp.tsserver.setup {})
  (lsp.texlab.setup {})
  (lsp.yamlls.setup {})
  (lsp.gopls.setup
    {:flags
     {:debounce_text_changes 500}
     :analyses
     {:unusedparams true
      :staticcheck true}}))

(vim.defer_fn lsp 10)

;; Mappings
(local wk (require :which-key))
(macro lua [module name]
  `(.. ":lua require'" ,module "'." ,name "()<cr>"))
(macro cmd [...]
  `(.. "<cmd>" (.. ,...) "<cr>"))
(macro pcmd [prefix cmd]
  `(.. "<cmd>" ,prefix (. " ") ,cmd "<cr>"))
(macro lsp [...]
  `(.. "<cmd>lua vim.lsp." (.. ,...) "()<cr>"))
(macro plug [...]
  `(.. "<Plug>" (.. ,...)))

; leader
(wk.register
  {:f {:name :find
       :b [(pcmd :Telescope :buffers) :buffers]
       :e [(cmd :Explore) :explore]
       :f [(pcmd :Telescope :find_files) :file]
       :n [(cmd :enew) :new]
       :r [(pcmd :Telescope :live_grep) :grep]}
   :d [:<c-d> :down]
   :u [:<c-u> :up]
   :s {:l [(pcmd :luafile :%) :lua]
       :s [(cmd :vsplit) :split]
       :i [(pcmd :luafile :lua/init.lua) :init]}
   :m [(cmd :make) :make]
   :l {:name :lsp
       :f [(lsp :buf.formatting) :format]
       :a [(lsp :buf.code_action) :actions]
       :r [(lsp :buf.rename) :rename]
       :l [(lsp :diagnostic.show_line_diagnostics) :line]
       :d {:name :diagnostics
           :n [(lsp :diagnostic.goto_next) :next]
           :p [(lsp :diagnostic.goto_prev) :previous]}}
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
   :w [(cmd :w) :save]
   :p ["\"*p<cr>" :paste]
   :y ["\"*y<cr>" :copy]}
  {:prefix :<leader> :mode :n})

; normal
(wk.register
  {:K [(lsp :buf.hover) :hover]
   :Q [:<nop> :nope]
   :gW [(cmd "w !sudo tee % > /dev/null") :suwrite]
   :<c-l> [:<c-w>l :right]
   :<c-h> [:<c-w>h :left]
   :<esc> [(cmd :nohl) :nohl]
   :s [(cmd :HopChar2) :hop]
   :S [(cmd :HopWord) :hopword]
   :g {:name :goto
       :d [(lsp :buf.definition) :definition]
       :r [(lsp :buf.reference) :reference]}}
  {:mode :n})

; visual
(wk.register
  {:< [:<gv :dedent]
   :> [:>gv :indent]
   :<c-l> [:<nop> :nope]
   :<leader>so [":sort <bar>w<bar>e<cr>" :sort]
   :<leader>y ["\"*y" :copy]
   :<leader>p ["\"*p" :paste]}
  {:mode :v})

; neorg
(set _G.wkneorg
     (fn []
       (wk.register
         {:<cr> [(cmd "e <cfile>") :follow]
          :<bs> [:<c-o> :back]
          :<tab> [:za :fold]
          :n ["/[A-z]*.norg<cr>" :next]
          :N ["?[A-z]*.norg<cr>" :previous]}
         {:mode :n :buffer (vim.api.nvim_get_current_buf)})))

(fn rtc [s]
  (vim.api.nvim_replace_termcodes s true true true))

(fn tab []
  (if (= 1 (vim.fn.pumvisible))
    (rtc "<c-n>")
    (rtc "<tab>")))

(fn s-tab []
  (if (= 1 (vim.fn.pumvisible))
    (rtc "<c-p>")
    (rtc "<s-tab>")))

(fn cr []
  ((. vim.fn :compe#confirm) "\n"))

; insert
(wk.register
  {:<tab> {1 tab 2 :next :expr true}
   :<s-tab> {1 s-tab 2 :previous :expr true}
   :<cr> {1 cr 2 :cr :expr true}}
  {:mode :i})

(wk.setup {:plugins {:spelling {:enabled true}}})

;; Options
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
(set o.omnifunc "v:lua.vim.lsp.omnifunc")
(set o.ruler true)
(set o.scrolloff 10)
(set o.shiftwidth 2)
(set o.showmode false)
(set o.signcolumn "yes")
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

;; Plugins
(fn gitsigns []
  (local gitsigns (require :gitsigns))
  ((. gitsigns :setup) {:keymaps {}}))

; neorg
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

; compe
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
    :source
    {:path true
     :buffer true
     :nvim_lsp true}}))

; treesitter
(fn treesitter []
  (local parsers (. (require :nvim-treesitter.parsers)))
  (local parser-configs ((. parsers :get_parser_configs)))
  (set parser-configs.norg
       {:install_info
        {:url "https://github.com/vhyrro/tree-sitter-norg"
         :files [:src/parser.c]
         :branch :main}})
  (local treesitter (require :nvim-treesitter.configs))
  ((. treesitter :setup)
   {:ensure_installed
    [:bash :clojure :commonlisp :dockerfile :fennel :go :gomod :graphql :hcl
     :html :javascript :latex :lua :nix :norg :ruby :rust :yaml :zig]
    :highlight {:enable true}
    :indent {:enable true}}))

(vim.defer_fn compe 10)
(vim.defer_fn gitsigns 10)
(vim.defer_fn neorg 10)
(vim.defer_fn treesitter 10)

;; Variables
(local g vim.g)
(set g.mapleader " ")
(set g.netrw_banner 0)
(set g.netrw_localcopycmdopt "-r")
(set g.netrw_localmkdiropt "-p")
(set g.netrw_localmovecmdopt "-r")
(set g.nord_minimal_mode true)

;; Colorscheme
(vim.cmd "colorscheme nordbuddy")

;; Autocmds
(macro autocmd [enter ft command]
  `(.. "autocmd " ,enter " " ,ft " " ,command "\n"))

(vim.cmd
  (..
    (autocmd :BufEnter :*.graphql "set ft=graphql")
    (autocmd :BufEnter :*.lock "set ft=json")
    (autocmd :BufEnter :*.nix "set ft=nix")
    (autocmd :FileType :fennel "set indentexpr=lisp")
    (autocmd :BufEnter :*.norg (.. "hi clear Conceal | "
                                   "set nohls foldmethod=indent | "
                                   "lua wkneorg()"))
    (autocmd :BufWrite :*.go "lua vim.lsp.buf.formatting()")
    (autocmd :CmdLineEnter :: "set nosmartcase")
    (autocmd :CmdLineLeave :: "set smartcase")
    (autocmd :TermOpen :* "setlocal nonumber nocursorline signcolumn=no")
    (autocmd :TermOpen :* "startinsert")))
