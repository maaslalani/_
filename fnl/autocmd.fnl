(module autocmd
  {require {nvim aniseed.nvim}})

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
