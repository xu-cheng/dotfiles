" Load vim-plug
if empty(glob('~/.nvim/autoload/plug.vim'))
  silent !mkdir -p ~/.nvim/autoload
  silent !curl -fLo ~/.nvim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

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
Plug 'vim-scripts/sessionman.vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mbbill/undotree'
Plug 'vim-scripts/restore_view.vim'
Plug 'tpope/vim-abolish'
Plug 'osyo-manga/vim-over'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'gcmt/wildfire.vim'

" Writing
Plug 'reedes/vim-litecorrect'
Plug 'reedes/vim-wordy'

" General Programming
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'Raimondi/delimitMate'

" Snippets & AutoComplete
Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'

" Color Scheme
Plug 'junegunn/seoul256.vim'

" LaTeX
Plug 'lervag/vim-latex', { 'for': 'latex' }
Plug 'auctex.vim', { 'for': 'latex' }

" Dash
Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'

" Misc
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'henrik/vim-reveal-in-finder'

call plug#end()
