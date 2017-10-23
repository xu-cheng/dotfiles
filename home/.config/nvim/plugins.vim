" Load vim-plug
if empty(glob(g:config_home . '/autoload/plug.vim'))
    execute '!curl -fL --create-dirs'
                \ . ' -o ' . shellescape(g:config_home . '/autoload/plug.vim')
                \ . ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    augroup vim_plug
        autocmd!
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    augroup END
endif

call plug#begin(g:config_home . '/plugged')

" Deps
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'mileszs/ack.vim'
if executable('rg')
    let g:ackprg = 'rg --hidden --glob "!.git" --vimgrep'
end

" General
Plug 'editorconfig/editorconfig-vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-bufferline'
Plug 'easymotion/vim-easymotion'
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
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'hecal3/vim-leader-guide'
Plug 'bogado/file-line'
Plug 'terryma/vim-expand-region'
Plug 'farmergreg/vim-lastplace'

" Writing
Plug 'reedes/vim-litecorrect'
Plug 'reedes/vim-wordy'
Plug 'rhysd/vim-grammarous'
Plug 'beloglazov/vim-online-thesaurus'

" General Programming
Plug 'w0rp/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/conflict-marker.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'Raimondi/delimitMate'
Plug 'Chiel92/vim-autoformat'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'chrisbra/NrrwRgn'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'Valloric/MatchTagAlways'
Plug 'tpope/vim-endwise'
Plug 'metakirby5/codi.vim'

" Snippets & AutoComplete & Semantic Highlight
function! BuildYCM(info)
    if a:info.status ==# 'installed' || a:info.force
        !python3 ./install.py --clang-completer
    endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'lyuts/vim-rtags'
"Plug 'jeaye/color_coded' # not support neovim yet

" Build & Debug
Plug 'tpope/vim-dispatch'
if executable('lldb')
    Plug 'critiqjo/lldb.nvim'
endif

" Color Scheme
Plug 'junegunn/seoul256.vim'
Plug 'altercation/vim-colors-solarized'

" LaTeX
Plug 'lervag/vimtex'

" Dash
Plug 'rizzatti/funcoo.vim'
Plug 'rizzatti/dash.vim'

" Org mode
Plug 'vim-scripts/utl.vim'
Plug 'vim-scripts/SyntaxRange'
Plug 'tpope/vim-speeddating'
Plug 'mattn/calendar-vim'
Plug 'jceb/vim-orgmode'

" Syntax
Plug 'sheerun/vim-polyglot'
Plug 'xu-cheng/brew.vim'
Plug 'bfontaine/Brewfile.vim'
Plug 'tmux-plugins/vim-tmux'

" Misc
Plug 'plasticboy/vim-markdown'
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
Plug 'henrik/vim-reveal-in-finder'

" Other
Plug 'edkolev/tmuxline.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'

call plug#end()
