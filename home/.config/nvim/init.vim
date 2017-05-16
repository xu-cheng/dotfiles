" Set python interpreter path before every other thing
if has('mac')
    let g:python2_host_prog = '/usr/local/bin/python'
    let g:python3_host_prog = '/usr/local/bin/python3'
elseif has('win32')
    let g:python2_host_prog = 'C:\Python27\python'
    let g:python3_host_prog = 'C:\Python36\python'
else
    let s:brew_prefix = systemlist('brew --prefix')[0]
    if executable(s:brew_prefix . '/bin/python')
        let g:python2_host_prog = s:brew_prefix . '/bin/python'
    elseif executable('/usr/bin/python')
        let g:python2_host_prog = '/usr/bin/python'
    end
    if executable(s:brew_prefix . '/bin/python3')
        let g:python3_host_prog = s:brew_prefix . '/bin/python3'
    elseif executable('/usr/bin/python3')
        let g:python3_host_prog = '/usr/bin/python3'
    end
endif
let g:python_host_prog = g:python2_host_prog

" Set config/cache/data home
if has('win32')
    let g:config_home = $USERPROFILE . '\AppData\Local\nvim\'
elseif !empty($XDG_CONFIG_HOME)
    let g:config_home = $XDG_CONFIG_HOME . '/nvim/'
else
    let g:config_home = $HOME . '/.config/nvim/'
endif
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
" Load plugins
execute 'source' fnameescape(g:config_home . 'plugins.vim')
" Load basic settings
execute 'source' fnameescape(g:config_home . 'basic.vim')
" Load key mapping
execute 'source' fnameescape(g:config_home . 'keymap.vim')
" Load plugins settings
for f in split(glob(g:config_home . 'pluginrc.d/*.vim'), '\n')
  execute 'source' fnameescape(f)
endfor
