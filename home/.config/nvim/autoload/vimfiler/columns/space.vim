function! vimfiler#columns#space#define() abort
  return s:column
endfunction

let s:column = {
      \ 'name' : 'space',
      \ 'description' : 'just to insert a space',
      \ 'syntax' : 'vimfilerColumn__Space',
      \ }

function! s:column.length(files, context) abort
  return 1
endfunction

function! s:column.define_syntax(context) abort
endfunction

function! s:column.get(file, context) abort
    return ' '
endfunction
