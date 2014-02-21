set encoding=utf-8

" Load the vundle config
source ~/.vim/vundle.vim

" Installed Plugins
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-commentary'
Bundle 'scrooloose/syntastic'
Bundle 'majutsushi/tagbar'
Bundle 'LaTeX-Box'
Bundle 'snipMate'
Bundle 'Command-T'
Bundle 'MatchTag'
Bundle 'Lokaltog/vim-powerline'
Bundle 'johnsyweb/vim-makeshift'

syntax on
set number
set shiftwidth=4
set tabstop=4
set autoindent
set showmatch
set incsearch
set hls
set ignorecase
set smartcase
set cursorline
set scrolloff=4
set mouse=a
set ttymouse=xterm2
set background=dark
set t_Co=256
set backspace=2
colorscheme molokai
let mapleader=","
let maplocalleader=","

filetype plugin on
filetype indent on


" Set status line (Currently uses Powerline)
"set statusline=%f\ %m\ %r\ Line:%l/%L[%p%%]\ Col:%c\ Buf:%n\ [%b][0x%B]
set laststatus=2

" Save when vim loses focus
au FocusLost * :wa

let g:LatexBox_viewer = 'open -a Skim'
let g:LatexBox_latexmk_option = '-pvc'

" Add spell check, ignore caps
set nospell spelllang=en_us
set spellfile=~/.vim/spellfile.add
set spellcapcheck=


" Use w!! to write protected file
cmap w!! %!sudo tee > /dev/null %

" Use jj for escape
ino jj <esc>
cno jj <C-c>

nnoremap j gj
nnoremap k gk

" Remap ; to :
nnoremap ; :

" Compile and run the current file
nnoremap <leader>m :MakeshiftBuild<CR><CR>

" Toggle spell check
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" Toggle paste mode on and off
set pastetoggle=<leader>p

" Toggle search highlighting
nnoremap <leader>h :set hls!<CR>

" Create a line of equal signs below the current line
nnoremap <leader>= yypVr=

"Realign the current paragraph
nnoremap <leader>w gqap

" Open vimrc in a new window
nnoremap <leader>v :vsplit $MYVIMRC<cr>  

" Open the learn file in a vsplit
nnoremap <leader>l :vsplit ~/.vim/learn.txt<cr>

" Run Bundle Install
nnoremap <leader>bi :BundleInstall<cr>
nnoremap <leader>bu :BundleInstall!<cr>
nnoremap <leader>bl :BundleList<cr>

" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<cr>

" Toggle Tagbar
nnoremap <leader>a :TagbarToggle<cr>

" Call Command-T
nnoremap <leader>t :CommandT<cr>

" Map + and - to chang ewindow size
if bufwinnr(1)
	nnoremap + <C-W>+
	nnoremap - <C-W>-
endif

" Better man page searching
runtime ftplugin/man.vim
nnoremap <silent>K :<C-U>exe "Man" v:count "<cword>"<CR>

" Add fancy symbols to vim-powerline
let g:Powerline_symbols = 'compatible'

let g:syntastic_mode_map = { 'mode': 'active',
	\ 'active_filetypes': [],
	\ 'passive_filetypes': ['html'] }

let g:syntastic_c_include_dirs = ['/nfshome/rbutler/public/courses/pp6430/mpich3i/include']
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = '-Weffc++ -pedantic'
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1

" Source the vimrc file after saving it
au bufwritepost .vimrc source $MYVIMRC

" Disable comments from coninuing onto the next line
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Make python use spaces
au FileType python set expandtab

" Use 2 spaces and no tabs in ruby files
au FileType ruby setlocal et ts=2 sw=2 tw=0

" Turn on spell by default for tex files
au FileType tex setlocal spell

" Only show the quickfix window when there are problems
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
