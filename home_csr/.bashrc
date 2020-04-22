if [[ -z "$LANG" || -z "$LANGUAGE" || -z "$LC_CTYPE" ]]; then
    export LANG="en_US.UTF-8"
    export LANGUAGE="en_US.UTF-8"
    export LC_CTYPE="en_US.UTF-8"
fi

if [[ -f /etc/bashrc ]]; then
    . /etc/bashrc
fi

umask 0077

unset FPATH
unset LD_LIBRARY_PATH
unset LESSOPEN
export CSR=true
export TMPDIR="/tmp/$USER"
export TMP="$TMPDIR"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$TMPDIR/cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_BIN_HOME="$HOME/.local/bin"
export HOMEBREW_PREFIX="$HOME/usr"
RUBY_API_VERSION="$($HOMEBREW_PREFIX/opt/ruby/bin/ruby -e 'print Gem.ruby_api_version')"
export PATH="$XDG_BIN_HOME:$HOMEBREW_PREFIX/lib/ruby/gems/$RUBY_API_VERSION/bin:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
export MANPATH="$HOME/usr/share/man:$MANPATH"
export INFOPATH="$HOME/usr/share/info:$INFOPATH"
export CMAKE_PREFIX_PATH="$HOMEBREW_PREFIX"
export SHELL="$HOMEBREW_PREFIX/bin/zsh"
# get the effective arch for `gcc -march=native`:
#   gcc -march=native -Q --help=target | grep march | awk '{ print $2 }'
export HOMEBREW_ARCH="nehalem"
export HOMEBREW_FORCE_VENDOR_RUBY=true
export HOMEBREW_FORCE_BREWED_GIT=true
export HOMEBREW_DEVELOPER=true
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_CACHE="$XDG_CACHE_HOME/homebrew"
export HOMEBREW_LOGS="$XDG_CACHE_HOME/homebrew/logs"
export MAKEFLAGS="-j$(nproc)"

[[ -n "$ftp_proxy" ]] || export ftp_proxy=http://proxy.comp.hkbu.edu.hk:8080
[[ -n "$http_proxy" ]] || export http_proxy=http://proxy.comp.hkbu.edu.hk:8080
[[ -n "$https_proxy" ]] || export https_proxy=http://proxy.comp.hkbu.edu.hk:8080
[[ -n "$no_proxy" ]] || export no_proxy=localhost,127.0.0.1

HISTFILE="$XDG_CACHE_HOME/bash_history"

[[ -d "$XDG_CACHE_HOME" ]] || mkdir -p "$XDG_CACHE_HOME"
