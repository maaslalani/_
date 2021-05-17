-- nordbuddy
require'colorbuddy'.colorscheme'nordbuddy'

-- autopairs
require'nvim-autopairs'.setup{}

-- colorizer
require'colorizer'.setup{ '*'; }

-- gitsigns
require'gitsigns'.setup{}

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
