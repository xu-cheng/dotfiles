let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'

if !exists('g:ale_linters')
    let g:ale_linters = {}
endif

" C/C++ lint
let g:ycm_error_symbol = g:ale_sign_error
let g:ycm_warning_symbol = g:ale_sign_warning
let g:ale_linters.c = []
let g:ale_linters.cpp = []
highlight link YcmWarningSign ALEWarningSign
highlight link YcmErrorSign ALEErrorSign
highlight link YcmWarningLine ALEWarningLine
highlight link YcmErrorLine ALEErrorLine
highlight link YcmErrorSection ALEError
highlight link YcmWarningSection ALEWarning

" LaTeX lint
let g:ale_linters.tex = ['chktex']
