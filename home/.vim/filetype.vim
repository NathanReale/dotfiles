if exists("did_load_filetypes")
  finish
end
augroup filetypedetect
  au BufNewFile,BufRead /tmp/*#* exe "doau filetypedetect BufRead " . substitute(expand("<afile>"), "\\(/tmp/.*\\)#[0-9]\\+", "\\1", "")
augroup END
