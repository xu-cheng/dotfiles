let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'

let g:ale_lint_delay = 500

" Install linters
" markdownlint: npm install -g markdownlint-cli
" languagetool: brew install languagetool

if !exists('g:ale_linters')
    let g:ale_linters = {}
endif

" C/C++ linter
let g:ale_linters.c = ['clang-format']
let g:ale_linters.cpp = ['clang-format']

" LaTeX linter
let g:ale_linters.tex = ['chktex']

