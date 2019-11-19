augroup filetype_group
    autocmd!

    " Auto detect filetype if uneset
    autocmd BufWritePost * if &filetype == "" | filetype detect | endif
    " Automatically give executable permission to new scripts starting with a shebang (#!)
    autocmd BufWritePre  * if !filereadable(expand('<afile>:p')) | let b:is_new = 1 | endif
    autocmd BufWritePost *
                \ if executable('chmod') && &filetype != "rust" && getline(1) =~ "^#!.*" && get(b:, 'is_new', 0) |
                \   call system('chmod a+x ' . expand('<afile>:p:S')) |
                \ endif

    " set it to the first line when editing a git commit message
    autocmd FileType gitcommit autocmd! BufEnter COMMIT_EDITMSG
                \ call setpos('.', [0, 1, 1, 0])

    " Disable spelling check for certain file types
    autocmd FileType gitconfig,haskell,rust,vim-plug,yaml setlocal nospell
    autocmd Syntax brew setlocal nospell
    autocmd BufNewFile,BufRead .gitignore,.Brewfile,Brewfile setlocal nospell

    " Wrap long lines at word boundaries
    autocmd FileType markdown,tex setlocal linebreak

    " Misc
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd BufNewFile,BufRead .envrc set filetype=sh
    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Fix `crontab: temp file must be edited in place`
    autocmd FileType crontab setlocal nobackup nowritebackup
augroup END
