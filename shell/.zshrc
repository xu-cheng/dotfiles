ZSH=$HOME/.oh-my-zsh

ZSH_THEME="mytheme"
plugins=(git git-flow git-hubflow ssh-agent mercurial svn pip dirhistory colored-man brew brew-cask osx)

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:/usr/texbin"
export EDITOR="nvim"
export PYENV_ROOT="/usr/local/var/pyenv"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV=true
export CHEATCOLORS=true

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
if which hub > /dev/null; then eval "$(hub alias -s)"; fi
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_PATH="$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -s $ZSH_HIGHLIGHT_PATH ]] && . $ZSH_HIGHLIGHT_PATH
[[ -f $HOME/.travis/travis.sh ]] && source $HOME/.travis/travis.sh

source $ZSH/oh-my-zsh.sh
#compinit

alias rake='noglob rake'
alias vim='nvim'
alias subl='subl && sleep 0.1 && subl'

clean_hist(){
    rm -f "$HOME/.zsh_history"
}

# Load confidential information
[[ -s $HOME/.config/tokens ]] && . $HOME/.config/tokens
