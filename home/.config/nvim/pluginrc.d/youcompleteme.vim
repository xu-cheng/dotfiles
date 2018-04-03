let g:acp_enableAtStartup = 0

" Global .ycm_extra_conf.py file
let g:ycm_global_ycm_extra_conf = g:config_home . '/pluginrc.d/ycm_global_extra_conf.py'

" Run YCM server in python 3
let g:ycm_server_python_interpreter = g:python3_host_prog

" Don't ask about .ycm_extra_conf.py file
let g:ycm_confirm_extra_conf = 0

" enable completion from tags
let g:ycm_collect_identifiers_from_tags_files = 1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsListSnippet = '<C-n>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:SuperTabCrMapping = 0

" rust
if exists('$HOMEBREW_PREFIX') && isdirectory($HOMEBREW_PREFIX . '/share/rust/rust_src')
    let g:ycm_rust_src_path = $HOMEBREW_PREFIX . '/share/rust/rust_src'
endif

" Enable omni completion.
augroup youcompleteme_group
    autocmd!
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
    autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
augroup END

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=
endif

" Disable the neosnippet preview candidate window
" When enabled, there can be too much visual noise
" especially when splits are used.
set completeopt-=preview
