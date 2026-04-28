set nocompatible
filetype on
filetype off
call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'morhetz/gruvbox'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Yggdroot/indentLine'
Plug 'jeetsukumaran/vim-buffergator'
"Plug 'vimpostor/vim-lumen'
call plug#end()
filetype plugin indent on
syntax on

set encoding=utf-8
if !exists('g:gruvbox_bold')
  let g:gruvbox_bold=1
endif
if !exists('g:gruvbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:gruvbox_italic=1
  else
    let g:gruvbox_italic=0
  endif
endif
set termguicolors
colorscheme gruvbox

filetype indent on

set tabstop=8 softtabstop=0 expandtab shiftwidth=2 smarttab
set number showcmd wildmenu lazyredraw showmatch cursorline
set incsearch hlsearch mouse=a

let mapleader=","
set backspace=indent,eol,start

nnoremap <leader>u :UndotreeShow<CR>
nmap <silent> <C-n> :bp <CR>
nmap <silent> <C-m> :bn <CR>
nmap <silent> <C-b> :bd <CR>
noremap <leader>n :NERDTreeToggle<CR>
nmap <silent> <C-Up> :wincmd k<CR>
nmap <silent> <C-Down> :wincmd j<CR>
nmap <silent> <C-Left> :wincmd h<CR>
nmap <silent> <C-Right> :wincmd l<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_include_dirs = [ '/usr/local/include/opencv4' ]
let g:syntastic_cpp_compiler_options = '-std=c++11'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Editing a protected file as 'sudo'
cmap W w !sudo tee % >/dev/null<CR>

"cmdline windows with ESC ktm
augroup CommandLineWindow
    autocmd!
    autocmd CmdwinEnter * nnoremap <buffer> <esc> :q<cr>
augroup END

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

let g:fzf_colors =
\ { 'fg':         ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'preview-bg': ['bg', 'NormalFloat'],
  \ 'hl':         ['fg', 'Comment'],
  \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':        ['fg', 'Statement'],
  \ 'info':       ['fg', 'PreProc'],
  \ 'border':     ['fg', 'Ignore'],
  \ 'prompt':     ['fg', 'Conditional'],
  \ 'pointer':    ['fg', 'Exception'],
  \ 'marker':     ['fg', 'Keyword'],
  \ 'spinner':    ['fg', 'Label'],
  \ 'header':     ['fg', 'Comment'] }
