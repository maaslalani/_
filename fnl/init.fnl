;; ============================================================================
;; Neovim
;; ============================================================================

;; Variables
(local g vim.g)
(set g.loaded_2html_plugin false)
(set g.loaded_gzip false)
(set g.loaded_man false)
(set g.loaded_matchit false)
(set g.loaded_remote_plugins false)
(set g.loaded_tarPlugin false)
(set g.loaded_zipPlugin false)
(set g.mapleader " ")
(set g.netrw_banner 0)
(set g.nord_minimal_mode true)
(set g.markdown_fenced_languages
     [:bash :css :erb=ruby :go :javascript :js=javascript :ruby :vim])

;; Options
(local o vim.o)
(set o.autowrite true)
(set o.backspace "indent,eol,start")
(set o.backup false)
(set o.completeopt "menuone,noselect")
(set o.conceallevel 2)
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

;; Macros
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
(macro autocmd [enter ft command]
  `(.. "autocmd " ,enter " " ,ft " " ,command "\n"))

;; Whichkey
(local wk (require :which-key))

; leader
(wk.register
  {:f {:name :find
       :b [(pcmd :Telescope :buffers) :buffers]
       :e [(cmd :Explore) :explore]
       :f [(pcmd :Telescope :find_files) :file]
       :n [(cmd :enew) :new]
       :r [(pcmd :Telescope :live_grep) :grep]}
   :o [(cmd "!open <cWORD>") :open]
   :s {:name :misc
       :a [(cmd :Awkward) :awkward]
       :l [(pcmd :luafile :%) :lua]
       :v [(cmd :vsplit) :split]
       :t [(cmd "10split | terminal") :terminal]
       :r [(cmd "lua require'plenary.reload'.reload_module('awkward')") :reload]}
   :n [(cmd "tabnew ~/wiki/index.norg") :wiki]
   :l {:name :lsp
       :f [(lspcmd :buf.formatting) :format]
       :a [(lspcmd :buf.code_action) :actions]
       :l ["<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = 'single'})<cr>" :diagnostics]
       :r [(lspcmd :buf.rename) :rename]}
   :t {:name :+prefix
       :t [(cmd :tabnew) :new]
       :n [(cmd :tabnext) :next]
       :p [(cmd :tabprevious) :previous]
       :o [(cmd "tab split") :tabsplit]
       :f [(cmd :TestFile) :file]
       :l [(cmd :TestLast) :last]
       :s [(cmd :TestSuite) :suite]
       :v [(cmd :TestVisit) :visit]}
   :c {:name :quickfix
       :n [(cmd :cnext) :next]
       :p [(cmd :cprev) :previous]
       :q [(cmd :cclose) :close]
       :o [(cmd :copen) :open]}
   :g {:name :git
       :b [(pcmd :Gitsigns :blame_line) :blame]
       :g [(cmd :Git) :fugitive]
       :h {:name :hunk
           :r [(pcmd :Gitsigns :reset_hunk) :reset]
           :s [(pcmd :Gitsigns :stage_hunk) :stage]
           :u [(pcmd :Gitsigns :undo_stage_hunk) :undo]
           :n [(pcmd :Gitsigns :next_hunk) :next]
           :p [(pcmd :Gitsigns :prev_hunk) :previous]}}
   :q [(cmd :q) :quit]
   :w [(cmd :up) :save]
   :W [(cmd "w ! sudo tee % >/dev/null") :save!]
   := ["migg=G`i" :indent]
   :p ["\"*p<cr>" :paste]
   :y ["\"*y<cr>" :copy]}
  {:prefix :<leader> :mode :n})

; normal
(wk.register
  {:<c-h> [:<c-w>h :left]
   :<c-j> [:<c-w>j :down]
   :<c-k> [:<c-w>k :up]
   :<c-l> [:<c-w>l :right]
   :<esc> [(cmd :nohl) :nohl]
   :H [(lspcmd :buf.hover) :hover]
   :J [:10j :down]
   :K [:10k :up]
   :M ["mzJ`z" :merge]
   :Q [:<nop> :nope]
   :S [(cmd :HopWord) :hopword]
   :s [(cmd :HopChar2) :hop]
   :g {:name :goto
       :d [(lspcmd :buf.definition) :definition]
       :r [(lspcmd :buf.references) :references]}}
  {:mode :n})

