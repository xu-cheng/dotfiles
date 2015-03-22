let g:latex_view_general_viewer='open'
let g:latex_view_general_options='-a Skim'
let g:latex_fold_envs = 0

" Backward Search
" set up a `Custom` sync profile in Skim
" command: `nvim`
" arguments: `--remote-silent +"%line" "%file"`

" Forward Search
function! SyncTexForward()
    let l:pdf_file = g:vimtex#data[b:vimtex.id].out()
    let l:tex_file = expand('%:p')
    let l:tex_line = line(".")
    :call system('~/Applications/Skim.app/Contents/SharedSupport/displayline'
          \ . ' -r ' . l:tex_line . ' "' . l:pdf_file . '" "' . l:tex_file . '"')
endfunction
nmap <localleader>ls :call SyncTexForward()<cr>
