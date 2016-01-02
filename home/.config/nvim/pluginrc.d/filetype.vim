" Auto detect filetype if uneset
autocmd BufWritePost * if &filetype == "" | filetype detect | endif
" Automatically give executable permission to new scripts starting with a shebang (#!)
autocmd BufWritePre  * if !filereadable(expand('<afile>:p')) | let b:is_new = 1 | endif
autocmd BufWritePost * if getline(1) =~ "^#!.*" && get(b:, 'is_new', 0) | :call system('chmod a+x "' . expand('<afile>:p') . '"') | endif

" 2 space for tab for certain filetypes
autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2

" Disable spelling check for certain file types
autocmd FileType gitconfig,haskell,rust,vim-plug,yaml setlocal nospell
autocmd Syntax brew setlocal nospell
autocmd BufNewFile,BufRead .gitignore,.Brewfile,Brewfile setlocal nospell

" Misc
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
" Workaround vim-commentary for Haskell
autocmd FileType haskell setlocal commentstring=--\ %s

