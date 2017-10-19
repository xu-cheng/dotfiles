if exists('&signcolumn')  " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

let g:gitgutter_sign_added = '∙'
let g:gitgutter_sign_modified = '∙'
let g:gitgutter_sign_removed = '∙'
let g:gitgutter_sign_modified_removed = '∙'
