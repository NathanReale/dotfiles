" Vim script to be used for g4 diff.
" Opens a tab for each pair of files.
"
" Use these environment variables:
" P4DIFF        "gvim -f '+so /home/bramm/.vim/p4diff.vim'"
" G4MULTIDIFF   1

augroup g4file
  au!
  au BufRead ?\+#[0-9]\+  exe "doau filetypedetect BufRead " . fnameescape(substitute(expand("<afile>"), '#[0-9]\+$', '', ''))
augroup END

set columns=205
set lazyredraw
set splitright  " put new version right of the old version

let s:idx = 0
while s:idx < argc()
  if argv(s:idx) != ':'
    if s:idx > 2
      tabnew
    endif
    exe "silent edit " . fnameescape(argv(s:idx))
    let s:idx += 1
    exe "silent vertical diffsplit " . fnameescape(argv(s:idx))
    102wincmd |
  endif
  let s:idx += 1
endwhile

" GTK resizing doesn't work very well when the tab pages labels appear.
" Reduce the number of lines here.
" set lines-=2

" Go to first tab page
tabrewind

" redraw now
set nolazyredraw
redraw

" Special mappings for diff
nnoremap <space> ]czz
nnoremap <S-space> [czz
nnoremap <leader>n :tabnext<cr>
nnoremap <leader>c :tabclose<cr>
