" Backups
set nobackup
set nowb
set noswapfile
set undodir=~/.undo
set undofile

" Maps
let mapleader="\<Space>"
map <Space> <Nop>
map Q :q<CR>

" Replace
nnoremap S :%s//g<Left><Left>
vnoremap S :s//g<Left><Left>

" Leader
nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>e :NERDTreeToggle<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

" Commands
:command W w
:command Q q

:command Af ALEFix
:command Tf TestFile

:command TTerm tabnew | term
:command VTerm vsp | term
:command Term sp | term

" Configuration
set nocompatible
set ttyfast
set lazyredraw
set encoding=utf-8

" Wrap
set synmaxcol=300
set nowrap

" Clipboard
set clipboard=unnamed

" Bells
set noerrorbells
set visualbell
set t_vb=

" Tabs
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set list listchars=tab:»·,trail:·

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Wild
set wildmode=list:longest,list:full
set wildignore+=.git
set wildignore+=vendor/gems/*
set wildignore+=*/tmp/*
set wildignore+=*.zip

" Number
set number
set numberwidth=1

" Timeout
set notimeout
set ttimeout
set timeoutlen=50

" Characters
set backspace=indent,eol,start
set printfont=PragmataPro:h12
set fillchars+=vert:│

" Splits
set splitbelow
set splitright

set autoindent
set autoread
set autowrite

set noshowmode
set showcmd
set hidden

set nocursorline
set ruler
set laststatus=2
set concealcursor=""

filetype plugin indent on

" Colors
colorscheme nord

" Plugins
let NERDTreeShowHidden=1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1
let g:lightline = { 'colorscheme': 'nord' }
let g:ale_sign_error = '*'
let g:ale_sign_warning = '~'

" Terminal
augroup nvim
  au!
  au VimEnter * doautoa Syntax,FileType
augroup END
