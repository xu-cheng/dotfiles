ZSH=$HOME/.oh-my-zsh

ZSH_THEME="mytheme"
plugins=(git git-flow git-hubflow ssh-agent mercurial svn pip colored-man brew brew-cask osx)

export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:/usr/texbin"
export EDITOR="nvim"
export PYENV_ROOT="/usr/local/var/pyenv"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV=true
export RBENV_ROOT="/usr/local/var/rbenv"
export CHEATCOLORS=true

if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which hub > /dev/null; then eval "$(hub alias -s)"; fi
if which direnv > /dev/null; then eval "$(direnv hook zsh)"; fi
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_PATH=$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -s $ZSH_HIGHLIGHT_PATH ]] && . $ZSH_HIGHLIGHT_PATH
[[ -s $HOME/.travis/travis.sh ]] && . $HOME/.travis/travis.sh

source $ZSH/oh-my-zsh.sh
#compinit

alias rake='noglob rake'
alias rm='safe-rm'
alias ccat='pygmentize -g'
alias sysbrew='/usr/local/bin/brew'
if ! which sha1sum > /dev/null; then alias sha1sum='gsha1sum'; fi
if ! which sha256sum > /dev/null; then alias sha256sum='gsha256sum'; fi
if ! which md5sum > /dev/null; then alias md5sum='gmd5sum'; fi
alias vim='nvim'
alias vimdiff='nvim -d'
alias subl='subl && sleep 0.1 && subl'

hist(){
if [[ "$1" == "-c" ]]; then
    rm -f "$HOME/.zsh_history"
else
    history
fi
}

# Load confidential information
[[ -s $HOME/.config/tokens ]] && . $HOME/.config/tokens
