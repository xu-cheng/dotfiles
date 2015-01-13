
local check_mark='\xE2\x9C\x94'
local x_mark='\xE2\x9C\x98'

# User info.
function prompt_user(){
    echo "%{$fg[cyan]%}%n"
}

# Machine info.
function prompt_machine(){
    echo "%{$fg[green]%}%m"
}

# Directory info.
function prompt_dir(){
    local current_dir="${PWD/#$HOME/~}"
    echo "%{$terminfo[bold]$fg[yellow]%}$current_dir%{$reset_color%}"
}

# Git info
function prompt_git(){
    ZSH_THEME_GIT_PROMPT_PREFIX="git:%{$fg[cyan]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}$x_mark"
    ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}$check_mark"
    git_prompt_info
}

# Mercurial info
function prompt_hg(){
    ZSH_THEME_HG_PROMPT_PREFIX="hg:%{$fg[cyan]%}"
    ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[red]%}$x_mark"
    ZSH_THEME_HG_PROMPT_CLEAN=" %{$fg[green]%}$check_mark"
    hg_prompt_info
}

# SVN info
function prompt_svn(){
    ZSH_THEME_SVN_PROMPT_PREFIX="svn:%{$fg[cyan]%}"
    ZSH_THEME_SVN_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_SVN_PROMPT_DIRTY=" %{$fg[red]%}$x_mark"
    ZSH_THEME_SVN_PROMPT_CLEAN=" %{$fg[green]%}$check_mark"
    if in_svn; then
        _DISPLAY=$(
            svn info 2> /dev/null | \
              awk -F/ \
              '/^URL:/ { \
                for (i=0; i<=NF; i++) { \
                  if ($i == "branches" || $i == "tags" ) { \
                    print $(i+1); \
                    break;\
                  }; \
                  if ($i == "trunk") { print $i; break; } \
                } \
            }'
        )
        if [[ -z $_DISPLAY ]];then
            _DISPLAY="default"
        fi
        echo "$ZSH_THEME_SVN_PROMPT_PREFIX$_DISPLAY$(svn_dirty)$ZSH_THEME_SVN_PROMPT_SUFFIX"
        unset _DISPLAY
    fi
}

# Pyenv info
export VIRTUAL_ENV_DISABLE_PROMPT=1
function prompt_pyenv(){
    local pyenv_version="$(pyenv version-name)"
    if [[ $FOUND_PYENV -eq 1 ]] && [[ "$pyenv_version" != "system" ]]; then
        echo "pyenv:%{${fg[yellow]}%}$pyenv_version%{$reset_color%}"
    fi
}

# Assemble additional info
function prompt_additional(){
    python3 -c 'import sys;ret=", ".join(x for x in sys.argv[2:] if x); \
                ret and print(sys.argv[1]+ret+" ")' \
              "%{$fg[white]%}on%{$reset_color%} " \
              "$(prompt_git)" \
              "$(prompt_hg)" \
              "$(prompt_svn)" \
              "$(prompt_pyenv)"
}

# Prompt info.
function prompt_status(){
    if [[ $EUID -ne 0 ]]; then
        echo "%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
    else
        echo "%{$terminfo[bold]$fg[red]%}# %{$reset_color%}"
    fi
}

# Main prompt
# Format: \n # USER at MACHINE in DIRECTORY on [git/hg/svn] [pyenv] [TIME] \n $ 
PROMPT='
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
$(prompt_user) \
%{$fg[white]%}at \
$(prompt_machine) \
%{$fg[white]%}in \
$(prompt_dir) \
$(prompt_additional)\
%{$fg[white]%}[%*]
$(prompt_status)'
