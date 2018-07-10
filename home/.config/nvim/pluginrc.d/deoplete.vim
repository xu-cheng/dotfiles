" Ref:
" https://github.com/rafi/vim-config/blob/master/config/plugins/deoplete.vim
" https://www.reddit.com/r/neovim/comments/4st4i6/making_ultisnips_and_deoplete_work_together_nicely/d6m73rh/
" https://github.com/Shougo/deoplete.nvim/blob/master/doc/deoplete.txt
" https://github.com/autozimu/LanguageClient-neovim/blob/next/doc/LanguageClient.txt

let g:deoplete#enable_at_startup = 1
let g:deoplete#num_processes = 1
let g:deoplete#file#enable_buffer_path = 1
let g:neosnippet#enable_auto_clear_markers = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory = stdpath('data') . '/plugged/vim-snippets/snippets'
let g:echodoc#enable_at_startup = 1

augroup deoplete_group
    autocmd!
    " Close the preview window after completion is done.
    autocmd CompleteDone * silent! pclose!
augroup END

" don't give |ins-completion-menu| messages.  For example,
" '-- XXX completion (YYY)', 'match 1 of 2', 'The only match',
set shortmess+=c
" auto select feature
set completeopt+=noinsert
" disable the preview candidate window
set completeopt-=preview

" enable omni completion.
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.css = 'csscomplete#CompleteCSS'
let g:deoplete#omni#functions.html = 'htmlcomplete#CompleteTags'
let g:deoplete#omni#functions.markdown = 'htmlcomplete#CompleteTags'
let g:deoplete#omni#functions.javascript = 'javascriptcomplete#CompleteJS'
let g:deoplete#omni#functions.python = 'pythoncomplete#Complete'
let g:deoplete#omni#functions.xml = 'xmlcomplete#CompleteTags'
let g:deoplete#omni#functions.ruby = 'rubycomplete#Complete'
let g:deoplete#omni#functions.haskell = 'necoghc#omnifunc'

" Matchers and Converters
call deoplete#custom#source('_', 'converters', [
            \ 'converter_remove_paren',
            \ 'converter_remove_overlap',
            \ 'converter_truncate_abbr',
            \ 'converter_truncate_menu',
            \ 'converter_auto_delimiter',
            \ ])

" LSP
if exists('$TMPDIR')
    let s:tmp_dir = $TMPDIR
elseif exists('$XDG_CACHE_HOME')
    let s:tmp_dir = $XDG_CACHE_HOME
else
    let s:tmp_dir = '/tmp'
endif
"let g:LanguageClient_loggingFile = s:tmp_dir . '/LanguageClient.log'
"let g:LanguageClient_serverStderr = s:tmp_dir . '/LanguageServer.log'
let s:cquery_opts = {
            \ 'cacheDirectory': s:tmp_dir . '/cquery',
            \ 'extraClangArguments': [
            \     '-Wall',
            \     '-Wextra',
            \     '-Werror',
            \     '-Wno-long-long',
            \     '-Wno-variadic-macros',
            \     '-fexceptions',
            \     '-DNDEBUG',
            \   ],
            \ }
" install LSP:
" * c/cpp: `brew install cquery`
" * python: `pip3 install python-language-server`
" * rust: See notes/rust.md
" * sh: `npm install -g bash-language-server`
let g:LanguageClient_serverCommands = {
            \ 'c': ['cquery', '--log-all-to-stderr', '--init=' . json_encode(s:cquery_opts)],
            \ 'cpp': ['cquery', '--log-all-to-stderr', '--init=' . json_encode(s:cquery_opts)],
            \ 'python': ['pyls'],
            \ 'rust': ['rls'],
            \ 'sh': ['bash-language-server', 'start'],
            \ }
let g:LanguageClient_diagnosticsDisplay = {
            \    1: {
            \        'name': 'Error',
            \        'texthl': 'ALEError',
            \        'signText': '✗',
            \        'signTexthl': 'ALEErrorSign',
            \    },
            \    2: {
            \        'name': 'Warning',
            \        'texthl': 'ALEWarning',
            \        'signText': '⚠',
            \        'signTexthl': 'ALEWarningSign',
            \    },
            \    3: {
            \        'name': 'Information',
            \        'texthl': 'ALEInfo',
            \        'signText': 'ℹ',
            \        'signTexthl': 'ALEInfoSign',
            \    },
            \    4: {
            \        'name': 'Hint',
            \        'texthl': 'ALEInfo',
            \        'signText': '➤',
            \        'signTexthl': 'ALEInfoSign',
            \    },
            \ }

" compatible with vim-multiple-cursors
function g:Multiple_cursors_before()
    let g:deoplete#disable_auto_complete = 1
endfunction
function g:Multiple_cursors_after()
    let g:deoplete#disable_auto_complete = 0
endfunction

" Ranking and Marks
call deoplete#custom#source('LanguageClient', 'mark', '⌁')
call deoplete#custom#source('vim', 'mark', '⌁')
call deoplete#custom#source('omni', 'mark', '⌾')
call deoplete#custom#source('neosnippet', 'mark', '⌘')
call deoplete#custom#source('tag', 'mark', '⌦')
call deoplete#custom#source('file/include', 'mark', '')
call deoplete#custom#source('file', 'mark', '')
call deoplete#custom#source('member', 'mark', '.')
call deoplete#custom#source('around', 'mark', '↻')
call deoplete#custom#source('buffer', 'mark', 'ℬ')
call deoplete#custom#source('tmux-complete', 'mark', '⊶')
call deoplete#custom#source('syntax', 'mark', '♯')
call deoplete#custom#source('look', 'mark', '')

call deoplete#custom#source('LanguageClient', 'rank', 1000)
call deoplete#custom#source('vim', 'rank', 1000)
call deoplete#custom#source('omni', 'rank', 900)
call deoplete#custom#source('neosnippet', 'rank', 800)
call deoplete#custom#source('tag', 'rank', 700)
call deoplete#custom#source('file/include', 'rank', 650)
call deoplete#custom#source('file', 'rank', 600)
call deoplete#custom#source('member', 'rank', 500)
call deoplete#custom#source('around', 'rank', 450)
call deoplete#custom#source('buffer', 'rank', 400)
call deoplete#custom#source('tmux-complete', 'rank', 300)
call deoplete#custom#source('syntax', 'rank', 200)
call deoplete#custom#source('look', 'rank', 200)

" Keymap

function! s:is_whitespace()
    let l:col = col('.') - 1
    return ! l:col || getline('.')[l:col - 1] =~? '\s'
endfunction

" <Tab> completion:
" 1. If popup menu is visible, select and insert next item
" 2. Otherwise, if within a snippet, jump to next input
" 3. Otherwise, if preceding chars are whitespace, insert tab char
" 4. Otherwise, start manual autocomplete
imap <silent><expr><Tab> pumvisible() ? "\<C-n>" :
            \ (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)"
            \ : (<SID>is_whitespace() ? "\<Tab>"
            \ : deoplete#manual_complete()))
smap <silent><expr><Tab> pumvisible() ? "\<C-n>" :
            \ (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)"
            \ : (<SID>is_whitespace() ? "\<Tab>"
            \ : deoplete#manual_complete()))

inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <C-j> <Plug>(neosnippet_expand_or_jump)
smap <C-j> <Plug>(neosnippet_expand_or_jump)
xmap <C-j> <Plug>(neosnippet_expand_target)

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=
endif
