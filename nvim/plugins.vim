" Install vim-plug first
" https://github.com/junegunn/vim-plug

call plug#begin('~/.nvim/plugged')

" General
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'kristijanhusak/vim-multiple-cursors'
Plug 'bling/vim-airline'
Plug 'bling/vim-bufferline'
Plug 'Lokaltog/vim-easymotion'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'myusuf3/numbers.vim'

" General Programming
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'Raimondi/delimitMate'

" Color Scheme
Plug 'junegunn/seoul256.vim'

" LaTeX
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'auctex.vim'

" Dash
Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'

" Misc
Plug 'tpope/vim-markdown'
Plug 'henrik/vim-reveal-in-finder'

call plug#end()
