set nocompatible
filetype off

" Set these before importing plugins.
let mapleader=","
let maplocalleader="\\"

" Load Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" Vundle Plugins
Plugin 'sjl/badwolf'

Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-commentary'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-vinegar'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'johnsyweb/vim-makeshift'

Plugin 'google/vim-maktaba'
Plugin 'google/vim-syncopate'
call vundle#end()

" Load a local plugins file if it exists
if filereadable(expand("\~/.vimrc.local.plugins"))
  source \~/.vimrc.local.plugins
endif

filetype plugin indent on

syntax on
set relativenumber
set number  " Current line shows line number, all other relative
set shiftwidth=2
set tabstop=2
set expandtab
set autoindent
set showmatch
set incsearch
set hls
set ignorecase
set smartcase
set gdefault
set cursorline
set scrolloff=4
set mouse=a
set backspace=2
set laststatus=2
set modelines=0
set showcmd
set visualbell

" Use the badwolf colorscheme
let g:badwolf_darkgutter = 1
set background=dark
colorscheme badwolf

if has('gui_running')
  set guifont=Droid\ Sans\ Mono\ for\ Powerline

  " Get rid of most of the toolbars and scrollbars in gvim
  set go-=m
  set go-=T
  set go-=l
  set go-=L
  set go-=r
  set go-=R

  " Use system clipboard
  set go-=a
  set go+=P

  highlight SpellBad term=underline gui=undercurl guisp=Orange

  " Different cursors for different modes.
  set guicursor=n-c:block-Cursor-blinkon0
  set guicursor+=v:block-vCursor-blinkon0
  set guicursor+=i-ci:ver20-iCursor
else
  set t_Co=256

  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=

  " Reset the colorscheme because we updated the number of colors
  colorscheme badwolf
endif

" Customize airline
let g:airline_theme = 'badwolf'
let g:airline_powerline_fonts = 1

" Brighten the status lines of inactive windows, so they are readable.
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  " Update the badwolf theme to have better inactive window colors
  if g:airline_theme == 'badwolf'
    for colors in values(a:palette.inactive)
      let colors[1] = "#45413b"
      let colors[0] = "#8cffba"
    endfor
  endif
endfunction

" Make j and k work well with wrapped lines
nnoremap j gj
nnoremap k gk

" Make jk and kj escape
inoremap jk <esc>
inoremap kj <esc>

" Stop using the arrow keys
nnoremap <left> <nop>
nnoremap <right> <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>

" Complete the longest common subsequence and always show the menu
set completeopt=menuone,longest,preview

" Turn on spell checking by default
" It can be toggled with leader s
set spell spelllang=en_us
set spellfile=~/.vim/spellfile.add
set spellcapcheck=
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" Paste from clipboard (with paste mode)
noremap <silent> <leader>p :set paste<CR>"*p:set nopaste<CR>

" Reselect what was just pasted
" Useful for re-indenting pasted blocks
nnoremap gp `[v`]

" Toggle search highlighting
nnoremap <silent> <space> :noh<CR>

" Open vimrc in a split
nnoremap <leader>v :vsplit $MYVIMRC<CR>

set formatoptions=
set formatoptions+=c  " auto-wrap comments
set formatoptions+=r  " insert comment marker
set formatoptions+=o  " insert comment marker
set formatoptions+=q  " allow formatting of comments
" set formatoptions+=a  " auto format
set formatoptions+=n  " format numbered lists
set formatoptions+=2  " Use the second line of a paragraph for indent level
set formatoptions+=1  " Don't break lines that are already too long
set formatoptions+=j  " Remove extra comment when joining lines
set formatoptions+=l  " Don't break lines that are already too long

" Add a line at the 80 column mark
set colorcolumn=80
highlight ColorColumn ctermbg=7

" Syntastic options
let g:syntastic_check_on_open = 1

" Ctrl-P
let g:ctrlp_map = '<leader>,'
let g:ctrlp_working_path_mode = 'a'
nnoremap <leader>b :CtrlPBuffer<cr>

" Call Ack with the current token
nnoremap <leader>sa :Ack <cword><cr>

" Make YCM close the scratch window
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" Shortcut for Syncopate
nnoremap <leader>e :SyncopateExportToBrowser<cr>

" Compile and run the current file
nnoremap <leader>m :MakeshiftBuild<CR><CR>

" Make it easier to enter a command
nnoremap ; :

" ctrl-jklm  changes to that split
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Cycle through buffers easily
map <C-space> :bn <CR>
map <C-M-space> :bp <CR>

" Save when losing focus
au FocusLost * :silent! wall

" Only show cursorline in the current window and in normal mode.
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

set list
set listchars=tab:▸\ 
" Only show trailing spaces when not in insert mode.
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END

" Keep search matches in the middle of the window.
" Added silent to keep the wrap around message visible
nnoremap <silent> n nzzzv
nnoremap <silent> N Nzzzv

" Only format block comments
au FileType javascript setlocal comments-=:// comments+=f://

if filereadable(expand("\~/.vimrc.local"))
  source \~/.vimrc.local
endif
