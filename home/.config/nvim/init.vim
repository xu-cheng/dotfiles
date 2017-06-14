" Set config/cache/data home
let g:config_home = expand('<sfile>:p:h')
if has('win32')
    let g:cache_home = $USERPROFILE . '\AppData\Local\Temp\nvim\'
elseif !empty($XDG_CACHE_HOME)
    let g:cache_home = $XDG_CACHE_HOME . '/nvim/'
else
    let g:cache_home = $HOME . '/.cache/nvim/'
endif
if has('win32')
    let g:data_home = $USERPROFILE . '\AppData\Local\nvim-data\'
elseif !empty($XDG_DATA_HOME)
    let g:data_home = $XDG_DATA_HOME . '/nvim/'
else
    let g:data_home = $HOME . '/.local/share/nvim/'
endif

" Set python interpreter path
function! s:brew_prefix()
    if !exists('s:brew_prefix')
        let s:brew_prefix = systemlist('brew --prefix')[0]
    endif
    return s:brew_prefix
endfunction

if !exists('g:python_host_prog')
    if has('mac')
        let g:python_host_prog = '/usr/local/bin/python'
    elseif has('win32')
        let g:python_host_prog = 'C:\Python27\python'
    else
        if executable(s:brew_prefix() . '/bin/python')
            let g:python_host_prog = s:brew_prefix() . '/bin/python'
        else
            let g:python_host_prog = '/usr/bin/python'
        endif
    endif
endif

if !exists('g:python3_host_prog')
    if has('mac')
        let g:python3_host_prog = '/usr/local/bin/python3'
    elseif has('win32')
        let g:python3_host_prog = 'C:\Python36\python'
    else
        if executable(s:brew_prefix() . '/bin/python3')
            let g:python3_host_prog = s:brew_prefix() . '/bin/python3'
        else
            let g:python3_host_prog = '/usr/bin/python3'
        endif
    endif
endif

" Load plugins
execute 'source' fnameescape(g:config_home . '/plugins.vim')
" Load basic settings
execute 'source' fnameescape(g:config_home . '/basic.vim')
" Load key mapping
execute 'source' fnameescape(g:config_home . '/keymap.vim')
" Load plugins settings
for f in split(glob(g:config_home . '/pluginrc.d/*.vim'), '\n')
  execute 'source' fnameescape(f)
endfor
