export CSR=1

if [[ "$-" != *i* ]]; then
    [[ -f ~/.bashrc ]] && . ~/.bashrc
    return
fi

[[ -x "$HOME/usr/bin/zsh" ]] && exec "$HOME/usr/bin/zsh" --login --interactive

[[ -f /etc/bashrc ]] && . /etc/bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc
