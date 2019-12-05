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

nnoremap s a<bs>
nnoremap S :%s//g<Left><Left>
vnoremap S :s//g<Left><Left>

nnoremap <Leader>t :tabnew<CR>
nnoremap <Leader>e :NERDTreeToggle<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>

nnoremap <C-w>\ :vsp<CR>
nnoremap <C-w>- :sp<CR>
tnoremap <C-w>\ :vsp<CR>
tnoremap <C-w>- :sp<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

tnoremap <C-]> <C-\><C-n>
tmap <C-x> <C-\><C-n>:q<CR>

tnoremap <silent> <C-h> <C-\><C-n><C-w>h
tnoremap <silent> <C-j> <C-\><C-n><C-w>j
tnoremap <silent> <C-k> <C-\><C-n><C-w>k
tnoremap <silent> <C-l> <C-\><C-n><C-w>l

" Commands
:command W w
:command Q q
:command WQ wq
:command QW wq
:command Wq wq
:command Qw wq

:command Af ALEFix
:command Tf TestFile

:command VTerm vsp | term
:command Term sp | term

" Configuration
set nocompatible
set synmaxcol=300
set lazyredraw
set ttyfast
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
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

augroup nvim
  au!
  au VimEnter * doautoa Syntax,FileType
augroup END

" Plugins
let NERDTreeShowHidden=1
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
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
