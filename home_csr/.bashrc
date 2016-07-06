umask 0077

[[ -d "/tmp/chengxu" ]] || mkdir -p /tmp/chengxu

unset LD_LIBRARY_PATH
DOTFILES_ZSHRC="$(readlink "$HOME/.zshrc")"
export DOTFILES_HOME="${DOTFILES_ZSHRC%/*}"
unset DOTFILES_ZSHRC
export PATH="$DOTFILES_HOME/bin:$HOME/usr/bin:$HOME/usr/sbin:$HOME/portable/git/2.8.2/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"
export MANPATH="$HOME/usr/share/man:$MANPATH"
export INFOPATH="$HOME/usr/share/info:$INFOPATH"
export CMAKE_PREFIX_PATH="$HOME/usr"
export HOMEBREW_CACHE="/tmp/chengxu/Caches/Homebrew"
export HOMEBREW_LOGS="/tmp/chengxu/Logs/Homebrew"
export HTTPS_PROXY="https://proxy.comp.hkbu.edu.hk:8080"
export SHELL="$HOME/usr/bin/zsh"
export HOMEBREW_RUBY_PATH="$HOME/portable/ruby/2.0.0-p648/bin/ruby"
export HOMEBREW_DEVELOPER=1
export HOMEBREW_NO_ANALYTICS=1

[[ "$-" != *i* ]] && return

alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

. "$DOTFILES_HOME/.oh-my-zsh/custom/ssh-gpg-agent.plugin.zsh"
