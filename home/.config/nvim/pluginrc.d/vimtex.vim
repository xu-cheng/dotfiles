let g:tex_flavor = 'latex'
" Ref: https://b4winckler.wordpress.com/2010/08/07/using-the-conceal-vim-feature-with-latex/
let g:tex_conceal = 'adgm'
let g:vimtex_view_method = 'skim'
let g:vimtex_quickfix_latexlog = {'default' : 0}
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_progname = 'nvr'

" Backward Search
" set up a `Custom` sync profile in Skim
" command: `/usr/local/bin/nvr`
" arguments: `--servername "/tmp/nvimsocket" --remote-silent +"%line" "%file"`

" TeX Word Count
function! TeXWordCount()
    let l:main_tex_dir = b:vimtex.root
    let l:main_tex_file = b:vimtex.base
    echo system('cd ' . shellescape(l:main_tex_dir) .
                \ ' && texcount ' . shellescape(l:main_tex_file))
endfunction
autocmd FileType tex nnoremap <localleader>lw :call TeXWordCount()<cr>

" Autocomplete
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = [
        \ 're!\\[A-Za-z]*cite[A-Za-z]*(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\[A-Za-z]*ref({[^}]*|range{([^,{}]*(}{)?))',
        \ 're!\\hyperref\[[^]]*',
        \ 're!\\includegraphics\*?(\[[^]]*\]){0,2}{[^}]*',
        \ 're!\\(include(only)?|input){[^}]*',
        \ 're!\\\a*(gls|Gls|GLS)(pl)?\a*(\s*\[[^]]*\]){0,2}\s*\{[^}]*',
        \ 're!\\includepdf(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\includestandalone(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\usepackage(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\documentclass(\s*\[[^]]*\])?\s*\{[^}]*',
        \ 're!\\[A-Za-z]*',
        \ ]
let g:ycm_semantic_triggers.rnoweb = g:ycm_semantic_triggers.tex

" Linter
let g:syntastic_tex_checkers = ['chktex']

" Autoformat
let g:formatdef_latexindent = '"latexindentwrapper"'
let g:formatters_tex = ['latexindent']

" Table of Content
autocmd FileType tex,rnoweb nnoremap <silent> <leader>tt :VimtexTocToggle<CR>

