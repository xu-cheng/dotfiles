let g:tex_flavor = 'latex'
" Ref: https://b4winckler.wordpress.com/2010/08/07/using-the-conceal-vim-feature-with-latex/
let g:tex_conceal = 'adgm'
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
" command: `$HOME/.local/bin/synctex-callback`
" arguments: `"%file" "%line"`

" TeX Word Count
function! TeXWordCount()
  let l:main_tex_dir = b:vimtex.root
  let l:main_tex_file = b:vimtex.base
  echo system('cd ' . shellescape(l:main_tex_dir) .
        \ ' && texcount ' . shellescape(l:main_tex_file))
endfunction

augroup tex_group
  autocmd!
  autocmd FileType tex nnoremap <silent> <localleader>lw :call TeXWordCount()<CR>
  autocmd FileType tex,rnoweb nnoremap <silent> <leader>tt :VimtexTocToggle<CR>

  " Autocomplete
  autocmd Filetype tex,rnoweb call ncm2#register_source({
        \ 'name' : 'vimtex-cmds',
        \ 'priority': 8,
        \ 'complete_length': -1,
        \ 'scope': ['tex', 'rnoweb'],
        \ 'matcher': {'name': 'prefix', 'key': 'word'},
        \ 'word_pattern': '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm2#cmds,
        \ 'on_complete': ['ncm2#on_complete#delay', 250,
        \                 'ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })
  autocmd Filetype tex,rnoweb call ncm2#register_source({
        \ 'name' : 'vimtex-labels',
        \ 'priority': 8,
        \ 'complete_length': -1,
        \ 'scope': ['tex', 'rnoweb'],
        \ 'matcher': {'name': 'combine',
        \             'matchers': [
        \               {'name': 'substr', 'key': 'word'},
        \               {'name': 'substr', 'key': 'menu'},
        \             ]},
        \ 'word_pattern': '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm2#labels,
        \ 'on_complete': ['ncm2#on_complete#delay', 250,
        \                 'ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })
  autocmd Filetype tex,rnoweb call ncm2#register_source({
        \ 'name' : 'vimtex-files',
        \ 'priority': 8,
        \ 'complete_length': -1,
        \ 'scope': ['tex', 'rnoweb'],
        \ 'matcher': {'name': 'combine',
        \             'matchers': [
        \               {'name': 'abbrfuzzy', 'key': 'word'},
        \               {'name': 'abbrfuzzy', 'key': 'abbr'},
        \             ]},
        \ 'word_pattern': '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm2#files,
        \ 'on_complete': ['ncm2#on_complete#delay', 250,
        \                 'ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })
  autocmd Filetype tex,rnoweb call ncm2#register_source({
        \ 'name' : 'bibtex',
        \ 'priority': 8,
        \ 'complete_length': -1,
        \ 'scope': ['tex', 'rnoweb'],
        \ 'matcher': {'name': 'combine',
        \             'matchers': [
        \               {'name': 'prefix', 'key': 'word'},
        \               {'name': 'abbrfuzzy', 'key': 'abbr'},
        \               {'name': 'abbrfuzzy', 'key': 'menu'},
        \             ]},
        \ 'word_pattern': '\w+',
        \ 'complete_pattern': g:vimtex#re#ncm2#bibtex,
        \ 'on_complete': ['ncm2#on_complete#delay', 250,
        \                 'ncm2#on_complete#omni', 'vimtex#complete#omnifunc'],
        \ })
augroup END

" Autoformat
let g:formatdef_latexindent = '"latexindent --logfile=/dev/null -y=\"defaultIndent:\\\"" . repeat(" ", &shiftwidth) . "\\\"\""'
let g:formatters_tex = ['latexindent']

