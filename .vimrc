" ============================================================================
" Custom Keybindings and Commands
" ============================================================================
"
" Leader key:
"   <leader> = Space
"
"
" ----------------------------------------------------------------------------
" Search / Navigation
" ----------------------------------------------------------------------------
"
"   <leader><space>   Clear search highlight
"
"   <leader>p         Open :Files (fzf file search)
"   <leader>g         Open :Rg (ripgrep search)
"
"   gd                Go to definition
"   gD                Go to declaration
"   gy                Go to type definition
"   gi                Go to implementation
"   gr                Show references
"
"   K                 Show hover documentation
"
"
" ----------------------------------------------------------------------------
" Buffers
" ----------------------------------------------------------------------------
"
"   <leader>bn        Next buffer
"   <leader>bp        Previous buffer
"   <leader>bd        Delete current buffer
"   <leader>bl        List buffers and start :buffer command
"
"
" ----------------------------------------------------------------------------
" coc.nvim
" ----------------------------------------------------------------------------
"
"   <leader>rn        Rename symbol
"
"   <leader>f         Format current buffer
"   Visual <leader>f  Format selected text
"
"   [g                Previous diagnostic
"   ]g                Next diagnostic
"
"   <leader>o         Show symbol outline for current file
"
"   Tab               Next completion item
"   Shift-Tab         Previous completion item
"
"
" ----------------------------------------------------------------------------
" NERDTree
" ----------------------------------------------------------------------------
"
"   Ctrl+n            Toggle NERDTree
"
"
" ----------------------------------------------------------------------------
" C / C++ helpers
" ----------------------------------------------------------------------------
"
"   Ctrl+h            Switch between header and source file
"
"
" ----------------------------------------------------------------------------
" Terminal mode
" ----------------------------------------------------------------------------
"
"   Esc               Exit terminal mode to normal mode
"
"
" ----------------------------------------------------------------------------
" Insert mode tweaks
" ----------------------------------------------------------------------------
"
"   Ctrl+c            Behave like Esc in insert mode
"
"
" ----------------------------------------------------------------------------
" Quickfix
" ----------------------------------------------------------------------------
"
"   q                 Close quickfix window
"   Enter             Open quickfix item and close quickfix window
"
"
" ----------------------------------------------------------------------------
" Custom Commands
" ----------------------------------------------------------------------------
"
"   :SwitchHS         Switch between header and source file
"
"   :FixFormat        Remove Windows carriage returns (^M)
"
" ============================================================================





" ============================================================================
" General
" ============================================================================

set nocompatible
syntax on
filetype plugin indent on

set encoding=utf-8
set noerrorbells
set visualbell
set t_vb=
set belloff=all

" Leader keys
let mapleader = " "
let maplocalleader = " "


" ============================================================================
" UI
" ============================================================================

set number
set cursorline
set showmatch
set signcolumn=yes
set scrolloff=3

set termguicolors
set t_Co=256
set t_ut=

" Command-line completion menu
set wildmenu
set wildmode=longest:full,full

" Highlight search matches
set hlsearch

" Clear search highlight
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Safe colorscheme loading
silent! colorscheme omateema


" ============================================================================
" Editing behavior
" ============================================================================

set hidden
set backspace=indent,eol,start

set ignorecase
set smartcase

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" Make undo break after inserting a space
inoremap <Space> <Space><C-g>u

" Keep formatoptions sane.
" Do not automatically continue comments when pressing Enter or using o/O.
set formatoptions+=/
autocmd FileType * setlocal formatoptions-=cro

" Make Ctrl+C behave like Esc in insert mode
imap <C-c> <Esc>

" Make Y behave like D and C: operate until end of line
nnoremap Y y$

" Terminal mode: Esc returns to normal mode
tnoremap <Esc> <C-\><C-n>


" ============================================================================
" Search / grep
" ============================================================================

" Use ripgrep for :grep
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
set grepformat=%f:%l:%c:%m


" ============================================================================
" Swap, backup and undo files
" ============================================================================

set undofile
set swapfile

set nobackup
set nowritebackup

" Store generated Vim files under ~/.vim
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


" ============================================================================
" Plugin manager
" ============================================================================

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'
call plug#end()


" ============================================================================
" Plugin performance
" ============================================================================

" Faster responsiveness for plugins such as coc.nvim
set updatetime=300


" ============================================================================
" NERDTree
" ============================================================================

let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 0
let g:NERDTreeShowHidden = 1

" Toggle NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>


" ============================================================================
" Buffers
" ============================================================================

" Next / previous buffer
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>

" Delete current buffer
nnoremap <leader>bd :bd<CR>

" List buffers and start :buffer command
nnoremap <leader>bl :ls<CR>:b<Space>


" ============================================================================
" coc.nvim completion
" ============================================================================

" Navigate completion popup with Tab / Shift-Tab
inoremap <expr> <Tab>   coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"


" ============================================================================
" coc.nvim navigation
" ============================================================================

" Go to definition / declaration / type definition / implementation / references
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD <Plug>(coc-declaration)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Show hover documentation
nnoremap <silent> K :call CocActionAsync('doHover')<CR>

" Show symbols in current file
nnoremap <silent> <leader>o :CocList outline<CR>


" ============================================================================
" coc.nvim formatting
" ============================================================================

" Format current buffer
nmap <leader>f <Plug>(coc-format)

" Format visual selection
xmap <leader>f <Plug>(coc-format-selected)


" ============================================================================
" coc.nvim diagnostics
" ============================================================================

" Previous / next diagnostic
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" ============================================================================
" Quickfix
" ============================================================================

" Put quickfix window at the bottom
autocmd FileType qf wincmd J

" Close quickfix with q
autocmd FileType qf nnoremap <buffer> q :cclose<CR>

" Open selected quickfix item and close the quickfix window
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>


" ============================================================================
" fzf.vim
" ============================================================================

" Open fzf at the bottom
let g:fzf_layout = { 'down': '40%' }
autocmd FileType fzf wincmd J

" File search
nnoremap <leader>p :Files 

" Text search with ripgrep
nnoremap <leader>g :Rg 


" ============================================================================
" Cursor shape in terminal Vim
" ============================================================================

if exists('&t_SI')
  let &t_SI = "\<Esc>[6 q" " Insert mode: bar
  let &t_SR = "\<Esc>[4 q" " Replace mode: underline
  let &t_EI = "\<Esc>[2 q" " Normal mode: block
endif


" ============================================================================
" Filetype tweaks
" ============================================================================

" Treat .tpp files as C++
autocmd BufNewFile,BufRead *.tpp setfiletype cpp


" ============================================================================
" C / C++ helpers
" ============================================================================

" Switch between header and source files
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


" ============================================================================
" Custom commands
" ============================================================================

" Remove Windows carriage returns from current file
command! FixFormat %s/\r//g
