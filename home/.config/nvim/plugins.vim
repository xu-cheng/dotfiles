" Load vim-plug

let s:plugin_update = stdpath('data') . '/plugin_update'

if empty(glob(stdpath('config') . '/autoload/plug.vim'))
  call writefile([], s:plugin_update)
  execute '!curl -fL --create-dirs'
        \ . ' -o ' . shellescape(stdpath('config') . '/autoload/plug.vim')
        \ . ' https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
elseif !empty(nvim_list_uis()) " make sure neovim is not started in headless
  let s:last_update = getftime(s:plugin_update)
  if s:last_update == -1 || (localtime() - s:last_update > 1209600)
    call writefile([], s:plugin_update)
    autocmd VimEnter * PlugUpgrade | PlugUpdate --sync | source $MYVIMRC
  endif
endif

call plug#begin(stdpath('data') . '/plugged')

" Deps
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'mileszs/ack.vim'
Plug 'roxma/nvim-yarp'
if executable('rg')
  let g:ackprg = 'rg --hidden --glob "!.git" --vimgrep'
end

" General
Plug 'editorconfig/editorconfig-vim'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
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
Plug 'mbbill/undotree'
Plug 'vim-scripts/restore_view.vim'
Plug 'tpope/vim-abolish'
Plug 'osyo-manga/vim-over'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'gcmt/wildfire.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'machakann/vim-highlightedyank'
Plug 'bogado/file-line'
Plug 'terryma/vim-expand-region'
Plug 'farmergreg/vim-lastplace'

" Writing
Plug 'reedes/vim-litecorrect'
Plug 'reedes/vim-wordy'
Plug 'beloglazov/vim-online-thesaurus'

" General Programming
Plug 'ludovicchabant/vim-gutentags'
Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'rhysd/conflict-marker.vim'
Plug 'godlygeek/tabular'
Plug 'majutsushi/tagbar'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'chrisbra/NrrwRgn'
Plug 'junegunn/vim-easy-align'
Plug 'Valloric/MatchTagAlways'
"Plug 'tpope/vim-endwise'

" Snippets & AutoComplete & Semantic Highlight
Plug 'ncm2/ncm2'
Plug 'autozimu/LanguageClient-neovim', {
      \ 'branch': 'next',
      \ 'do': 'bash install.sh',
      \ }
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-tmux'
Plug 'ncm2/ncm2-path'
Plug 'Shougo/neco-syntax'
Plug 'ncm2/ncm2-syntax'
Plug 'Shougo/neco-vim'
Plug 'ncm2/ncm2-vim'
Plug 'filipekiss/ncm2-look.vim'
Plug 'ncm2/ncm2-html-subscope'
Plug 'ncm2/ncm2-markdown-subscope'

" Build & Debug
Plug 'tpope/vim-dispatch'

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
Plug 'rust-lang/rust.vim'
Plug 'xu-cheng/brew.vim'
Plug 'bfontaine/Brewfile.vim'
Plug 'tmux-plugins/vim-tmux'
Plug 'cespare/vim-toml'
Plug 'tomlion/vim-solidity'

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'kannokanno/previm'

" Misc
Plug 'tyru/open-browser.vim'
Plug 'henrik/vim-reveal-in-finder'

" Other
Plug 'tmux-plugins/vim-tmux-focus-events'

" Require to be loaded as the very last one
Plug 'ryanoasis/vim-devicons'

call plug#end()
