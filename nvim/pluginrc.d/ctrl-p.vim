let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
        \ 'dir':  '\.git$\|\.hg$\|\.svn$|\.DS_Store$',
        \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

" CtrlP extensions
let g:ctrlp_extensions = ['funky']

"funky
nnoremap <Leader>fu :CtrlPFunky<Cr>