; visual
(wk.register
  {:< [:<gv :dedent]
   :<c-l> [:<nop> :nope]
   :s [":sort <bar>w<bar>e<cr>" :sort]
   :<leader>y ["\"*y" :copy]
   :> [:>gv :indent]
   :<leader>p ["\"*p" :paste]
   :J [:10j :down]
   :K [:10k :up]}
  {:mode :v})

; insert
(wk.register
  {"," [",<c-g>u" ","]
   :! [:!<c-g>u :!]
   :. [:.<c-g>u :.]
   :? [:?<c-g>u :?]}
  {:mode :i})

(wk.setup {:window {:margin [1 0 -1 0] :padding [2 2 2 2]}
           :plugins {:spelling {:enabled true}}})

;; Language Server Protocol
(var capabilities (vim.lsp.protocol.make_client_capabilities))
(set capabilities
     ((. (require :cmp_nvim_lsp) :update_capabilities) capabilities))

(fn on_attach [client bufnr]
  (tset vim.lsp.handlers :textDocument/hover
        (vim.lsp.with vim.lsp.handlers.hover {:border :single}))
  (tset vim.lsp.handlers :textDocument/signatureHelp
        (vim.lsp.with vim.lsp.handlers.hover {:border :single})))

(fn lsp []
  (local lsp (require :lspconfig))
  (lsp.bashls.setup {:on_attach on_attach :capabilities capabilities})
  (lsp.dockerls.setup {:on_attach on_attach :capabilities capabilities})
  (lsp.rnix.setup {:on_attach on_attach :capabilities capabilities})
  (lsp.solargraph.setup
    {:on_attach on_attach
     :capabilities capabilities
     :flags {:debounce_text_changes 150}
     :settings
     {:solargraph
      {:diagnostics true
       :formatting true}}})
  (lsp.sorbet.setup
    {:cmd [:srb :tc :--lsp :--enable-all-experimental-lsp-features :--disable-watchman]
     :root_dir (lsp.util.root_pattern :sorbet/)
     :on_attach on_attach
     :capabilities capabilities
     :init_options
     {:documentFormatting false
      :codeAction true}})
  (lsp.terraformls.setup {:on_attach on_attach :capabilities capabilities})
  (lsp.texlab.setup {:on_attach on_attach :capabilities capabilities})
  (lsp.tsserver.setup {:on_attach on_attach :capabilities capabilities})
  (lsp.yamlls.setup {:on_attach on_attach :capabilities capabilities})
  (lsp.gopls.setup
    {:flags
     {:debounce_text_changes 500}
     :analyses
     {:unusedparams true
      :staticcheck true}
     :on_attach on_attach
     :capabilities capabilities}))

;; awkward
(fn awkward []
  (local awkward (require :awkward))
  ((. awkward :setup) {}))

;; hop
(fn hop []
  (local hop (require :hop))
  ((. hop :setup) {:keys :arstqwfpzxcvneio}))

;; gitsigns
(fn gitsigns []
  (local gitsigns (require :gitsigns))
  ((. gitsigns :setup) {:keymaps {}}))

;; neorg
(fn neorg []
  (local neorg (require :neorg))
  ((. neorg :setup)
   {:load
    {:core.defaults {}
     :core.norg.concealer {}
     :core.norg.completion { :config { :engine :nvim-cmp } }
     :core.keybinds { :config { :default_keybinds false } }
     :core.integrations.telescope {}
     :core.norg.dirman
     {:config
      {:workspaces
       {:wiki "~/wiki"}
       :autodetect true
       :autochdir true}}}}))

(local neorg-callbacks (require :neorg.callbacks))
(neorg-callbacks.on_event
  :core.keybinds.events.enable_keybinds
  (fn [_ keybinds]
    (keybinds.map_event_to_mode
      :norg
      {:n [[:td :core.norg.qol.todo_items.todo.task_done]
           [:tu :core.norg.qol.todo_items.todo.task_undone]
           [:tp :core.norg.qol.todo_items.todo.task_pending]
           [:tt :core.norg.qol.todo_items.todo.task_cycle]
           [:<cr> :core.norg.esupports.goto_link]
           [:<c-n> :core.norg.dirman.new.note]
           [:n :core.integrations.treesitter.next.heading]
           [:N :core.integrations.treesitter.previous.heading]
           [:<c-s> :core.integrations.telescope.find_linkable]]
       :i [[:<c-l> :core.integrations.telescope.insert_link]]}
      {:silent true :noremap true})))

