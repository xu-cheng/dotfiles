ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="mytheme"
plugins=(brew-cask colored-man-pages extract git git-flow-avh gitignore gpg-agent mercurial osx pip ssh-agent svn)

export DOTFILES_HOME="${$(readlink $HOME/.zshrc)%/*}"

if [[ `uname` == "Darwin" ]]; then # OS X
    export HOMEBREW_PREFIX="/usr/local"
    export PATH="$DOTFILES_HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/MacGPG2/bin:/Library/TeX/texbin"
else # Linux
    if (( ${+commands[brew]} )); then
        export HOMEBREW_PREFIX="$(brew --prefix)"
    else
        export HOMEBREW_PREFIX="$HOME/.linuxbrew"
    fi
    export PATH="$DOTFILES_HOME/bin:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
    export MANPATH="$HOMEBREW_PREFIX/share/man:$MANPATH"
    export INFOPATH="$HOMEBREW_PREFIX/share/info:$INFOPATH"
    export CMAKE_PREFIX_PATH=$HOMEBREW_PREFIX
fi

export EDITOR="nvim"
export NVIM_LISTEN_ADDRESS="$HOME/.local/share/nvim/nvim.sock"
export PYENV_ROOT="$HOMEBREW_PREFIX/var/pyenv"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=true
export RBENV_ROOT="$HOMEBREW_PREFIX/var/rbenv"
export CHEATCOLORS=true
export HOMEBREW_SANDBOX=true
export HOMEBREW_DEVELOPER=true
export NVIM_TUI_ENABLE_TRUE_COLOR=true

BREW_COMMAND_NOT_FOUND_INIT="$HOMEBREW_PREFIX/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
[[ -s "$BREW_COMMAND_NOT_FOUND_INIT" ]] && . "$BREW_COMMAND_NOT_FOUND_INIT"
if (( ${+commands[pyenv]} )); then eval "$(pyenv init - zsh)"; fi
if (( ${+commands[pyenv-virtualenv-init]} )); then eval "$(pyenv virtualenv-init - zsh)"; fi
if (( ${+commands[rbenv]} )); then eval "$(rbenv init - zsh)"; fi
if (( ${+commands[hub]} )); then alias git=hub; fi
if (( ${+commands[direnv]} )); then
    eval "$(direnv hook zsh)";
    [[ -n "$TMUX" && -f "$PWD/.envrc" ]] && direnv reload
fi
[[ -s "$HOMEBREW_PREFIX/etc/profile.d/autojump.sh" ]] && . "$HOMEBREW_PREFIX/etc/profile.d/autojump.sh"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_PATH="$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -s "$ZSH_HIGHLIGHT_PATH" ]] && . "$ZSH_HIGHLIGHT_PATH"
[[ -s "$HOME/.travis/travis.sh" ]] && . "$HOME/.travis/travis.sh"

zstyle :omz:plugins:ssh-agent agent-forwarding on

. "$ZSH/oh-my-zsh.sh"

if (( ${+commands[fzf]} )); then
    [[ $- =~ i ]] && . "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
    . "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
elif [[ -d "$HOME/.fzf" ]]; then
    export PATH="$PATH:$HOME/.fzf/bin"
    [[ $- =~ i ]] && . "$HOME/.fzf/shell/completion.zsh" 2> /dev/null
    . "$HOME/.fzf/shell/key-bindings.zsh"
fi

alias rake='noglob rake'
alias rm='safe-rm'
if (( ! ${+commands[sha1sum]} )); then alias sha1sum='gsha1sum'; fi
if (( ! ${+commands[sha256sum]} )); then alias sha256sum='gsha256sum'; fi
if (( ! ${+commands[md5sum]} )); then alias md5sum='gmd5sum'; fi
alias vim='nvim -p'
alias vimdiff='nvim -d'
alias subl='subl && sleep 0.1 && subl'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'
alias bubu='brew update && brew upgrade --cleanup'

hist() {
    if [[ "$1" == "-c" ]]; then
        rm -f "$HOME/.zsh_history"
    else
        history
    fi
}

# Change iterm2 profile. Usage it2prof ProfileName (case sensitive)
# https://coderwall.com/p/s-2_nw/change-iterm2-color-profile-from-the-cli
it2prof()  { echo -e "\033]50;SetProfile=$1\a"; }
it2dark()  { it2prof "Seoul256"; }
it2light() { it2prof "Solarized Light"; }

# Load confidential information
[[ -s "$HOME/.config/tokens" ]] && . "$HOME/.config/tokens"
