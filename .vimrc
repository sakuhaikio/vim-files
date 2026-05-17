" =========================
" Basics
" =========================
set nocompatible
syntax on
set encoding=utf-8
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
set grepformat=%f:%l:%c:%m
set noerrorbells
set visualbell
set t_vb=

filetype plugin indent on

" =========================
" UI
" =========================
set number
set cursorline
set showmatch
set signcolumn=yes
set scrolloff=3
set belloff=all

set termguicolors
set t_Co=256
set t_ut=

let mapleader = " "
let maplocalleader = " "

"highlight after search
"set nowildmenu
set hlsearch
nnoremap <silent> <leader><space> :nohlsearch<CR>

" NOTE: This disables the wildmenu (cmdline completion menu)
"set nowildmenu
set wildmenu
set wildmode=longest:full,full

" =========================
" Editing
" =========================
set hidden
set backspace=indent,eol,start

set ignorecase
set smartcase

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Make undo break after inserting a space (nice for undo granularity)
inoremap <Space> <Space><C-g>u

" Keep formatoptions sane (don’t auto-continue comments)
set formatoptions+=/
autocmd FileType * setlocal formatoptions-=cro

" =========================
" Swap / Undo / Backup files
" =========================
set undofile
set swapfile

set nobackup
set nowritebackup

" Use Windows-friendly location under $HOME/vimfiles
" Linux / WSL Vim paths
set backupdir^=$HOME/.vim/backup//
set directory^=$HOME/.vim/swap//
set undodir^=$HOME/.vim/undo//

if !isdirectory($HOME."/.vim/backup")
  call mkdir($HOME."/.vim/backup", "p")
endif

if !isdirectory($HOME."/.vim/swap")
  call mkdir($HOME."/.vim/swap", "p")
endif

if !isdirectory($HOME."/.vim/undo")
  call mkdir($HOME."/.vim/undo", "p")
endif

" Faster responsiveness for plugins (Coc uses this)
set updatetime=300

" =========================
" vim-plug plugins
" =========================
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
call plug#end()

" If you ever enable NERDTree again:
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 0
let g:NERDTreeShowHidden = 1
nnoremap <C-n> :NERDTreeToggle<CR>

nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bd<CR>
nnoremap <leader>bl :ls<CR>:b<Space>

" =========================
" Colorscheme (safe)
" =========================
silent! colorscheme omateema

" =========================
" CoC mappings
" =========================
inoremap <expr> <Tab>   coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" rename with sequence '\ r n'
nmap <leader>rn <Plug>(coc-rename) 

" Formating
nmap <leader>f <Plug>(coc-format)
xmap <leader>f <Plug>(coc-format-selected)

" next \ previous error
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" documentation
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Symbolilista nykyisestä tiedostosta 
nnoremap <silent> <leader>o :CocList outline<CR>

" Make Ctrl+C behave like Esc in insert mode
imap <C-c> <Esc>

" Make Y behave like D/C (yank to end of line)
nnoremap Y y$

" Terminal mode: Esc to normal mode
tnoremap <Esc> <C-\><C-n>

" =========================
" Cursor shape (terminal)
" =========================
if exists('&t_SI')
  let &t_SI = "\<Esc>[6 q" " insert: bar
  let &t_SR = "\<Esc>[4 q" " replace: underline
  let &t_EI = "\<Esc>[2 q" " normal: block
endif

" =========================
" Filetype tweaks
" =========================
autocmd BufNewFile,BufRead *.tpp setfiletype cpp

" =========================
" Switch header/source
" =========================
function! SwitchHeaderSource()
  let l:ext = expand('%:e')
  let l:base = expand('%:r')

  if l:ext =~# '^\(h\|hh\|hpp\)$'
    for s in ['cc', 'cpp', 'c']
      if filereadable(l:base . '.' . s)
        execute 'edit ' . l:base . '.' . s
        return
      endif
    endfor
  else
    for h in ['hh', 'hpp', 'h']
      if filereadable(l:base . '.' . h)
        execute 'edit ' . l:base . '.' . h
        return
      endif
    endfor
  endif

  echo "No matching file found"
endfunction

command! SwitchHS call SwitchHeaderSource()
nnoremap <C-h> :SwitchHS<CR>

command! FixFormat %s/\r//g

"quickFix settings
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
autocmd FileType qf wincmd J
autocmd FileType qf nnoremap <buffer> q :cclose<CR>

let g:fzf_layout = { 'down': '40%' }
autocmd FileType fzf wincmd J

nnoremap <leader>p :Files 
nnoremap <leader>g :Rg 

