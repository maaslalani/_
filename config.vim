" Backups
set nobackup
set nowb
set noswapfile
set undofile
set undodir=~/.undo

" Maps
let mapleader=<Space>
map <Space> <Nop>
map Q :q<CR>

nmap S :%s//g<Left><Left>
vmap s :s//g<Left><Left>

nmap <Leader>e :NERDTreeToggle<CR>
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>

nmap <C-a>\ :vsp<CR>
nmap <C-a>- :sp<CR>
nmap <C-a>c :tabnew<CR>
nmap <C-a>n gt
nmap <C-a>p gT
nmap <C-a>x :q<CR>

tmap <C-a>\ :vsp<CR>
tmap <C-a>- :sp<CR>
tmap <C-a>c <C-\><C-n>:tabnew<CR>
tmap <C-a>n <C-\><C-n>gt
tmap <C-a>p <C-\><C-n>gT
tmap <C-a>x <C-\><C-n>:q<CR>

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

tmap <silent> <C-h> <C-\><C-n><C-w>h
tmap <silent> <C-j> <C-\><C-n><C-w>j
tmap <silent> <C-k> <C-\><C-n><C-w>k
tmap <silent> <C-l> <C-\><C-n><C-w>l

" Commands
:command W w
:command Q q
:command Af ALEFix
:command Tf TestFile
:command VTerm vsp | term
:command Term sp | term

" Configuration
set lazyredraw
set synmaxcol=300
set nocompatible
set ttyfast
set clipboard=unnamed
set noerrorbells
set visualbell
set t_vb=
set encoding=utf-8
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set hlsearch
set incsearch
set ignorecase
set smartcase
set wildmode=list:longest,list:full
set number
set numberwidth=1
set notimeout
set ttimeout
set timeoutlen=50
set fillchars+=vert:│
set backspace=indent,eol,start
set printfont=PragmataPro:h12
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
set concealcursor
set laststatus=2

filetype plugin indent on

" Colors
colorscheme nord
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

augroup nvim
  au!
  au VimEnter * doautoa Syntax,FileType
augroup END

" Plugins
let NERDTreeShowHidden=1
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1
let g:lightline = { 'colorscheme': 'nord' }
let g:ale_sign_error = '*'
let g:ale_sign_warning = '~'

" Terminal
augroup _term
  autocmd TermOpen term://* set nonu nornu
  autocmd TermOpen term://* startinsert
  autocmd BufWinEnter,WinEnter term://* startinsert
augroup END
