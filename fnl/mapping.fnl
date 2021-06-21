(module mapping)

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
   :d {:name :debug
       :c  [(lua :dap :continue) :continue]
       :s {:name :step
           :s [(lua :dap :step_over) :over]
           :i [(lua :dap :step_into) :into]
           :o [(lua :dap :step_out) :out]}
       :b {:name :breakpoint
           :t [(lua :dap :toggle_breakpoint) :toggle]
           :s [(lua :dap :set_breakpoint) :set]}
       :r [(lua :dap :repl_open) :repl]
       :. [(lua :dap :run_last) :repeat]}
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
   :p ["\"*p<cr>" :paste]
   :y ["\"*y<cr>" :copy]}
  {:prefix :<leader> :mode :n})

;; normal mappings
(wk.register
  {
   :K [(lsp :buf.hover) :hover]
   :g {:name goto
       :d [(lsp :buf.definition) :definition]
       :r [(lsp :buf.reference) :reference]
       :c :commentary}
   :<bs> ["-" :back]
   ";" {:name :test
        :f [(cmd :TestFile) :file]
        :l [(cmd :TestLast) :last]
        :n [(cmd :TestNearest) :nearest]
        :s [(cmd :TestSuite) :suite]
        :v [(cmd :TestVisit) :visit]}}
  {:mode :n})

;; buffer vimwiki mappings
(set _G.wkvimwiki
     (fn []
       (wk.register
         {:<cr> [(plug :VimwikiFollowLink) :follow]
          :<bs> [(plug :VimwikiGoBackLink) :back]
          :<c-o> [(plug :VimwikiGoBackLink) :back]
          :<tab> [(plug :VimwikiNextLink) :next]
          :<s-tab> [(plug :VimwikiPrevLink) :previous]
          :n [(plug :VimwikiNextLink) :next]
          :N [(plug :VimwikiPrevLink) :previous]
          "," {:t {:name :task
                   :d [(plug :VimwikiToggleListItem) :toggle]
                   :n [(plug :VimwikiNextTask) :next]}}}
         {:mode :n :buffer (vim.api.nvim_get_current_buf)})))

;; global vimwiki mappings
(wk.register
  {"," {:name :wiki
        "," [(plug :VimwikiIndex) :open]
        :n [(plug :VimwikiGoto) :goto]
        :x [(plug :VimwikiDeleteFile) :delete]
        :r [(plug :VimwikiRenameFile) :rename]}}
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

(wk.setup
  {:ignore_missing false
   :plugins {:spelling {:enabled true :suggestions 20}}})	
