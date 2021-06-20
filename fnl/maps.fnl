(local wk (require :which-key))
(local INSERT :i)
(local LEADER :<leader>)
(local NORMAL :n)
(local VISUAL :v)

(wk.register
  {
   :d {:name :debug
       :c  [":lua require'dap'.continue()<cr>" :continue]
       :s {:name :step
           :s [":lua require'dap'.step_over()<cr>" :over]
           :i [":lua require'dap'.step_into()<cr>" :into]
           :o [":lua require'dap'.step_out()<cr>" :out]}
       :b {:name :breakpoint
           :t [":lua require'dap'.toggle_breakpoint()<cr>" :toggle]
           :s [":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>" :set]
           :l [":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>" :log]}
       :r [":lua require'dap'.repl.open()<cr>" :repl]
       :. [":lua require'dap'.run_last()<cr>" :repeat]}
   :f {:name :find
       :e ["<cmd>Explore<cr>" :explore]
       :f ["<cmd>Telescope find_files<cr>" :file]
       :n ["<cmd>enew<cr>" :new]
       :r ["<cmd>Telescope live_grep<cr>" :grep]
   :l {:name :lsp
       :f ["<cmd>lua vim.lsp.buf.formatting()<cr>" :format]
       :a ["<cmd>lua vim.lsp.buf.code_action()<cr>" :actions]
       :r ["<cmd>lua vim.lsp.buf.rename()<cr>" :rename]
       :l ["<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>" :line]
       :d {:name :diagnostics
           :n ["<cmd>lua vim.lsp.diagnostic.goto_next()<cr>" :next]
           :p ["<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>" :previous]}}
   :t {:name :tabs
       :t ["<cmd>tabnew<cr>" :new]
       :n ["<cmd>tabnext<cr>" :next]
       :p ["<cmd>tabprevious<cr>" :previous]}
   :c {:name :quickfix
       :n ["<cmd>cnext<cr>" :next]
       :p ["<cmd>cprev<cr>" :previous]
       :q ["<cmd>cclose<cr>" :close]
       :o ["<cmd>copen<cr>" :open]}
   :g {:name :git
       :b ["<cmd>Gitsigns blame_line<cr>" :blame]
       :h {:name :hunk
           :r ["<cmd>Gitsigns reset_hunk<cr>" :reset]
           :s ["<cmd>Gitsigns stage_hunk<cr>" :stage]
           :n ["<cmd>Gitsigns next_hunk<cr>" :next]
           :p ["<cmd>Gitsigns prev_hunk<cr>" :previous]}}
   :r [":%s//g<left><left>" :replace]
   :q ["<cmd>q<cr>" :quit]
   :w ["<cmd>w<cr>" :save]
   :p ["\"*p<cr>" :paste]
   :y ["\"*y<cr>" :copy]}
  {:prefix LEADER :mode NORMAL})

(wk.register
  {
   :K ["<cmd>lua vim.lsp.buf.hover()<cr>" :hover]
   :g {:name goto
       :d ["<cmd>lua vim.lsp.buf.definition()<cr>" :definition]
       :r ["<cmd>lua vim.lsp.buf.references()<cr>" :reference]
       :c :commentary}
   :<bs> ["-" :back]
   ";" {:name :test
        :f ["<cmd>TestFile<cr>" :file]
        :l ["<cmd>TestLast<cr>" :last]
        :n ["<cmd>TestNearest<cr>" :nearest]
        :s ["<cmd>TestSuite<cr>" :suite]
        :v ["<cmd>TestVisit<cr>" :visit]}}
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
  {:< ["<gv" :dedent]
   :> [">gv" :indent]
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
