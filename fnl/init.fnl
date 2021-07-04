(module neovim
  {require {nvim aniseed.nvim}})

;;
;; AUTOCMD
;;
(macro autocmd [...]
  `(nvim.ex.autocmd ,...))

;; buffers
(autocmd :BufEnter :*.nix "set ft=nix")
(autocmd :BufEnter :*.lock "set ft=json")
(autocmd :BufEnter :*.graphql "set ft=graphql")
(autocmd :BufWrite :*.go "lua vim.lsp.buf.formatting()")

;; neorg
(autocmd :BufEnter :*.norg "hi clear Conceal | set nohlsearch | lua wkneorg()")

;; cmd lines
(autocmd :CmdLineEnter :: "set nosmartcase")
(autocmd :CmdLineLeave :: "set smartcase")

;; terminal
(autocmd :TermOpen :* "setlocal nonumber nocursorline signcolumn=no")
(autocmd :TermOpen :* "startinsert")

;;
;; LSP
;;
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

;; gopls
(lsp.gopls.setup
  {:flags
   {:debounce_text_changes 500}
   :analyses
   {:unusedparams true
    :staticcheck true}})

;;
;; MAPPINGS
;;
(local wk (require :which-key))

;; macros
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

;; leader mappings
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

;; normal mappings
(wk.register
  {
   :K [(lsp :buf.hover) :hover]
   :g {:name goto
       :d [(lsp :buf.definition) :definition]
       :r [(lsp :buf.reference) :reference]}
   :<bs> ["-" :back]}
  {:mode :n})

;; visual mappings
(wk.register
  {:< [:<gv :dedent]
   :> [:>gv :indent]
   :<leader>so [":sort <bar>w<bar>e<cr>" :sort]
   :<leader>y ["\"*y" :copy]
   :<leader>p ["\"*p" :paste]}
  {:mode :v})

;; tab completion
(wk.register
  {:<tab> ["pumvisible() ? \"\\<c-n>\" : \"\\<tab>\"" "Next Completion"]
   :<s-tab> ["pumvisible() ? \"\\<c-p>\" : \"\\<s-tab>\"" "Previous Completion"]}
  {:mode :i :expr true})

;; global neorg mappings
(wk.register
  {",," [(cmd ":e ~/wiki/index.norg") :neorg]}
  {:mode :n})

;; buffer neorg mappings
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

;;
;; OPTIONS
;;
(set nvim.o.autoindent true)
(set nvim.o.autoread true)
(set nvim.o.autowrite true)
(set nvim.o.backspace "indent,eol,start")
(set nvim.o.backup false)
(set nvim.o.cmdheight 1)
(set nvim.o.compatible false)
(set nvim.o.completeopt "menuone,noinsert,noselect")
(set nvim.o.concealcursor "")
(set nvim.o.cursorline true)
(set nvim.o.diffopt "filler,internal,algorithm:histogram,indent-heuristic")
(set nvim.o.encoding "utf-8")
(set nvim.o.errorbells false)
(set nvim.o.expandtab true)
(set nvim.o.hidden true)
(set nvim.o.hlsearch true)
(set nvim.o.ignorecase true)
(set nvim.o.incsearch true)
(set nvim.o.laststatus 2)
(set nvim.o.lazyredraw true)
(set nvim.o.number true)
(set nvim.o.numberwidth 1)
(set nvim.o.omnifunc "v:lua.vim.lsp.omnifunc")
(set nvim.o.ruler true)
(set nvim.o.shiftwidth 2)
;; (set nvim.o.shortmess opt.shortmess + "c")
(set nvim.o.showcmd true)
(set nvim.o.showmode false)
(set nvim.o.signcolumn "yes")
(set nvim.o.smartcase true)
(set nvim.o.softtabstop 2)
(set nvim.o.splitbelow true)
(set nvim.o.splitright true)
(set nvim.o.swapfile false)
(set nvim.o.synmaxcol 300)
(set nvim.o.tabstop 2)
(set nvim.o.termguicolors true)
(set nvim.o.timeout true)
(set nvim.o.timeoutlen 350)
(set nvim.o.ttimeout true)
(set nvim.o.ttimeoutlen 0)
(set nvim.o.ttyfast true)
(set nvim.o.undofile true)
(set nvim.o.updatetime 300)
(set nvim.o.visualbell true)
(set nvim.o.wb false)
(set nvim.o.wildmenu true)
(set nvim.o.wildmode "longest:full,full")
(set nvim.o.wrap false)
(set nvim.o.writebackup false)

;;
;; PLUGINS
;;
;; nordbuddy
((. (require :colorbuddy) :colorscheme) :nordbuddy)	

;; autopairs
((. (require :nvim-autopairs) :setup))	

;; lualine
((. (require :lualine) :setup) {:options {:theme :nord}})

;; treesitter
((. (require :nvim-treesitter.configs) :setup)
 {:highlight {:enable true}
  :indent {:enable true}})	

;; gitsigns
((. (require :gitsigns) :setup) {:keymaps {}})

;; neorg
((. (require :neorg) :setup)
 {:load
  {:core.defaults {}
   :core.norg.concealer {}
   :core.keybinds {}
   :core.norg.dirman
   {:config
    {:workspaces
     {:wiki "~/wiki"}
     :autodetect true
     :autochdir true}}}})	

;; nvim-compe
((. (require :compe) :setup)
 {:enabled true
  :autocomplete true
  :debug false
  :preselect :enable
  :throttle_time 80
  :source_timeout 200
  :resolve_timeout 800
  :incomplete_delay 400
  :max_abbr_width 100
  :max_kind_width 100
  :max_menu_width 100
  :documentation true
  :source {:path true :buffer true :nvim_lsp true }})

;;
;; VARIABLES
;;
;; <Space>
(set nvim.g.mapleader " ")

;; diagnostic options
(set nvim.g.diagnostic_auto_popup_while_jump 0)
(set nvim.g.diagnostic_enable_underline 1)
(set nvim.g.diagnostic_enable_virtual_text 1)
(set nvim.g.diagnostic_insert_delay 0)

;; netrw options
(set nvim.g.netrw_banner 0)
(set nvim.g.localcoptydircmd "cp -r")
(set nvim.g.rmdir_cmd "rm -r")

;; completion
(set nvim.g.completion_chain_complete_list
     {:default
      {:comment {}
       :default [{:complete_items [:lsp :snippet]}
                 {:mode :<c-p>}
                 {:mode :<c-n>}]
       :string [{:complete_items [:path]}]}})
