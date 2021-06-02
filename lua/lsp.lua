-- lsp
local lsp = require'lspconfig'
local completion = require'completion'

lsp.bashls.setup { on_attach=completion.on_attach }
lsp.dockerls.setup { on_attach=completion.on_attach }
lsp.omnisharp.setup { on_attach=completion.on_attach }
lsp.rnix.setup { on_attach=completion.on_attach }
lsp.solargraph.setup { on_attach=completion.on_attach }
lsp.sorbet.setup { on_attach=completion.on_attach }
lsp.terraformls.setup { on_attach=completion.on_attach }
lsp.tsserver.setup { on_attach=completion.on_attach }
lsp.texlab.setup { on_attach=completion.on_attach }
lsp.gopls.setup {
  on_attach=completion.on_attach,
  analyses = {
    unusedparams = true,
    staticcheck = true,
  },
}

local sumneko_root_path = "/Users/" .. vim.fn.expand('$USER') .. "/.config/nvim/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

lsp.sumneko_lua.setup {
  on_attach = completion.on_attach,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        globals = {'vim'}
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

