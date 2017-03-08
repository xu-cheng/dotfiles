ZSH="$ZDOTDIR/oh-my-zsh"
ZSH_CUSTOM="$ZDOTDIR/custom"
ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump-${HOST}-${ZSH_VERSION}"
HISTFILE="$ZSH_CACHE_DIR/history"

[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"

ZSH_THEME="mytheme"
plugins=(brew-cask colored-man-pages docker docker-compose extract git \
         git-flow-avh gitignore mercurial osx pip ssh-gpg-agent svn vagrant \
         xdg-base-dir)

export DOTFILES_HOME="${$(readlink "$HOME/.zshenv")%/*}"
export HOMEBREW_NO_ANALYTICS=true # set before any brew invoking.

if [[ `uname` == "Darwin" ]]; then # OS X
    export HOMEBREW_PREFIX="/usr/local"
    export HOMEBREW_REPOSITORY="/usr/local/Homebrew"
    export PATH="$DOTFILES_HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/gnupg-2.1/bin:/Library/TeX/texbin"
else # Linux
    [[ -n "$HOMEBREW_PREFIX" ]] || export HOMEBREW_PREFIX="$HOME/.linuxbrew"
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
    if [[ -n "$CSR" ]]; then
        # do not load ssh-gpg-agent on CSR
        plugins[${plugins[(i)ssh-gpg-agent]}]=()
    fi
fi

export EDITOR="nvim"
export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket"
export PYENV_ROOT="$HOMEBREW_PREFIX/var/pyenv"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV=true
export PYENV_VIRTUALENV_DISABLE_PROMPT=true
export RBENV_ROOT="$HOMEBREW_PREFIX/var/rbenv"
export CHEATCOLORS=true
export HOMEBREW_SANDBOX=true
export HOMEBREW_DEVELOPER=true
export HOMEBREW_NO_AUTO_UPDATE=true

BREW_COMMAND_NOT_FOUND_INIT="$HOMEBREW_REPOSITORY/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
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

. "$ZSH/oh-my-zsh.sh"

if [[ -d "$HOMEBREW_PREFIX/opt/fzf" ]]; then
    [[ $- =~ i ]] && . "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" 2> /dev/null
    . "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

alias bubu='brew update && brew upgrade --cleanup'
alias gpg='gpg2'
alias lldb="$HOMEBREW_PREFIX/opt/llvm/bin/lldb"
alias rake='noglob rake'
alias rm='safe-rm'
alias ta='tmux attach -t'
alias tl='tmux list-sessions'
alias ts='tmux new-session -s'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias vim='nvim -p'
alias vimdiff='nvim -d'
if (( ! ${+commands[sha1sum]} )); then alias sha1sum='gsha1sum'; fi
if (( ! ${+commands[sha256sum]} )); then alias sha256sum='gsha256sum'; fi
if (( ! ${+commands[md5sum]} )); then alias md5sum='gmd5sum'; fi

hist() {
    if [[ "$1" == "-c" ]]; then
        echo -n > "$HISTFILE"
    else
        history
    fi
}

# auto update environment when running in tmux
TRAPUSR1() {
    local -a envs
    local env
    if [[ -o interactive && -n "$TMUX" ]]; then
        envs=("${(@f)$(tmux show-environment 2>/dev/null)}")
        for env in $envs; do
            if [[ "$env" = "-"* ]]; then
                unset "${env:1}"
            else
                export "$env"
            fi
        done
    fi
}

# Change iterm2 profile. Usage it2prof ProfileName (case sensitive)
# https://coderwall.com/p/s-2_nw/change-iterm2-color-profile-from-the-cli
tmux_escape() {
    if [[ -n "$TMUX" || "$TERM" = *screen* ]]; then
        printf '\033Ptmux;\033%b\033\\' "$1"
    else
        printf "$1"
    fi
}
it2prof()  { tmux_escape "\033]50;SetProfile=$1\a"; }
it2dark()  { it2prof "Seoul256"; }
it2light() { it2prof "Solarized Light"; }

# Load confidential information
if [[ -s "$XDG_CONFIG_HOME/tokens" ]]; then
    . "$XDG_CONFIG_HOME/tokens"
fi
