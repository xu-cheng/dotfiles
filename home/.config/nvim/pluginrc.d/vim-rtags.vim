let g:rtagsUseDefaultMappings = 0

noremap <localleader>ri :call rtags#SymbolInfo()<CR>
noremap <localleader>rj :call rtags#JumpTo(g:SAME_WINDOW)<CR>
noremap <localleader>rJ :call rtags#JumpTo(g:SAME_WINDOW, { '--declaration-only' : '' })<CR>
noremap <localleader>rS :call rtags#JumpTo(g:H_SPLIT)<CR>
noremap <localleader>rV :call rtags#JumpTo(g:V_SPLIT)<CR>
noremap <localleader>rT :call rtags#JumpTo(g:NEW_TAB)<CR>
noremap <localleader>rp :call rtags#JumpToParent()<CR>
noremap <localleader>rf :call rtags#FindRefs()<CR>
noremap <localleader>rn :call rtags#FindRefsByName(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <localleader>rs :call rtags#FindSymbols(input("Pattern? ", "", "customlist,rtags#CompleteSymbols"))<CR>
noremap <localleader>rr :call rtags#ReindexFile()<CR>
noremap <localleader>rl :call rtags#ProjectList()<CR>
noremap <localleader>rw :call rtags#RenameSymbolUnderCursor()<CR>
noremap <localleader>rv :call rtags#FindVirtuals()<CR>
noremap <localleader>rb :call rtags#JumpBack()<CR>
noremap <localleader>rC :call rtags#FindSuperClasses()<CR>
noremap <localleader>rc :call rtags#FindSubClasses()<CR>
noremap <localleader>rd :call rtags#Diagnostics()<CR>
