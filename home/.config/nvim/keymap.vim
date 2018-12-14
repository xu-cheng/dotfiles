let g:mapleader = ','
let g:maplocalleader = '-'

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" Delete without overwriting last yank.
nnoremap <leader>d "_d
nnoremap <leader>D "_D
nnoremap <leader>x "_x
vnoremap <leader>d "_d
vnoremap <leader>D "_D
vnoremap <leader>x "_x

" Switch to paste mode, paste text, unset paste mode
noremap <leader>P :set paste<CR>gp<CR>:set nopaste<CR>

" Selects text you just pasted
nnoremap <leader>v V`]

" Tab management
nnoremap tt :tabnew<Space>
nnoremap tw :tabclose<CR>
nnoremap tm :tabmove<Space>
nnoremap tn :tabnext<Space>
nnoremap th :tabfirst<CR>
nnoremap tj :tabnext<CR>
nnoremap tk :tabprev<CR>
nnoremap tl :tablast<CR>

" Disable Ex-mode
nnoremap Q <nop>

" Clear normal/visual mode highlighting
noremap <Space> :<c-u>noh<CR>:echo<CR>

" Windows management
nnoremap <C-w>\| :vsplit<CR>
nnoremap <C-w>- :split<CR>

" Navigating in command mode
" http://stackoverflow.com/a/6923282
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" Ctrl-S to quick save
noremap <C-s> :update<CR>
inoremap <C-s> <C-o>:update<CR>
vnoremap <C-s> <C-c>:update<CR>gv

" Ctrl-C as Esc
noremap <C-c> <Esc>
inoremap <C-c> <Esc>

" Shortcut to custom commands
noremap <leader>rc :call RemoveCache()<CR>
