let g:tex_flavor = 'latex'
" Ref: https://b4winckler.wordpress.com/2010/08/07/using-the-conceal-vim-feature-with-latex/
let g:tex_conceal = 'adgm'
let g:vimtex_quickfix_latexlog = {'default' : 0}
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_progname = 'nvr'
if has('mac')
    let g:vimtex_view_method = 'skim'
elseif has('win32')
    let g:vimtex_view_method = 'general'
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options
                \ = '-reuse-instance -forward-search @tex @line @pdf'
    let g:vimtex_view_general_options_latexmk = '-reuse-instance'
endif

" Backward Search
" set up a `Custom` sync profile in Skim
" command: `$HOME/.bin/synctex-callback`
" arguments: `"%file" "%line"`

" TeX Word Count
function! TeXWordCount()
    let l:main_tex_dir = b:vimtex.root
    let l:main_tex_file = b:vimtex.base
    echo system('cd ' . shellescape(l:main_tex_dir) .
                \ ' && texcount ' . shellescape(l:main_tex_file))
endfunction

augroup tex
    autocmd!
    autocmd FileType tex nnoremap <silent> <localleader>lw :call TeXWordCount()<CR>
    autocmd FileType tex,rnoweb nnoremap <silent> <leader>tt :VimtexTocToggle<CR>
augroup END

" Autocomplete
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
let g:ycm_semantic_triggers.rnoweb = g:vimtex#re#youcompleteme

" Autoformat
let g:formatdef_latexindent = '"latexindent --logfile=/dev/null -y=\"defaultIndent:\\\"" . repeat(" ", &shiftwidth) . "\\\"\""'
let g:formatters_tex = ['latexindent']