;; cmp
(fn rtc [s]
  (vim.api.nvim_replace_termcodes s true true true))

(fn completion []
  (local cmp (require :cmp))
  (local luasnip (require :luasnip))

  (cmp.setup
    {:snippet
     {:expand (fn [args] ((. luasnip :lsp_expand) args.body))}
     :documentation
     {:border [:┌ :─ :┐ :│ :┘ :─ :└ :│]}
     :mapping
     {:<CR> (cmp.mapping.confirm {:select true})	
      :<S-P (fn s-tab [fallback]
                 (if (cmp.visible) (cmp.select_prev_item)
                   (luasnip.jumpable (- 1))
                   (vim.fn.feedkeys (rtc :<Plug>luasnip-jump-prev) "")
                   (fallback)))
      :<C-N> (fn tab [fallback]
               (if (cmp.visible) (cmp.select_next_item)
                 (luasnip.expand_or_jumpable)
                 (vim.fn.feedkeys (rtc :<Plug>luasnip-expand-or-jump) "")
                 (fallback)))}
     :sources [{:name :nvim_lsp}
               {:name :path}
               {:name :luasnip}
               {:name :buffer :keyword_length 4}
               {:name :neorg}]})

  (local cmp-autopairs (. (require :nvim-autopairs.completion.cmp)))
  (cmp.event:on :confirm_done (cmp-autopairs.on_confirm_done {:map_char {:tex ""}}))	
  ((. (require :luasnip/loaders/from_vscode) :load)
   {:include [:fennel :go :javascript :lua :nix :rails :react :ruby :rust]}))

;; colorizer
(fn colorizer []
  (. (require :colorizer) :setup))

;; comment-nvim
(fn comment-nvim []
  ((. (. (require :Comment)) :setup)))

;; telescope
(fn telescope []
  (local telescope (require :telescope))
  (local sorters (require :telescope.sorters))
  (local previewers (require :telescope.previewers))
  ((. telescope :setup)
   {:defaults
    {:buffer_previewer_maker (. previewers :buffer_previewer_maker)
     :entry_prefix "  "
     :file_ignore_patterns [:sorbet]
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
     :vimgrep_arguments [:rg :--vimgrep]
     :winblend 0}}))

;; treesitter
(fn treesitter []
  (local parsers (. (require :nvim-treesitter.parsers)))
  (local parser-configs ((. parsers :get_parser_configs)))
  (set parser-configs.norg
       {:install_info
        {:url :https://github.com/nvim-neorg/tree-sitter-norg
         :files [:src/parser.c :src/scanner.cc]
         :branch :main}})
  (local treesitter (require :nvim-treesitter.configs))
  ((. treesitter :setup)
   {:ensure_installed
    [:bash :clojure :commonlisp :dockerfile :fennel :go :gomod :graphql :hcl
     :html :javascript :latex :lua :nix :norg :ruby :rust :yaml :zig]
    :highlight {:enable true}
    :indent {:enable true}}))

; autopairs
(fn autopairs []
  (local autopairs (. (require :nvim-autopairs)))
  ((. autopairs :setup))
  (autopairs.add_rules (require :nvim-autopairs.rules.endwise-lua))
  (autopairs.add_rules (require :nvim-autopairs.rules.endwise-ruby)))

;; colorscheme
(vim.cmd "colorscheme nordic")

;; autocmds
(vim.cmd
  (.. (autocmd :BufEnter :*.graphql "set ft=graphql")
      (autocmd :BufEnter :*.lock "set ft=json")
      (autocmd :BufEnter :*.nix "set ft=nix")
      (autocmd :BufEnter :*.awkward "Awkward")
      (autocmd :BufWrite :*.awkward "Awkward")
      (autocmd :FileType :markdown "setlocal spell")
      (autocmd :FileType :gitcommit "setlocal spell")
      (autocmd :BufWrite :*.go "lua vim.lsp.buf.formatting()")
      (autocmd :TermOpen :* "setlocal nonu nocul scl=no ls=0")
      (autocmd :TermOpen :* "startinsert")))

(neorg)

;; lazy loading
(local defer vim.defer_fn)
(defer autopairs 10)
(defer awkward 10)
(defer colorizer 10)
(defer comment-nvim 10)
(defer completion 10)
(defer gitsigns 10)
(defer hop 10)
(defer lsp 10)
(defer telescope 10)
(defer treesitter 10)
