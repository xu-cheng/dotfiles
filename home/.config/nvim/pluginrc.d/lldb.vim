if !executable('lldb')
    finish
endif

" NOTE: remember to create file `/usr/local/lib/python2.7/site-packages/llvm.pth`
" with following content after `brew install llvm --with-lldb --with-python`:
"   /usr/local/opt/llvm/lib/python2.7/site-packages
"   /usr/local/opt/llvm/lib/python2.7/site-packages/lldb

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

