let s:config_home = stdpath('config')

" Set python interpreter path
function! s:brew_prefix()
    if !exists('s:brew_prefix')
        let s:brew_prefix = systemlist('brew --prefix')[0]
    endif
    return s:brew_prefix
endfunction

if !exists('g:python_host_prog')
    if has('mac')
        let g:python_host_prog = '/usr/local/bin/python2'
    elseif has('win32')
        let g:python_host_prog = 'C:\Python27\python'
    else
        if executable(s:brew_prefix() . '/bin/python2')
            let g:python_host_prog = s:brew_prefix() . '/bin/python2'
        else
            let g:python_host_prog = '/usr/bin/python2'
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
execute 'source' fnameescape(s:config_home . '/plugins.vim')
" Load basic settings
execute 'source' fnameescape(s:config_home . '/basic.vim')
" Load key mapping
execute 'source' fnameescape(s:config_home . '/keymap.vim')
" Load plugins settings
for s:f in split(glob(s:config_home . '/pluginrc.d/*.vim'), '\n')
  execute 'source' fnameescape(s:f)
endfor
