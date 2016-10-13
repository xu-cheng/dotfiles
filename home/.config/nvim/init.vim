" Set python interpreter path before every other thing
if has('mac')
    let g:python2_host_prog = '/usr/local/bin/python'
    let g:python3_host_prog = '/usr/local/bin/python3'
else
    let s:brew_prefix = systemlist('brew --prefix')[0]
    if executable(s:brew_prefix . '/bin/python')
        let g:python2_host_prog = s:brew_prefix . '/bin/python'
    else
        let g:python2_host_prog = '/usr/bin/python'
    end
    if executable(s:brew_prefix . '/bin/python3')
        let g:python3_host_prog = s:brew_prefix . '/bin/python3'
    else
        let g:python3_host_prog = '/usr/bin/python3'
    end
endif
" Set config/cache/data home
if empty($XDG_CONFIG_HOME)
    let g:config_home = $HOME . '/.config/nvim/'
else
    let g:config_home = $XDG_CONFIG_HOME . '/nvim/'
endif
if empty($XDG_CACHE_HOME)
    let g:cache_home = $HOME . '/.cache/nvim/'
else
    let g:cache_home = $XDG_CACHE_HOME . '/nvim/'
endif
if empty($XDG_DATA_HOME)
    let g:data_home = $HOME . '/.local/share/nvim/'
else
    let g:data_home = $XDG_DATA_HOME. '/nvim/'
endif
" Load plugins
execute 'source' g:config_home . 'plugins.vim'
" Load basic settings
execute 'source' g:config_home . 'basic.vim'
" Load key mapping
execute 'source' g:config_home . 'keymap.vim'
" Load plugins settings
for f in split(glob(g:config_home . 'pluginrc.d/*.vim'), '\n')
  execute 'source' f
endfor
