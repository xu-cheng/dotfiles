if [[ -z "$LANG" || -z "$LANGUAGE" || -z "$LC_CTYPE" ]]; then
    export LANG="en_US.UTF-8"
    export LANGUAGE="en_US.UTF-8"
    export LC_CTYPE="en_US.UTF-8"
fi

ZSH="$XDG_DATA_HOME/zsh/oh-my-zsh"
ZSH_CUSTOM="$XDG_CONFIG_HOME/zsh/custom"
ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
ZSH_STATE_DIR="$XDG_STATE_HOME/zsh"
ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump-${HOST}-${ZSH_VERSION}"
DISABLE_UPDATE_PROMPT=true
HISTFILE="$ZSH_STATE_DIR/history"

[[ -d "$ZSH" ]] || git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh "$ZSH"
[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p "$ZSH_CACHE_DIR"
[[ -d "$ZSH_STATE_DIR" ]] || mkdir -p "$ZSH_STATE_DIR"

plugins=( \
    asdf \
    colored-man-pages \
    docker \
    docker-compose \
    git \
    gitignore \
    kubectl \
    rake-fast \
    ssh-gpg-agent \
    terraform \
    vagrant \
    xdg-base-dir \
)

if [[ "$OSTYPE" == darwin* ]]; then # macOS
    if [[ "$(uname -m)" == x86_64 ]]; then
        export HOMEBREW_PREFIX="/usr/local"
    else
        export HOMEBREW_PREFIX="/opt/homebrew"
    fi
    export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX/Homebrew"
    RUBY_API_VERSION="$("$HOMEBREW_PREFIX/opt/ruby/bin/ruby" -e 'print Gem.ruby_api_version')"
    export PATH="$XDG_BIN_HOME:$HOMEBREW_PREFIX/lib/ruby/gems/$RUBY_API_VERSION/bin:$HOMEBREW_PREFIX/opt/ruby/bin:$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/Library/TeX/texbin"
    unset RUBY_API_VERSION
else # Linux
    RUBY_API_VERSION="$(ruby -e 'print Gem.ruby_api_version')"
    export PATH="$XDG_BIN_HOME:$XDG_DATA_HOME/gem/ruby/$RUBY_API_VERSION/bin:$PATH"
fi

if [[ -n "$HOMEBREW_PREFIX" ]]; then
    export HOMEBREW_NO_ANALYTICS=true
    export HOMEBREW_NO_ENV_HINTS=true

    BREW_COMMAND_NOT_FOUND_PATH="$HOMEBREW_PREFIX/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
    [[ -s "$BREW_COMMAND_NOT_FOUND_PATH" ]] && . "$BREW_COMMAND_NOT_FOUND_PATH"

    ZSH_HIGHLIGHT_PATH="$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    FZF_SHELL_PATH="$HOMEBREW_PREFIX/opt/fzf/shell"
    STARSHIP_PATH="$HOMEBREW_PREFIX/opt/starship/bin/starship"

    alias bubo='brew update && brew outdated'
    alias bubu='brew update && brew upgrade --formulae && brew cleanup'

    fpath+="$HOMEBREW_PREFIX/share/zsh/site-functions"
else
    ZSH_HIGHLIGHT_PATH="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    STARSHIP_PATH="starship"

    if [[ -s "/etc/zsh_command_not_found" ]]; then
        source "/etc/zsh_command_not_found"
    fi

    if [[ -d "$HOME/.fzf" ]]; then
        export PATH="$HOME/.fzf/bin:$PATH"
        FZF_SHELL_PATH="$HOME/.fzf/shell"
    elif [[ -d "/usr/share/doc/fzf/examples" ]]; then
        FZF_SHELL_PATH="/usr/share/doc/fzf/examples"
    fi
fi

if (( ${+commands[safe-rm]} )); then alias rm='safe-rm'; fi
if (( ${+commands[bat]} )); then alias cat=bat; fi
if (( ${+commands[direnv]} )); then
    eval "$(direnv hook zsh)";
    [[ -n "$TMUX" && -f "$PWD/.envrc" ]] && direnv reload
fi
if (( ${+commands[nvim]} )); then
    export EDITOR='nvim -p'
    alias vim='nvim -p'
    alias vimdiff='nvim -d'
fi
if [[ -s "$ZSH_HIGHLIGHT_PATH" ]]; then
  # From https://github.com/catppuccin/zsh-syntax-highlighting/
  . "$XDG_CONFIG_HOME/zsh/catppuccin_frappe-zsh-syntax-highlighting.zsh"
  # tweak the colortheme
  ZSH_HIGHLIGHT_STYLES[path_pathseparator]="${ZSH_HIGHLIGHT_STYLES[path]}"
  ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]="${ZSH_HIGHLIGHT_STYLES[path_prefix]}"
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
  . "$ZSH_HIGHLIGHT_PATH"
