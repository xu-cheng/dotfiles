let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#close_symbol = '×'
if &background ==# 'dark'
    let g:airline_theme = 'bubblegum'
else
    let g:airline_theme = 'solarized'
endif

" prevent airline auto freshing tmuxline
let g:airline#extensions#tmuxline#enabled = 0
let g:tmuxline_theme = 'airline'
