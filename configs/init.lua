local vim = vim

-- Treesitter
local treesitter = require'nvim-treesitter.configs'
treesitter.setup { highlight = { enable = true }, indent = { enable = true } }

-- Language Server Protocol
local completion = require'completion'
local lsp = require'nvim_lsp'

lsp.bashls.setup { on_attach = completion.on_attach }
lsp.dockerls.setup { on_attach = completion.on_attach }
lsp.omnisharp.setup { on_attach = completion.on_attach }
lsp.rnix.setup { on_attach = completion.on_attach }
lsp.solargraph.setup { on_attach = completion.on_attach }
lsp.sumneko_lua.setup { on_attach = completion.on_attach }
lsp.tsserver.setup { on_attach = completion.on_attach }
lsp.gopls.setup {
  on_attach = completion.on_attach,
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

-- Go Imports
function Goimports()
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  local resp = vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params, 1000)
  if resp and resp[1] and resp[1].result and resp[1].result[1] and resp[1].result[1].edit then
    vim.lsp.util.apply_workspace_edit(resp[1].result[1].edit)
  end
  vim.lsp.buf.formatting()
end

-- Nord Colorscheme
require'nordbuddy'.use{}
