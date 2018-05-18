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
export PATH="$XDG_BIN_HOME:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
export MANPATH="$HOME/usr/share/man:$MANPATH"
export INFOPATH="$HOME/usr/share/info:$INFOPATH"
export CMAKE_PREFIX_PATH="$HOMEBREW_PREFIX"
export SHELL="$HOMEBREW_PREFIX/bin/zsh"
export HOMEBREW_FORCE_VENDOR_RUBY=true
export HOMEBREW_DEVELOPER=true
export HOMEBREW_NO_ANALYTICS=true
export HOMEBREW_NO_AUTO_UPDATE=true
export HOMEBREW_CACHE="$XDG_CACHE_HOME/homebrew"
export HOMEBREW_LOGS="$XDG_CACHE_HOME/homebrew/logs"
export MAKEFLAGS="-j$(nproc)"

HISTFILE="$XDG_CACHE_HOME/bash_history"

[[ -d "$XDG_CACHE_HOME" ]] || mkdir -p "$XDG_CACHE_HOME"
