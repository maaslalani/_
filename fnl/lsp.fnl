(module lsp
  {autoload
   {lsp lspconfig
    a aniseed.core}})

(lsp.bashls.setup {})
(lsp.dockerls.setup {})
(lsp.omnisharp.setup {})
(lsp.rnix.setup {})
(lsp.solargraph.setup {})
(lsp.sorbet.setup {})
(lsp.terraformls.setup {})
(lsp.tsserver.setup {})
(lsp.texlab.setup {})

;; gopls
(lsp.gopls.setup
  {:analyses
   {:unusedparams true
    :staticcheck true}})
