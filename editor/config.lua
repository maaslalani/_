local lsp = require'nvim_lsp'
local completion = require'completion'
local vim = vim

vim.cmd("packadd completion-nvim")
vim.cmd("packadd nvim-lspconfig")

lsp.gopls.setup {
  on_attach = require'completion'.on_attach,
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}
lsp.bashls.setup { on_attach = completion.on_attach }
lsp.dockerls.setup { on_attach = completion.on_attach }
lsp.omnisharp.setup { on_attach = completion.on_attach }
lsp.rnix.setup { on_attach = completion.on_attach }
lsp.solargraph.setup { on_attach = completion.on_attach }
lsp.sumneko_lua.setup { on_attach = completion.on_attach }
lsp.tsserver.setup { on_attach = completion.on_attach }

function Goimports(timeoutms)
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  local method = "textDocument/codeAction"
  local resp = vim.lsp.buf_request_sync(0, method, params, timeoutms)
  if resp and resp[1] then
    local result = resp[1].result
    if result and result[1] then
      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit)
    end
  end

  vim.lsp.buf.formatting()
end
