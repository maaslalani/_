function on_attach(client)
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
end

function goimports()
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  local resp = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
  if resp and resp[1] then
    local result = resp[1].result
    if result and result[1] then
      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit)
    end
  end

  vim.lsp.buf.formatting()
end
