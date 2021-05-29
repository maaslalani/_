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
    icons_enabled = false,
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

-- completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

-- neorg
require('neorg').setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
  }
}
