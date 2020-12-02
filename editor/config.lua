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

local servers = {
  'bashls',
  'dockerls',
  'omnisharp',
  'rnix',
  'solargraph',
  'sumneko_lua',
  'tsserver',
}

for _, server in pairs(servers) do
  lsp[server].setup { on_attach = completion.on_attach }
end

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
