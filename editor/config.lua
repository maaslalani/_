function on_attach(client)
  require'completion'.on_attach(client)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

function goimports()
  local params = vim.lsp.util.make_range_params()
  params.context = { source = { organizeImports = true } }
  local resp = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
  if resp and resp[1] and resp[1].result and resp[1].result[1] then
    vim.lsp.util.apply_workspace_edit(resp[1].result[1].edit)
  end
  vim.lsp.buf.formatting()
end
