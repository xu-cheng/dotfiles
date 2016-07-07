[[ "$-" = *i* ]] || return

export CSR=1
[[ -x "$HOME/usr/bin/zsh" ]] && exec "$HOME/usr/bin/zsh" --login

[[ -f /etc/bashrc ]] && . /etc/bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc
