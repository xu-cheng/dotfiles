
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
function prompt_pyenv(){
    if which pyenv &>/dev/null; then
        local pyenv_version="$(pyenv version-name)"
        if [[ "$pyenv_version" != "system" ]]; then
            echo "pyenv:%{${fg[yellow]}%}$pyenv_version%{$reset_color%}"
        fi
    fi
}

# Rbenv info
function prompt_rbenv(){
    if which rbenv &>/dev/null; then
        local rbenv_version="$(rbenv version-name)"
        if [[ "$rbenv_version" != "system" ]]; then
            echo "rbenv:%{${fg[yellow]}%}$rbenv_version%{$reset_color%}"
        fi
    fi
}

# Assemble additional info
function prompt_additional(){
    local -a array1
    local -a array2

    array1=( \
        "$(prompt_git)" \
        "$(prompt_hg)" \
        "$(prompt_svn)" \
        "$(prompt_pyenv)" \
        "$(prompt_rbenv)" \
    )

    for (( i=1 ; i<=$#array1 ; i++ )) do
        if [[ -n $array1[i] ]]; then
            array2+=("$array1[i]")
        fi
    done

    if [[ $#array2 != 0 ]]; then
        echo "%{$fg[white]%}on%{$reset_color%} ${(pj:, :)array2} "
    fi
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
# Format: \n # USER at MACHINE in DIRECTORY on [git/hg/svn] [pyenv] [rbenv] [TIME] \n $
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
