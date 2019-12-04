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

nnoremap S :%s//g<Left><Left>
vnoremap S :s//g<Left><Left>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Commands
:command W w
:command Q q
:command WQ wq
:command QW wq
:command Wq wq
:command Qw wq

:command E NERDTree
:command Af ALEFix
:command Tf TestFile

" Configuration
set nocompatible
set synmaxcol=300
set ttyfast
set lazyredraw
set clipboard=unnamed
set noerrorbells visualbell t_vb=
set encoding=utf-8
set nowrap
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

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*,*/tmp/*,*.so,*.swp,*.zip

set number
set numberwidth=1
set notimeout
set ttimeout
set timeoutlen=50
set backspace=indent,eol,start
set printfont=PragmataPro:h12
set fillchars+=vert:│
set scrolloff=3

set autoindent
set autoread
set autowrite
set showmode
set showcmd
set hidden
set nocursorline
set ruler
set laststatus=2
set concealcursor=""
set background=dark

filetype plugin indent on

" Colors
colorscheme gruvbox
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

augroup nvim
  au!
  au VimEnter * doautoa Syntax,FileType
augroup END

" Plugins
let NERDTreeShowHidden=1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:ale_sign_error = '*'
let g:ale_sign_warning = '~'

" Terminal
augroup _term
  autocmd TermOpen term://* set nonu nornu
augroup END

tnoremap <Esc> <C-\><C-n>
