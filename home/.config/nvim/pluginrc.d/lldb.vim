if !has('mac')
    finish
endif

call remote#host#RegisterPlugin(
    \ 'python',
    \ g:vim_home . 'plugged/lldb.nvim/rplugin/python/lldb_nvim',
    \ [ {
    \     'sync': v:false,
    \     'name': 'LLsession',
    \     'type': 'command',
    \     'opts': {'complete': 'customlist,lldb#session#complete', 'nargs': '+'}
    \ } ])

" Add and remove breakpoints on the current lines.
nmap <F9> <Plug>LLBreakSwitch

" Run
nnoremap <F5> :LL process launch<CR>
" Stop
nnoremap <S-F5> :LL process kill<CR>

" Step Into
nnoremap <F11> :LL step<CR>
" Step Over
nnoremap <F10> :LL next<CR>
" Step Out
nnoremap <S-F11> :LL finish<CR>

