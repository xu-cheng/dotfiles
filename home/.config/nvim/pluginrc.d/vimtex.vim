let g:tex_flavor = 'latex'
" Ref: https://b4winckler.wordpress.com/2010/08/07/using-the-conceal-vim-feature-with-latex/
let g:tex_conceal = 'adgm'
let g:vimtex_view_method = 'general'
let g:vimtex_view_general_viewer =
            \ '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_quickfix_ignore_all_warnings = 1
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_latexmk_progname = 'nvr'
let g:vimtex_latexmk_callback_hooks = ['VimtexUpdateView']
function! VimtexUpdateView(status)
    if !a:status | return | endif
    let l:out = b:vimtex.out()
    let l:tex = expand('%:p')
    let l:cmd = [g:vimtex_view_general_viewer, '-r']
    if !empty(system('pgrep Skim'))
        call extend(l:cmd, ['-g'])
    endif
    if has('nvim')
        call jobstart(l:cmd + [line('.'), l:out, l:tex])
    elseif has('job')
        call job_start(l:cmd + [line('.'), l:out, l:tex])
    else
        call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
    endif
endfunction

" Backward Search
" set up a `Custom` sync profile in Skim
" command: `/usr/local/bin/nvr`
" arguments: `--servername "/tmp/nvimsocket" --remote-silent +"%line" "%file"`

" TeX Word Count
function! TeXWordCount()
    let l:main_tex_dir = b:vimtex.root
    let l:main_tex_file = b:vimtex.base
    :echo system('cd "' . l:main_tex_dir . '"; texcount "' . l:main_tex_file . '"')
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
            \ ]

" Linter
let g:syntastic_tex_checkers = ['chktex']

" Autoformat
let g:formatdef_latexindent = '"latexindentwrapper"'
let g:formatters_tex = ['latexindent']

" Table of Content
autocmd FileType tex nnoremap <silent> <leader>tt :VimtexTocToggle<CR>

