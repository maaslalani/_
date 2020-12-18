local vim = vim

-- Treesitter
local treesitter = require'nvim-treesitter.configs'
treesitter.setup { highlight = { enable = true }, indent = { enable = true } }

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
