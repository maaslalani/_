;; =============================================================================
;; AUTOCMDS
;; =============================================================================
(vim.cmd "augroup autocommands
autocmd BufEnter *.nix set ft=nix
autocmd BufEnter *.lock set ft=json
autocmd BufEnter *.graphql set ft=graphql
autocmd BufWrite *.go lua vim.lsp.buf.formatting()
autocmd BufEnter *.norg hi clear Conceal | set nohlsearch | lua wkneorg()
autocmd CmdLineEnter : set nosmartcase
autocmd CmdLineLeave : set smartcase
autocmd TermOpen * setlocal nonumber nocursorline signcolumn=no
autocmd TermOpen * startinsert
augroup END")

;; =============================================================================
;; LSP
;; =============================================================================
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

;; zzz (lazy load)
(vim.defer_fn lsp 50)

;; =============================================================================
;; MAPPINGS
;; =============================================================================
(local wk (require :which-key))
(macro lua [module name]
  `(let [name# ,name module# ,module]
     (.. ":lua require'" module# "'." name# "()<cr>")))
(macro cmd [...]
  `(.. "<cmd>" (.. ,...) "<cr>"))
(macro pcmd [prefix cmd]
  `(let [prefix# ,prefix cmd# ,cmd]
     (.. "<cmd>" prefix# (. " ") cmd# "<cr>")))
(macro lsp [...]
  `(.. "<cmd>lua vim.lsp." (.. ,...) "()<cr>"))
(macro plug [...]
  `(.. "<Plug>" (.. ,...)))

(wk.register
  {
   :f {:name :find
       :e [(cmd :Explore) :explore]
       :f [(pcmd :Telescope :find_files) :file]
       :n [(cmd :enew) :new]
       :r [(pcmd :Telescope :live_grep) :grep]}
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
           :n [(pcmd :Gitsigns :next_hunk) :next]
           :p [(pcmd :Gitsigns :prev_hunk) :previous]}}
   :r [":%s//g<left><left>" :replace]
   :q [(cmd :q) :quit]
   :w [(cmd :w) :save]
   :Q [(cmd :q!) :quit!]
   :W [(cmd :w!) :save!]
   :p ["\"*p<cr>" :paste]
   :y ["\"*y<cr>" :copy]}
  {:prefix :<leader> :mode :n})

(wk.register
  {
   :K [(lsp :buf.hover) :hover]
   :g {:name goto
       :d [(lsp :buf.definition) :definition]
       :r [(lsp :buf.reference) :reference]}
   :<bs> ["-" :back]}
  {:mode :n})

(wk.register
  {:< [:<gv :dedent]
   :> [:>gv :indent]
   :<leader>so [":sort <bar>w<bar>e<cr>" :sort]
   :<leader>y ["\"*y" :copy]
   :<leader>p ["\"*p" :paste]}
  {:mode :v})

(wk.register
  {:<tab> ["pumvisible() ? \"\\<c-n>\" : \"\\<tab>\"" "Next Completion"]
   :<s-tab> ["pumvisible() ? \"\\<c-p>\" : \"\\<s-tab>\"" "Previous Completion"]}
  {:mode :i :expr true})

(wk.register
  {",," [(cmd ":e ~/wiki/index.norg") :neorg]}
  {:mode :n})

(set _G.wkneorg
     (fn []
       (wk.register
         {:<cr> [(cmd "e <cfile>") :follow]
          :<bs> [:<c-o> :back]
          :<tab> ["/[A-z]*.norg<cr>" :next]
          :<s-tab> ["?[A-z]*.norg<cr>" :previous]
          :n ["/[A-z]*.norg<cr>" :next]
          :N ["?[A-z]*.norg<cr>" :previous]}
         {:mode :n :buffer (vim.api.nvim_get_current_buf)})))

(wk.setup
  {:ignore_missing false
   :plugins {:spelling {:enabled true :suggestions 20}}})

;; =============================================================================
;; OPTIONS
;; =============================================================================
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
(set o.laststatus 0)
(set o.lazyredraw true)
(set o.number true)
(set o.omnifunc "v:lua.vim.lsp.omnifunc")
(set o.ruler false)
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

;; =============================================================================
;; PLUGINS
;; =============================================================================
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
    :source
      {:path true
      :buffer true
      :nvim_lsp true}}))

(fn treesitter []
  (local treesitter (require :nvim-treesitter.configs))
  ((. treesitter :setup)
    {:ensure_installed [
      :bash
      :clojure
      :commonlisp
      :dockerfile
      :fennel
      :go :gomod
      :graphql
      :hcl
      :html
      :javascript
      :latex
      :lua
      :nix
      :ruby
      :rust
      :yaml
      :zig]
    :highlight {:enable true}
    :indent {:enable true}}))

(vim.defer_fn compe 50)
(vim.defer_fn gitsigns 50)
(vim.defer_fn neorg 50)
(vim.defer_fn treesitter 50)

;; =============================================================================
;; VARIABLES
;; =============================================================================
(local g vim.g)
(set g.diagnostic_auto_popup_while_jump 0)
(set g.diagnostic_enable_underline 1)
(set g.diagnostic_enable_virtual_text 1)
(set g.diagnostic_insert_delay 0)
(set g.localcoptydircmd "cp -r")
(set g.mapleader " ")
(set g.netrw_banner 0)
(set g.rmdir_cmd "rm -r")
(set g.syntax_cmd :skip)
(set g.completion_chain_complete_list
     {:default
      {:comment {}
       :default
         [{:complete_items [:lsp :snippet]}
         {:mode :<c-p>}
         {:mode :<c-n>}]
       :string [{:complete_items [:path]}]}})
