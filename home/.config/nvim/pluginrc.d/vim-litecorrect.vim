augroup litecorrect_group
  autocmd!
  autocmd FileType markdown,mkd call litecorrect#init()
  autocmd FileType textile call litecorrect#init()
  autocmd FileType tex call litecorrect#init()
augroup END
