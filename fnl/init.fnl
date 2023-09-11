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
(set g.copilot_no_tab_map true)

;; Options
(local o vim.o)
(set o.autowrite true)
(set o.backspace "indent,eol,start")
(set o.backup false)
(set o.completeopt "menu,menuone,noselect")
(set o.conceallevel 0)
(set o.cursorline true)
(set o.diffopt "filler,internal,algorithm:histogram,indent-heuristic")
(set o.hidden true)
(set o.ignorecase true)
(set o.laststatus 3)
(set o.lazyredraw true)
(set o.number true)
(set o.omnifunc "v:lua.vim.lsp.omnifunc")
(set o.ruler true)
(set o.scrolloff 3)
(set o.showmode false)
(set o.signcolumn :yes)
(set o.smartcase true)
(set o.softtabstop 4)
(set o.spell true)
(set o.splitbelow true)
(set o.splitright true)
(set o.swapfile false)
(set o.synmaxcol 300)
(set o.syntax :off)
(set o.tabstop 4)
(set o.termguicolors true)
(set o.textwidth 80)
(set o.timeoutlen 350)
(set o.undofile true)
(set o.updatetime 300)
(set o.visualbell true)
(set o.wildmode "longest:full,full")
(set o.wrap false)
(set o.wrapmargin 0)
(set o.writebackup false)

;; Macros
(macro pcmd [prefix cmd]
  `(.. :<cmd> ,prefix (. " ") ,cmd :<cr>))

(macro cmd [command]
  `(.. :<cmd> ,command :<cr>))

(macro lspcmd [command]
  `(.. "<cmd>lua vim.lsp." ,command "()<cr>"))

;; Which key
(local wk (require :which-key))
(local wks wk.setup)
(local wkr wk.register)

; leader
(wkr {:f [(pcmd :Telescope :find_files) :file]
      :e [(cmd :Explore) :explore]
      :n [(cmd :enew) :new]
      :/ [(pcmd :Telescope :live_grep) :grep]
      :r [(pcmd :Telescope :live_grep) :grep]
      :o [(cmd "!open <cWORD>") :open]
      :s {:name :misc
          :l [(pcmd :luafile "%") :lua]
          :v [(cmd :vsplit) :split]
          :o [(pcmd :source "%") :source]
          :s [(cmd :TSHighlightCapturesUnderCursor) :syntax]
          :r ["\"hy:%s/<C-r>h//gc<left><left><left>" :syntax]
          :c [(cmd :ColorizerToggle) :colorizer]
          :t [(cmd "10split | terminal") :terminal]}
      :l {:name :lsp
          :f [(lspcmd :buf.format) :format]
          :a [(lspcmd :buf.code_action) :actions]
          :l ["<cmd>lua vim.diagnostic.open_float({border = 'single'})<CR>"
              :diagnostics]
          :r [(lspcmd :buf.rename) :rename]}
      :t {:name :tab
          :t [(cmd :tabnew) :new]
          :n [(cmd :tabnext) :next]
          :p [(cmd :tabprevious) :previous]
          :o [(cmd "tab split") :tabsplit]}
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
      :p ["\"*p<CR>" :paste]
      :y ["\"*y<CR>" :copy]} {:prefix :<leader> :mode :n})

; normal
(wkr {:<c-h> [:<c-w>h :left]
      :<c-j> [:<c-w>j :down]
      :<c-k> [:<c-w>k :up]
      :<c-l> [:<c-w>l :right]
      :<esc> [(cmd :nohl) :nohl]
      :U [(cmd :redo) :redo]
      :x [:V :select]
      :X [:V :select]
      :H [(lspcmd :buf.hover) :hover]
      :J ["mzJ`z" :merge]
      :Q [:<nop> :nope]
      :S [(cmd :HopWord) :hopword]
      :s [(cmd :HopChar2) :hop]
      :g {:name :goto
          :d [(lspcmd :buf.definition) :definition]
          :r [(lspcmd :buf.references) :references]}} {:mode :n})

; visual
(wkr {:< [:<gv :dedent]
      :<c-l> [:<nop> :nope]
      :<leader>y ["\"*y" :copy]
      :a [(lspcmd :buf.range_code_action) :actions]
      :S [":%s/" :substitute]
      :s [":sort <bar>w<bar>e<cr>" :sort]
      :X [:k :select]
      :x [:j :select]
      :> [:>gv :indent]
      :<leader>p ["\"*p" :paste]} {:mode :v})

