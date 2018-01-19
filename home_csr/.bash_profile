if [[ -f ~/.bashrc ]]; then
    . ~/.bashrc
fi

# set bash history
HISTFILE="$XDG_CACHE_HOME/bash/history"

if [[ $- =~ i && -x "$SHELL" ]]; then
    exec "$SHELL" --login --interactive
fi