fi

. "$ZSH/oh-my-zsh.sh"

eval "$("$STARSHIP_PATH" init zsh)"

if (( ${+commands[zoxide]} )) then
    export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"
    export _ZO_EXCLUDE_DIRS="/tmp/*;/private/tmp/*"
    eval "$(zoxide init zsh --cmd j)"
fi

if [[ -d "$FZF_SHELL_PATH" ]]; then
    [[ $- =~ i ]] && . "$FZF_SHELL_PATH/completion.zsh" 2> /dev/null
    . "$FZF_SHELL_PATH/key-bindings.zsh"
    if (( ${+commands[fd]} )); then
        export FZF_DEFAULT_COMMAND='fd --hidden --follow --exclude ".git"'
    else
        export FZF_DEFAULT_COMMAND='find . -not -path "*/.git/*"'
    fi
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

    # If current selection is a text file shows its content,
    # if it's a directory shows its content, the rest is ignored
    # Ref: https://github.com/silvanocerza/dotfiles/blob/d3cf4ed770f18ba81a9059f7dd93dc3a97381239/zsh/zshrc#L44-L55
    if (( ${+commands[bat]} )); then
        FZF_CAT_CMD="bat --color always"
    else
        FZF_CAT_CMD="cat"
    fi
    if (( ${+commands[eza]} )); then
        FZF_LS_CMD="eza -l --all --color always"
    else
        FZF_LS_CMD="ls -l --all --color always"
    fi
    export FZF_CTRL_T_OPTS="--preview-window wrap --preview '
    if [[ -f {} ]]; then
        file --mime {} | grep -q \"text\/.*;\" && $FZF_CAT_CMD {} || (tput setaf 1; file --mime {})
    elif [[ -d {} ]]; then
        $FZF_LS_CMD {}
    else
        tput setaf 1; echo YOU ARE NOT SUPPOSED TO SEE THIS!
    fi'"
    unset FZF_CAT_CMD
    unset FZF_LS_CMD

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
alias tx='tmuxinator'
alias txa='tmuxinator start'
alias txl='tmuxinator list'
alias txn='tmuxinator new'
alias txe='tmuxinator edit'

if (( ${+commands[eza]} )); then
  alias ls='eza'
  alias l='eza --all --long --header --git --icons'
fi

if (( ! ${+commands[sha1sum]} && ${+commands[gsha1sum]} )); then
    alias sha1sum='gsha1sum';
fi
if (( ! ${+commands[sha256sum]} && ${+commands[gsha256sum]} )); then
    alias sha256sum='gsha256sum';
fi
if (( ! ${+commands[md5sum]} && ${+commands[gmd5sum]} )); then
    alias md5sum='gmd5sum';
fi

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

# Load confidential information
if [[ -s "$XDG_CONFIG_HOME/tokens" ]]; then
    . "$XDG_CONFIG_HOME/tokens"
fi
