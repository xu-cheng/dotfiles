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

if !exists('g:ale_linters_ignore')
    let g:ale_linters_ignore = {}
endif

" C/C++ linter
let g:ale_linters.c = ['clang-format']
let g:ale_linters.cpp = ['clang-format']

" LaTeX linter
let g:ale_linters_ignore.tex = ['lacheck']

" Disable linters used by LSP
let g:ale_linters_ignore.c = ['ccls']
let g:ale_linters_ignore.cpp = ['ccls']
let g:ale_linters_ignore.rust = ['cargo']
let g:ale_linters_ignore.bash = ['language-server']