; insert
(wkr {"," [",<c-g>u" ","]
      :! [:!<c-g>u "!"]
      :. [:.<c-g>u "."]
      :? [:?<c-g>u "?"]} {:mode :i})

(wks {:window {:border ["─" "─" "─" " " " " " " " " " "]
               :position :bottom
               :margin [0 0 0 0]
               :padding [0 0 1 0]}
      :plugins {:spelling {:enabled true}}})

;; Language Server Protocol
(set capabilities ((. (require :cmp_nvim_lsp) :default_capabilities)))

(fn on_attach [client bufnr]
  (tset vim.lsp.handlers :textDocument/hover
        (vim.lsp.with vim.lsp.handlers.hover {:border :single}))
  (tset vim.lsp.handlers :textDocument/signatureHelp
        (vim.lsp.with vim.lsp.handlers.hover {:border :single})))

(fn lsp []
  (local lsp (require :lspconfig))
  (lsp.bashls.setup {: on_attach : capabilities})
  (lsp.dockerls.setup {: on_attach : capabilities})
  (lsp.golangci_lint_ls.setup {: on_attach : capabilities})
  (lsp.rnix.setup {: on_attach : capabilities})
  (lsp.solargraph.setup {: on_attach
                         : capabilities
                         :flags {:debounce_text_changes 150}
                         :settings {:solargraph {:diagnostics true
                                                 :formatting true}}})
  (lsp.sorbet.setup {:root_dir (lsp.util.root_pattern :sorbet/)
                     : on_attach
                     : capabilities
                     :init_options {:documentFormatting false :codeAction true}})
  (lsp.terraformls.setup {: on_attach : capabilities})
  (lsp.texlab.setup {: on_attach : capabilities})
  (lsp.tsserver.setup {: on_attach : capabilities})
  (lsp.yamlls.setup {: on_attach : capabilities})
  (lsp.gopls.setup {:flags {:debounce_text_changes 500}
                    :analyses {:unusedparams true :staticcheck true}
                    : on_attach
                    : capabilities})
  (lsp.zls.setup {: on_attach : capabilities})
  (local null_ls (require :null-ls))
  (local sources [null_ls.builtins.code_actions.proselint
                  null_ls.builtins.diagnostics.rubocop
                  null_ls.builtins.diagnostics.write_good
                  null_ls.builtins.formatting.alejandra
                  null_ls.builtins.formatting.eslint
                  null_ls.builtins.formatting.fnlfmt
                  null_ls.builtins.formatting.goimports
                  null_ls.builtins.formatting.prettier
                  null_ls.builtins.formatting.rubocop
                  null_ls.builtins.hover.dictionary])
  (null_ls.setup {: sources : on_attach : capabilities}))

;; hop
(fn hop []
  (local hop (require :hop))
  ((. hop :setup) {:keys :arstqwfpzxcvneio}))

;; gitsigns
(fn gitsigns []
  (local gitsigns (require :gitsigns))
  ((. gitsigns :setup) {}))

;; cmp
(local icons {:Class "󰠱"
              :Color "󰏘"
              :Constant "󰏿"
              :Constructor ""
              :Enum ""
              :EnumMember ""
              :Event ""
              :Field "󰜢"
              :File "󰈙"
              :Folder "󰉋"
              :Function "󰊕"
              :Interface ""
              :Keyword "󰌋"
              :Method "󰆧"
              :Module ""
              :Operator "󰆕"
              :Property "󰜢"
              :Reference "󰈇"
              :Snippet ""
              :Struct "󰙅"
              :Text "󰉿"
              :TypeParameter ""
              :Unit "󰑭"
              :Value "󰎠"
              :Variable "󰀫"})

(local loader (require :luasnip/loaders/from_vscode))
(loader.lazy_load)

(fn check-backspace []
  (let [col (- (vim.fn.col ".") 1)]
    (or (= col 0) (: (: (vim.fn.getline ".") :sub col col) :match "%s"))))

(local cmp (require :cmp))
(local luasnip (require :luasnip))

(fn tab [fallback]
  (if (cmp.visible) (cmp.select_next_item)
      (luasnip.expandable) (luasnip.expand)
      (luasnip.expand_or_jumpable) (luasnip.expand_or_jump)
      (check-backspace) (fallback)
      (fallback)))

