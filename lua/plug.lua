-- nordbuddy
require'colorbuddy'.colorscheme'nordbuddy'

-- autopairs
require'nvim-autopairs'.setup{}

-- colorizer
require'colorizer'.setup{ '*'; }

-- gitsigns
require'gitsigns'.setup{
  keymaps = {}
}

-- lualine
require'lualine'.setup{
  options = {
    theme = 'nord',
  },
}

-- treesitter
require'nvim-treesitter.configs'.setup{
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}

-- nvim dap
local dap = require'dap'

vim.fn.sign_define('DapBreakpoint', {
  text='●',
  texthl='Error',
})

dap.adapters.go = function(callback, _)
  local port = 38697
  local handle
  handle, _ = vim.loop.spawn(
    "dlv",
    {
      args = {"dap", "-l", "127.0.0.1:" .. port},
      detached = true
    },
    function(code)
      handle:close()
      print("Delve exited with exit code: " .. code)
    end
  )
  vim.defer_fn(
    function()
      -- dap.repl.open()
      print("Delve started")
      callback({type = "server", host = "127.0.0.1", port = port})
    end,
    100)
end

dap.configurations.go = {{
  type = "go",
  name = "Debug",
  request = "launch",
  program = "${file}"
}}
