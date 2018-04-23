" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldmethod=marker spell:
" General {

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    " Set clipboard
    if has('clipboard')
        if has('unnamedplus')  " When possible use + register for copy-paste
            set clipboard=unnamed,unnamedplus
        else             " On mac and Windows, use * register for copy-paste
            set clipboard=unnamed
        endif
    endif

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set spell                           " Spell checking on
    set spelllang=en_us                 " Spell checking language
    set hidden                          " Allow buffer switching without saving
    set switchbuf=usetab,newtab         " Switching to the existing tab or creating new one
    set iskeyword-=.                    " '.' is an end of word designator
    set iskeyword-=#                    " '#' is an end of word designator
    set iskeyword-=-                    " '-' is an end of word designator

    " Setting up the directories {

        set backup                  " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=1000         " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

        " Add exclusions to mkview and loadview
        " eg: *.*, svn-commit.tmp
        let g:skipview_files = [
            \ '\[example pattern\]'
            \ ]

    " }

" }

" Vim UI {

    " Color Scheme
    if systemlist('get-iterm2-background-color')[0] ==# 'light'
        set background=light
    else
        set background=dark
    endif
    if &background ==# 'dark'
        color seoul256
    else
        color solarized
    endif

    set termguicolors               " enable true color

    set tabpagemax=15               " Only show 15 tabs
    set noshowmode                  " Hide the current mode, it is already shown by the airline.

    set cursorline                  " Highlight current line
    set signcolumn=yes              " Always show signcolumn

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

" }

" Formatting {

    set encoding=utf-8              " Default file encoding
    set fileformats=unix,dos        " Default file line ending
    set endofline                   " Ensure newline at end of the file
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
" }

" Directories {

    " Initialize directories
    function! s:InitializeDirectories()
        if !isdirectory(g:cache_home) && exists('*mkdir')
            call mkdir(g:cache_home, 'p')
        endif

        let l:dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let l:dir_list['undo'] = 'undodir'
        endif
        for [l:dirname, l:settingname] in items(l:dir_list)
            let l:directory = g:cache_home . '/' . l:dirname . '/'
            if !isdirectory(l:directory) && exists('*mkdir')
                call mkdir(l:directory)
            endif
            if !isdirectory(l:directory)
                echo 'Warning: Unable to create backup directory: ' . l:directory
                echo 'Try: mkdir -p ' . l:directory
            else
                let l:directory = substitute(l:directory, ' ', '\\\\ ', 'g')
                exec 'set ' . l:settingname . '=' . l:directory
            endif
        endfor
    endfunction

    call s:InitializeDirectories()

" }

" Remove Cache {
    function! RemoveCache()
        if has('win32')
            call system('rd /s /q ' . shellescape(g:cache_home))
        else
            call system('rm -rf ' . shellescape(g:cache_home))
        endif
        call delete($NVIM_LISTEN_ADDRESS)
    endfunction

    command! RemoveCache call RemoveCache()
" }

" ToggleBG {
    function! ToggleBG()
        if &background ==# 'dark'
            set background=light
            color solarized
            let g:airline_theme = 'solarized'
        else
            set background=dark
            color seoul256
            let g:airline_theme = 'bubblegum'
        endif
        AirlineRefresh
    endfunction

    command! ToggleBG call ToggleBG()
" }

" Auto quit {
" Ref: http://vim.wikia.com/wiki/Automatically_quit_Vim_if_quickfix_window_is_the_last
    augroup auto_quit_if_quickfix_is_the_last
        autocmd!
        autocmd BufEnter * if &buftype ==# 'quickfix' && winbufnr(2) == -1 | quit! | endif
    augroup END
" }
