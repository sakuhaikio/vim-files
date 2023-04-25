syntax on 
set number
set hidden
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set swapfile
set cursorline
set belloff=all
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
set enc=utf-8
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
set guifont=Powerline_Consolas:h11
set renderoptions=type:directx,gamma:1.5,contrast:0.5,geom:1,renmode:5,taamode:1,level:0.5
set scrolloff=5

inoremap <Space> <Space><C-g>u


"plugins 1
call plug#begin()
Plug 'tomasiser/vim-code-dark'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
"Plug 'EdenEast/nightfox.nvim'
"Plug 'rainglow/vim'
"Plug 'sheerun/vim-polyglot'
"Plug 'jeaye/color_coded'
call plug#end()

filetype plugin indent on

set termguicolors
set t_Co=256
set t_ut=
colorscheme omateema

inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
imap <C-c> <Esc>

nnoremap Y y$
