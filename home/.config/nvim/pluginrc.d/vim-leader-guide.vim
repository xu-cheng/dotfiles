let g:vim_leader_guide_map = {
            \   g:mapleader: {
            \       'name': '<leader>',
            \       'c': { 'name' : 'Comments' },
            \       'f': { 'name' : 'Fold level/Find' },
            \       'g': { 'name' : 'Git' },
            \   },
            \   g:maplocalleader: {
            \       'name': '<localleader>',
            \   },
            \ }

augroup vim_leader_guide_group
    autocmd!
    autocmd FileType tex let g:vim_leader_guide_map[g:maplocalleader].l = { 'name': 'Vimtex' }
augroup END

call leaderGuide#register_prefix_descriptions('', 'g:vim_leader_guide_map')

nnoremap <silent> <leader> :<C-u>LeaderGuide mapleader<CR>
vnoremap <silent> <leader> :<C-u>LeaderGuideVisual mapleader<CR>
map <leader>. <Plug>leaderguide-global
nnoremap <localleader> :<C-u>LeaderGuide maplocalleader<CR>
vnoremap <localleader> :<C-u>LeaderGuideVisual maplocalleader<CR>
map <localleader>. <Plug>leaderguide-buffer
