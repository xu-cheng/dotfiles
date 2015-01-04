let g:enable_numbers = 0
let g:never_enable_numbers = 1

function! MyNumbersToggle()
    if (g:never_enable_numbers)
        exec ':NumbersEnable'
        let g:never_enable_numbers = 0
    else
        exec ':NumbersToggle'
    endif
endfunction

command! -nargs=0 MyNumbersToggle call MyNumbersToggle()

nnoremap <Leader>n :MyNumbersToggle<CR>
