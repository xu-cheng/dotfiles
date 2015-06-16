let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer = 'open'
let g:vimtex_view_general_options = '-a Skim'

" Backward Search
" set up a `Custom` sync profile in Skim
" command: `nvim`
" arguments: `--remote-silent +"%line" "%file"`

" Forward Search
function! SyncTexForward()
    let l:pdf_file = b:vimtex.out()
    let l:tex_file = expand('%:p')
    let l:tex_line = line(".")
    :call system('displayline' . ' -r ' . l:tex_line . ' "' . l:pdf_file . '" "' . l:tex_file . '"')
endfunction
nmap <localleader>ls :call SyncTexForward()<cr>

" TeX Word Count
function! TeXWordCount()
    let l:main_tex_dir = b:vimtex.root
    let l:main_tex_file = b:vimtex.base
    :echo system('cd "' . l:main_tex_dir . '"; texcount "' . l:main_tex_file . '"')
endfunction
nmap <localleader>lw :call TeXWordCount()<cr>
