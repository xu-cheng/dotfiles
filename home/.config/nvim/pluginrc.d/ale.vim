let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'

let g:ale_lint_delay = 500

if !exists('g:ale_linters')
    let g:ale_linters = {}
endif

" C/C++ lint
let g:ale_linters.c = ['clang-format']
let g:ale_linters.cpp = ['clang-format']

" LaTeX lint
let g:ale_linters.tex = ['chktex', 'proselint']
