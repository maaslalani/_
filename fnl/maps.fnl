(module maps
  {require-macros [macros]})

(local wk (require :which-key))
(local INSERT :i)
(local LEADER :<leader>)
(local NORMAL :n)
(local VISUAL :v)

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
  {:prefix LEADER :mode NORMAL})

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
  {:mode NORMAL})

(set _G.wkvimwiki
     (fn []
       (wk.register
         {:<cr> ["<Plug>VimwikiFollowLink" :follow]
          :<bs> ["<Plug>VimwikiGoBackLink" :back]
          :<c-o> ["<Plug>VimwikiGoBackLink" :back]
          :<tab> ["<Plug>VimwikiNextLink" :next]
          :<s-tab> ["<Plug>VimwikiPrevLink" :previous]
          :n ["<Plug>VimwikiNextLink" :next]
          :N ["<Plug>VimwikiPrevLink" :previous]
          "," {:t {:name :task
                   :d ["<Plug>VimwikiToggleListItem" :toggle]
                   :n ["<Plug>VimwikiNextTask" :next]}}}
         {:mode NORMAL :buffer (vim.api.nvim_get_current_buf)})))

(wk.register
  {"," {:name :wiki
        "," ["<Plug>VimwikiIndex" :open]
        :n ["<Plug>VimwikiGoto" :goto]
        :x ["<Plug>VimwikiDeleteFile" :delete]
        :r ["<Plug>VimwikiRenameFile" :rename]}}
  {:mode NORMAL})

(wk.register
  {:< [:<gv :dedent]
   :> [:>gv :indent]
   :<leader>so [":sort <bar>w<bar>e<cr>" :sort]
   :<leader>y ["\"*y" :copy]
   :<leader>p ["\"*p" :paste]}
  {:mode VISUAL})

(wk.register
  {:<tab> {1 "pumvisible() ? \"\\<c-n>\" : \"\\<tab>\""
           2 "Next Completion"
           :expr true}
   :<s-tab> {1 "pumvisible() ? \"\\<c-p>\" : \"\\<s-tab>\""
             2 "Previous Completion"
             :expr true}}
  {:mode INSERT})	

(wk.setup
  {:ignore_missing false
   :plugins {:spelling {:enabled true :suggestions 20}}})	
