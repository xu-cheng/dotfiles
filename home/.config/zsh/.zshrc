if [[ -z "$LANG" || -z "$LANGUAGE" || -z "$LC_CTYPE" ]]; then
    export LANG="en_US.UTF-8"
    export LANGUAGE="en_US.UTF-8"
    export LC_CTYPE="en_US.UTF-8"
fi

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


if [[ "$OSTYPE" == darwin* ]]; then # macOS
    export HOMEBREW_PREFIX="/usr/local"
    export HOMEBREW_REPOSITORY="/usr/local/Homebrew"
    export PATH="$HOME/.bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/Library/TeX/texbin"
elif [[ -n "$CSR" ]] then # Linux on CSR
    export HOMEBREW_PREFIX="$HOME/usr"
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
    # do not load ssh-gpg-agent on CSR
    plugins[${plugins[(i)ssh-gpg-agent]}]=()
else # Linux
    export PATH="$HOME/.bin:$PATH"
fi

if [[ -n "$HOMEBREW_PREFIX" ]]; then
    export HOMEBREW_DEVELOPER=true
    export HOMEBREW_NO_ANALYTICS=true
    export HOMEBREW_NO_AUTO_UPDATE=true
    export HOMEBREW_SANDBOX=true

    export PYENV_ROOT="$HOMEBREW_PREFIX/var/pyenv"
    export RBENV_ROOT="$HOMEBREW_PREFIX/var/rbenv"

    BREW_COMMAND_NOT_FOUND_PATH="$HOMEBREW_REPOSITORY/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
    [[ -s "$BREW_COMMAND_NOT_FOUND_PATH" ]] && . "$BREW_COMMAND_NOT_FOUND_PATH"

    AUTOJUMP_PATH="$HOMEBREW_PREFIX/share/autojump/autojump.zsh"
    ZSH_HIGHLIGHT_PATH="$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    FZF_SHELL_PATH="$HOMEBREW_PREFIX/opt/fzf/shell"

    [[ -d "$HOMEBREW_PREFIX/opt/llvm" ]] && alias lldb="$HOMEBREW_PREFIX/opt/llvm/bin/lldb"
    alias bubu='brew update && brew upgrade --cleanup'
else
    AUTOJUMP_PATH="/usr/share/autojump/autojump.zsh"
    ZSH_HIGHLIGHT_PATH="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

if [[ -d "$HOME/.fzf" ]]; then
    export PATH="$HOME/.fzf/bin:$PATH"
    FZF_SHELL_PATH="$HOME/.fzf/shell"
fi

export PYENV_VIRTUALENV_DISABLE_PROMPT=true
export CHEATCOLORS=true

if (( ${+commands[pyenv]} )); then eval "$(pyenv init - zsh)"; fi
if (( ${+commands[pyenv-virtualenv-init]} )); then eval "$(pyenv virtualenv-init - zsh)"; fi
if (( ${+commands[rbenv]} )); then eval "$(rbenv init - zsh)"; fi
if (( ${+commands[hub]} )); then alias git=hub; fi
if (( ${+commands[safe-rm]} )); then alias rm='safe-rm'; fi
if (( ${+commands[direnv]} )); then
    eval "$(direnv hook zsh)";
    [[ -n "$TMUX" && -f "$PWD/.envrc" ]] && direnv reload
fi
if (( ${+commands[nvim]} )); then
    export EDITOR="nvim"
    alias vim='nvim -p'
    alias vimdiff='nvim -d'
fi
[[ -s "$AUTOJUMP_PATH" ]] && . "$AUTOJUMP_PATH"
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
[[ -s "$ZSH_HIGHLIGHT_PATH" ]] && . "$ZSH_HIGHLIGHT_PATH"

. "$ZSH/oh-my-zsh.sh"

if [[ -d "$FZF_SHELL_PATH" ]]; then
    [[ $- =~ i ]] && . "$FZF_SHELL_PATH/completion.zsh" 2> /dev/null
    . "$FZF_SHELL_PATH/key-bindings.zsh"
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    bindkey -r '^T'
    bindkey '^P' fzf-file-widget # use <Ctrl-P> instead of <Ctrl-T>
    export FZF_TMUX=1
fi

alias rake='noglob rake'
alias ta='tmux attach -t'
alias tl='tmux list-sessions'
alias ts='tmux new-session -s'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'

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
