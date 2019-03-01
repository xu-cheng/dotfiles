autocmd BufEnter * call ncm2#enable_for_buffer()

let g:ncm2_look_enabled = 1
let g:ncm2_look#source_override = { 'priority': 2 }

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c
" per ncm document
set completeopt=noinsert,menuone,noselect

" Compatible with vim-multiple-cursors
function! g:Multiple_cursors_before()
  call ncm2#lock('vim-multiple-cursors')
endfunction

function! g:Multiple_cursors_after()
  call ncm2#unlock('vim-multiple-cursors')
endfunction

" LSP
if exists('$TMPDIR')
  let s:tmp_dir = $TMPDIR
elseif exists('$XDG_CACHE_HOME')
  let s:tmp_dir = $XDG_CACHE_HOME
else
  let s:tmp_dir = '/tmp'
endif
let s:cquery_opts = {
      \ 'cacheDirectory': s:tmp_dir . '/cquery',
      \ 'extraClangArguments': [
      \     '-Wall',
      \     '-Wextra',
      \     '-Werror',
      \     '-Wno-long-long',
      \     '-Wno-variadic-macros',
      \     '-fexceptions',
      \     '-DNDEBUG',
      \   ],
      \ }
" install LSP:
" * c/cpp: `brew install cquery`
" * python: `pip3 install python-language-server`
" * rust: See notes/rust.md
" * sh: `npm install -g bash-language-server`
let g:LanguageClient_serverCommands = {
      \ 'c': ['cquery', '--log-all-to-stderr', '--init=' . json_encode(s:cquery_opts)],
      \ 'cpp': ['cquery', '--log-all-to-stderr', '--init=' . json_encode(s:cquery_opts)],
      \ 'python': ['pyls'],
      \ 'rust': ['rls'],
      \ 'sh': ['bash-language-server', 'start'],
      \ }
let g:LanguageClient_diagnosticsDisplay = {
      \    1: {
      \        'name': 'Error',
      \        'texthl': 'ALEError',
      \        'signText': '✗',
      \        'signTexthl': 'ALEErrorSign',
      \    },
      \    2: {
      \        'name': 'Warning',
      \        'texthl': 'ALEWarning',
      \        'signText': '⚠',
      \        'signTexthl': 'ALEWarningSign',
      \    },
      \    3: {
      \        'name': 'Information',
      \        'texthl': 'ALEInfo',
      \        'signText': 'ℹ',
      \        'signTexthl': 'ALEInfoSign',
      \    },
      \    4: {
      \        'name': 'Hint',
      \        'texthl': 'ALEInfo',
      \        'signText': '➤',
      \        'signTexthl': 'ALEInfoSign',
      \    },
      \ }

" Omni completion
let s:omni_funcs = {}
let s:omni_funcs.css = 'csscomplete#CompleteCSS'
let s:omni_funcs.html = 'htmlcomplete#CompleteTags'
let s:omni_funcs.markdown = 'htmlcomplete#CompleteTags'
let s:omni_funcs.javascript = 'javascriptcomplete#CompleteJS'
let s:omni_funcs.xml = 'xmlcomplete#CompleteTags'
let s:omni_funcs.ruby = 'rubycomplete#Complete'
let s:omni_funcs.haskell = 'necoghc#omnifunc'
augroup ncm2_omni_completion
  autocmd!
  for s:ftype in keys(s:omni_funcs)
    autocmd FileType s:ftype call ncm2#register_source({
          \ 'name': s:ftype . '_omni',
          \ 'priority': 8,
          \ 'subscope_enable': 1,
          \ 'scope': [s:ftype],
          \ 'mark': '⌾',
          \ 'word_pattern': '\w+',
          \ 'complete_pattern': '.',
          \ 'on_complete': ['ncm2#on_complete#delay', 250,
          \                 'ncm2#on_complete#omni', s:omni_funcs[s:ftype]],
          \ })
  endfor
augroup END

" Keymap

imap <C-n> <Plug>(ncm2_manual_trigger)
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Ref: https://github.com/ncm2/ncm2/issues/129
inoremap <silent> <Plug>(MyCR) <CR><C-R>=AutoPairsReturn()<CR>
inoremap <silent> <expr> <CR> ncm2_ultisnips#expand_or("\<Plug>(MyCR)", 'im')

let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsJumpBackwardTrigger = "<C-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=
endif
