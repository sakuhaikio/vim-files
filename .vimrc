" =============================================================================
" Vim configuration
" =============================================================================
" Purpose: terminal-first C/C++ development with coc.nvim, NERDTree and fzf.
" Leader: Space (set before any mappings).
"
" Key conventions:
"   <leader>p / <leader>g   Find files / search project text
"   <leader>bb              Pick an open buffer with fzf
"   <leader>bn/bp/bd/bl     Next / previous / delete / list buffers
"   <leader>f               Format buffer (Visual: format selection)
"   <leader>rn              Rename symbol
"   <leader>o               Current-file symbol outline
"   <C-n> / <C-h>           NERDTree / switch C++ header-source
"   gd/gD/gy/gi/gr          Definition/declaration/type/implementation/refs
"   [g / ]g                Previous / next diagnostic
"   K                      Hover documentation
"   <leader><Space>         Clear search highlighting
"   <leader>"               Surround word/selection with double quotes
"   <leader>'               Surround word/selection with single quotes
"   <leader>)/]/}/>         Surround with (), [], {} or <>
"
" Commands:
"   :FixFormat             Remove carriage-return characters (^M)
"   :CpFileName            Copy filename including extension
"   :CpFileStem            Copy filename without final extension
"   :CpRelPath             Copy path relative to Vim's current directory
"   :CpAbsPath             Copy absolute path
"   :CpLine / :Cpl         Copy current line without leading indentation
"   IncludeGuard()         Experimental include-guard helper function
"
" Dependencies: vim-plug, coc.nvim, NERDTree, fzf.vim, fzf, rg, fdfind.
" fzf.vim is configured below but is not installed by this vim-plug block.
" Clipboard commands require a Vim build with +clipboard and a working + register.
" =============================================================================

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
augroup UserEditingOptions
  autocmd!
  autocmd FileType * setlocal formatoptions-=cro
augroup END

" Make Ctrl+C behave like Esc in insert mode
inoremap <C-c> <Esc>

" Make Y behave like D and C: operate until end of line
nnoremap Y y$

" Move by screen lines when wrapping is enabled.
" Otherwise use normal logical line movement.
nnoremap <expr> j &wrap ? 'gj' : 'j'
nnoremap <expr> k &wrap ? 'gk' : 'k'
vnoremap <expr> j &wrap ? 'gj' : 'j'
vnoremap <expr> k &wrap ? 'gk' : 'k'

" Terminal mode: Esc returns to normal mode
tnoremap <Esc> <C-\><C-n>

" ============================================================================
" Search / grep
" ============================================================================

" Use ripgrep for :grep
set grepprg=rg\ --vimgrep\ --smart-case\ --glob\ '!build/**'
set grepformat=%f:%l:%c:%m

" Search files with fzf
let $FZF_DEFAULT_COMMAND = 'fdfind
    \ --type f
    \ --hidden
    \ --exclude .git
    \ --exclude build
    \ --exclude out
    \ --exclude cmake-build-debug
    \ --exclude cmake-build-release
    \ --exclude .cache'


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
let g:NERDTreeShowHidden = 0

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

" Format Visual selection
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
augroup UserQuickfix
  autocmd!
  autocmd FileType qf wincmd J
  " Buffer-local mappings: only affect quickfix windows.
  autocmd FileType qf nnoremap <buffer> q :cclose<CR>
  autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
augroup END


" ============================================================================
" fzf.vim
" ============================================================================

" Open fzf at the bottom
let g:fzf_layout = { 'down': '40%' }
augroup UserFzf
  autocmd!
  autocmd FileType fzf wincmd J
augroup END

" File search
nnoremap <leader>p :Files<CR>

" Text search with ripgrep
nnoremap <leader>g :Rg<CR>

" Open-buffer search with fzf
nnoremap <leader>bb :Buffers<CR>

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
augroup UserCppFiletypes
  autocmd!
  autocmd BufNewFile,BufRead *.tpp setfiletype cpp
augroup END


" ============================================================================
" C / C++ helpers
" ============================================================================

" Switch between header and source files
nnoremap <silent> <C-h> :CocCommand clangd.switchSourceHeader<CR>


" ============================================================================
" Custom commands
" ============================================================================

" :FixFormat is defined in the custom commands section below.


" =============================================================================
" Custom commands: text cleanup and C/C++ helpers
" =============================================================================
" Remove Windows CR characters from the current buffer.
command! FixFormat silent! %s/\r//ge

" Insert a simple include guard based on the current filename.
" WARNING: filename-only guards may collide across directories; the function
" also assumes a suitable header buffer. Review before using on existing files.
function! IncludeGuard() abort
    let guard = toupper(expand('%:t'))
    let guard = substitute(guard, '[^A-Z0-9]', '_', 'g')

    execute 'normal! ggO#ifndef ' . guard
    execute 'normal! o#define ' . guard
    execute 'normal! Go#endif // ' . guard
endfunction

" WSL-only shortcut to strip CR after Windows clipboard pastes.
if exists('$WSL_DISTRO_NAME')
    nnoremap <silent> <leader><leader> :FixFormat<CR>
endif

" =============================================================================
" Custom commands: clipboard
" =============================================================================
" %:t = filename; %:t:r = stem; %:. = cwd-relative; %:p = absolute.
" @+ is the system clipboard. These commands do not modify the buffer.
command! CpFileName let @+ = expand('%:t')
command! CpFileStem let @+ = expand('%:t:r')
command! CpRelPath  let @+ = expand('%:.')
command! CpAbsPath  let @+ = expand('%:p')

" getline('.') reads the cursor line; ^\s* strips leading spaces/tabs.
" Trailing whitespace is preserved; no newline is appended.
command! CpLine let @+ = substitute(getline('.'), '^\s*', '', '')
command! Cpl CpLine


" =============================================================================
" Custom mappings: surround text
" =============================================================================
" Normal mode: ciw replaces the word under the cursor.
" Visual mode: c replaces the selected text.
" <C-r>" inserts the replaced text from the unnamed register.
" NOTE: these mappings overwrite the unnamed register; they are primarily
" intended for characterwise Visual selections, not line/block selections.
" Original navigation keys remain intact: all mappings require <leader>.

" Double quotes: "..."
nnoremap <leader>" ciw"<C-r>""<Esc>
xnoremap <leader>" c"<C-r>""<Esc>

" Single quotes: '...'
nnoremap <leader>' ciw'<C-r>"'<Esc>
xnoremap <leader>' c'<C-r>"'<Esc>

" Parentheses: (...)
nnoremap <leader>) ciw(<C-r>")<Esc>
xnoremap <leader>) c(<C-r>")<Esc>

" Square brackets: [...]
nnoremap <leader>] ciw[<C-r>"]<Esc>
xnoremap <leader>] c[<C-r>"]<Esc>

" Braces: {...}
nnoremap <leader>} ciw{<C-r>"}<Esc>
xnoremap <leader>} c{<C-r>"}<Esc>

" Angle brackets: <...>
nnoremap <leader>> ciw<<C-r>"><Esc>
xnoremap <leader>> c<<C-r>"><Esc>

