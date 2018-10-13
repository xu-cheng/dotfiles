let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'
let g:gitgutter_max_signs = 999

augroup gitgutter_refresh_after_save
    autocmd!
    autocmd BufWritePost,FileChangedShellPost * call gitgutter#process_buffer(bufnr(''), 0)
augroup END
