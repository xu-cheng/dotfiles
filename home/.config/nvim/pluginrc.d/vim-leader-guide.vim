let g:vim_leader_guide_map = {
            \ mapleader: { 'name': '<leader>' },
            \ maplocalleader: { 'name': '<localleader>' },
            \ }
call leaderGuide#register_prefix_descriptions('', 'g:vim_leader_guide_map')

nnoremap <silent> <leader> :<c-u>LeaderGuide mapleader<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual mapleader<CR>
map <leader>. <Plug>leaderguide-global
nnoremap <localleader> :<c-u>LeaderGuide  maplocalleader<CR>
vnoremap <localleader> :<c-u>LeaderGuideVisual maplocalleader<CR>
map <localleader>. <Plug>leaderguide-buffer
