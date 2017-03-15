if [[ -f /etc/bashrc ]]; then
    . /etc/bashrc
fi

umask 0077

[[ -d "/tmp/$USER" ]] || mkdir -p "/tmp/$USER"

unset FPATH
unset LD_LIBRARY_PATH
export CSR=true
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="/tmp/$USER/cache"
export XDG_DATA_HOME="$HOME/.local/share"
export DOTFILES_HOME="$(dirname "$(readlink "$HOME/.zshenv")")"
export HOMEBREW_PREFIX="$HOME/usr"
export PATH="$DOTFILES_HOME/bin:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
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
