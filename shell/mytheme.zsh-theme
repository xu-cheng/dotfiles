
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

# Git info.
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}on%{$reset_color%} git:%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}$x_mark"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}$check_mark"

# Mercurial info.
ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[white]%}on%{$reset_color%} hg:%{$fg[cyan]%}"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[red]%}$x_mark"
ZSH_THEME_HG_PROMPT_CLEAN=" %{$fg[green]%}$check_mark"

# SVN info.
ZSH_THEME_SVN_PROMPT_PREFIX="%{$fg[white]%}on%{$reset_color%} svn:%{$fg[cyan]%}"
ZSH_THEME_SVN_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_SVN_PROMPT_DIRTY=" %{$fg[red]%}$x_mark"
ZSH_THEME_SVN_PROMPT_CLEAN=" %{$fg[green]%}$check_mark"
function prompt_svn(){
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

# Pyenv info.
export VIRTUAL_ENV_DISABLE_PROMPT=1
function prompt_pyenv(){
    if [[ $FOUND_PYENV -eq 1 ]] && [[ "$(pyenv_prompt_info)" != "system" ]]; then
        echo "%{$fg[white]%}on%{$reset_color%} %{${fg[yellow]}%}$(pyenv_prompt_info)%{$reset_color%}"
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
# Format: \n # USER at MACHINE in DIRECTORY on [git/hg/svn] [pyenv] [TIME] \n $ 
PROMPT='
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
$(prompt_user) \
%{$fg[white]%}at \
$(prompt_machine) \
%{$fg[white]%}in \
$(prompt_dir) \
$(git_prompt_info)$(hg_prompt_info)$(prompt_svn)$(prompt_pyenv)\
%{$fg[white]%}[%*]
$(prompt_status)'
