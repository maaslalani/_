-- lsp
local lsp = require'lspconfig'
local completion = require'completion'.on_attach

lsp.bashls.setup { on_attach = completion }
lsp.dockerls.setup { on_attach = completion }
lsp.omnisharp.setup { on_attach = completion }
lsp.rnix.setup { on_attach = completion }
lsp.solargraph.setup { on_attach = completion }
lsp.sorbet.setup { on_attach = completion }
lsp.terraformls.setup { on_attach = completion }
lsp.tsserver.setup { on_attach = completion }
lsp.gopls.setup {
  on_attach = completion,
  analyses = {
    unusedparams = true,
    staticcheck = true,
  },
}

local sumneko_root_path = "/Users/" .. vim.fn.expand('$USER') .. "/.config/nvim/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/macOS/lua-language-server"

lsp.sumneko_lua.setup {
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

