local cmd = vim.cmd

-- buffers
cmd 'autocmd BufEnter *.nix set ft=nix'
cmd 'autocmd BufEnter *.lock set ft=json'
cmd 'autocmd BufEnter *.graphql set ft=graphql'
cmd 'autocmd BufWrite *.go lua vim.lsp.buf.formatting()'

-- cmd line
cmd 'autocmd CmdLineEnter : set nosmartcase'
cmd 'autocmd CmdLineLeave : set smartcase'

-- terminal
cmd 'autocmd TermOpen * setlocal nonumber nocursorline signcolumn=no'

-- vimwiki
cmd 'autocmd FileType vimwiki lua whichkeyvimwiki()'
