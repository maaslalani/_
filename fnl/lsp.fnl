(module lsp
  {autoload
   {lsp lspconfig
    completion completion
    a aniseed.core}})

(lsp.bashls.setup
  {:on_attach completion.on_attach})

(lsp.dockerls.setup
  {:on_attach completion.on_attach})

(lsp.omnisharp.setup
  {:on_attach completion.on_attach})

(lsp.rnix.setup
  {:on_attach completion.on_attach})

(lsp.solargraph.setup
  {:on_attach completion.on_attach})

(lsp.sorbet.setup
  {:on_attach completion.on_attach})

(lsp.terraformls.setup
  {:on_attach completion.on_attach})

(lsp.tsserver.setup
  {:on_attach completion.on_attach})

(lsp.texlab.setup
  {:on_attach completion.on_attach})

;; gopls
(lsp.gopls.setup
  {:on_attach completion.on_attach
   :analyses
   {:unusedparams true
    :staticcheck true}})
