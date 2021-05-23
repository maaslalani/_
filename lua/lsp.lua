-- lsp
local lsp = require'lspconfig'

lsp.bashls.setup {}
lsp.dockerls.setup {}
lsp.omnisharp.setup {}
lsp.rnix.setup {}
lsp.solargraph.setup {}
lsp.sorbet.setup {}
lsp.terraformls.setup {}
lsp.tsserver.setup {}
lsp.texlab.setup {}
lsp.gopls.setup {
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

