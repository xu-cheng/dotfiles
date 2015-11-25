" Disable spelling check for certain file types
autocmd FileType gitconfig,haskell,rust,vim-plug,yaml setlocal nospell
autocmd Syntax brew setlocal nospell
autocmd BufNewFile,BufRead .gitignore setlocal nospell

