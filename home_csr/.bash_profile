if [[ -f ~/.bashrc ]]; then
    . ~/.bashrc
fi

if [[ $- =~ i && -x "$SHELL" ]]; then
    exec "$SHELL" --login --interactive
fi
