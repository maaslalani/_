local g = vim.g

g.mapleader = ' '

-- diagnostic options
g.diagnostic_auto_popup_while_jump = 0
g.diagnostic_enable_underline = 1
g.diagnostic_enable_virtual_text = 1
g.diagnostic_insert_delay = 0

-- netrw options
g.netrw_banner = 0
g.netrw_localcopydircmd = 'cp -r'
g.netrw_localrmdir = 'rm -r'

-- vimwiki
g.vimwiki_list = {{path = '~/wiki'}}
g.vimwiki_hl_headers = 1
g.vimwiki_hl_cb_checked = 1
g.vimwiki_key_mappings = { global = 0, html = 0, links = 0 }
