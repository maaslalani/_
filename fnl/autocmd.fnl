(module autocmd
  {require {nvim aniseed.nvim}
   require-macros [macros]})

;; buffers
(autocmd :BufEnter "*.nix" "set ft=nix")
(autocmd :BufEnter "*.lock" "set ft=json")
(autocmd :BufEnter "*.graphql" "set ft=graphql")
(autocmd :BufEnter "*.go" "lua vim.lsp.buf.formatting()")

;; cmd lines
(autocmd :CmdLineEnter ":" "set nosmartcase")
(autocmd :CmdLineLeave ":" "set smartcase")

;; terminal
(autocmd :TermOpen "*" "setlocal nonumber nocursorline signcolumn=no")
(autocmd :TermOpen "*" "startinsert")

;; vimwiki
(autocmd :FileType "vimwiki" "lua wkvimwiki()")
(autocmd :BufEnter "*.wiki" "setlocal nocursorline nonumber signcolumn=yes")
