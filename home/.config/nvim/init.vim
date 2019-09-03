let s:config_home = stdpath('config')

" Set python/ruby interpreter path

if has('mac')
  let s:brew_prefix = '/usr/local'
elseif executable('brew')
  let s:brew_prefix = systemlist('brew --prefix')[0]
endif

if !exists('g:python3_host_prog')
  if exists('s:brew_prefix') && executable(s:brew_prefix . '/opt/python/bin/python3')
    let g:python3_host_prog = s:brew_prefix . '/opt/python/bin/python3'
  elseif executable('/usr/bin/python3')
    let g:python3_host_prog = '/usr/bin/python3'
  endif
endif

if !exists('g:ruby_host_prog')
  if has('mac')
    let s:brew_ruby_host = glob(s:brew_prefix . '/lib/ruby/gems/*/bin/neovim-ruby-host', 1, 1)
    if !empty(s:brew_ruby_host) && executable(s:brew_ruby_host[0])
      let g:ruby_host_prog = s:brew_ruby_host[0]
    endif
  elseif exists('s:brew_prefix') && executable(s:brew_prefix . '/bin/neovim-ruby-host')
    let g:ruby_host_prog = s:brew_prefix . '/bin/neovim-ruby-host'
  elseif executable('/usr/bin/neovim-ruby-host')
    let g:ruby_host_prog = '/usr/bin/neovim-ruby-host'
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