(fn s-tab [fallback]
  (if (cmp.visible) (cmp.select_prev_item)
      (luasnip.jumpable (- 1)) (luasnip.jump (- 1))
      (fallback)))

(fn completion []
  (local cmp (require :cmp))
  (local cmp-autopairs (. (require :nvim-autopairs.completion.cmp)))
  (cmp.event:on :confirm_done
                (cmp-autopairs.on_confirm_done {:map_char {:tex ""}}))
  (local border ["┌" "─" "┐" "│" "┘" "─" "└" "│"])
  (cmp.setup {:snippet {:expand (fn [args] (luasnip.lsp_expand args.body))}
              :mapping {:<C-b> (cmp.mapping (cmp.mapping.scroll_docs (- 1))
                                            [:i :c])
                        :<C-f> (cmp.mapping (cmp.mapping.scroll_docs 1) [:i :c])
                        :<C-e> (cmp.mapping (cmp.mapping.complete) [:i :c])
                        :<CR> (cmp.mapping.confirm {:select true})
                        :<C-n> (cmp.mapping (fn [fallback] (tab fallback))
                                            [:i :s])
                        :<C-p> (cmp.mapping (fn [fallback] (s-tab fallback))
                                            [:i :s])
                        :<Tab> (cmp.mapping (fn [fallback] (tab fallback))
                                            [:i :s])
                        :<S-Tab> (cmp.mapping (fn [fallback] (s-tab fallback))
                                              [:i :s])}
              :formatting {:fields [:abbr :kind :menu]
                           :format (fn [entry vim-item]
                                     (set vim-item.kind
                                          (string.format " %s"
                                                         (. icons vim-item.kind)))
                                     (set vim-item.menu
                                          (. {:nvim_lsp "[LSP]"
                                              :luasnip "[Snippet]"
                                              :buffer "[Buffer]"
                                              :path "[Path]"}
                                             entry.source.name))
                                     vim-item)}
              :sources [{:name :nvim_lsp}
                        {:name :luasnip}
                        {:name :buffer :keyword_length 4}
                        {:name :path}]
              :confirm_opts {:behavior cmp.ConfirmBehavior.Replace
                             :select false}
              :views {:entries :native}
              :experimental {:ghost_text false}}))

;; telescope
(fn telescope []
  (local telescope (require :telescope))
  (local sorters (require :telescope.sorters))
  (local previewers (require :telescope.previewers))
  ((. telescope :setup) {:defaults {:prompt_prefix " "
                                    :selection_caret "→ "
                                    :set_env {:COLORTERM :truecolor}
                                    :vimgrep_arguments [:rg :--vimgrep]
                                    :winblend 0}}))

;; tree-sitter
(fn treesitter []
  (local parsers (require :nvim-treesitter.parsers))
  (local parser-configs ((. parsers :get_parser_configs)))
  (set parser-configs.go
       {:install_info {:url "https://github.com/tree-sitter/tree-sitter-go"
                       :files [:src/parser.c]
                       :branch :main}})
  (local treesitter (require :nvim-treesitter.configs))
  ((. treesitter :setup) {:highlight {:enable true}
                          :parser_install_dir "~/.local/share/nvim/site/parser"
                          :indent {:enable false}})
  (vim.opt.runtimepath:append "~/.local/share/nvim/site/parser"))

; auto-pairs
(fn autopairs []
  (local autopairs (. (require :nvim-autopairs)))
  ((. autopairs :setup))
  (autopairs.add_rules (require :nvim-autopairs.rules.endwise-lua))
  (autopairs.add_rules (require :nvim-autopairs.rules.endwise-ruby)))

;; auto-cmds
(local autocmd vim.api.nvim_create_autocmd)
(autocmd [:BufEnter] {:pattern :*.graphql :command "set ft=graphql"})
(autocmd [:BufEnter] {:pattern :*.lock :command "set ft=json"})
(autocmd [:BufEnter] {:pattern :*.nix :command "set ft=nix"})
(autocmd [:BufWritePre]
         {:pattern :*.go :command "lua vim.lsp.buf.format { async = false }"})

(autocmd [:TermOpen]
         {:pattern "*" :command "setl nonu nocul scl=no ls=0 | star"})

;; lazy loading
(local defer vim.defer_fn)
(defer autopairs 10)
(defer completion 10)
(defer gitsigns 10)
(defer hop 10)
(defer lsp 10)
(defer telescope 10)

;; eager loading
(treesitter)
