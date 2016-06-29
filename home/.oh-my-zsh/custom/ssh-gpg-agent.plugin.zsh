# Ref:
#   https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/ssh-agent/ssh-agent.plugin.zsh
#   https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/gpg-agent/gpg-agent.plugin.zsh

_plugin__ssh_env="$HOME/.ssh/ssh-agent-${HOST:=$(hostname)}.env"
_plugin__gpg_env="$HOME/.gnupg/gpg-agent-${HOST:=$(hostname)}.env"
_plugin__ssh_sock_dir="/tmp/ssh-agent-$USER"
_plugin__gpg_sock_dir="/tmp/gpg-agent-$USER"
_plugin__ssh_sock="${_plugin__ssh_sock_dir}/S.ssh-agent"
_plugin__gpg_sock="${_plugin__gpg_sock_dir}/S.gpg-agent"

function _plugin__ssh_agent_running()
{
    [[ -n "$SSH_AUTH_SOCK" ]] && /usr/bin/env ssh-add -l &>/dev/null
}

function _plugin__gpg_agent_running()
{
    [[ -n "$GPG_AGENT_INFO" ]] && /usr/bin/env gpg-connect-agent --quiet /bye &>/dev/null
}

function _plugin__set_ssh_agent_sock()
{
    # Add a symlink for screen/tmux for agent forwarding
    if [[ ! -L "$SSH_AUTH_SOCK" ]]; then
        mkdir -p "${_plugin__ssh_sock_dir}"
        chmod 700 "${_plugin__ssh_sock_dir}"
        ln -sfn "$SSH_AUTH_SOCK" "${_plugin__ssh_sock}"
        export SSH_AUTH_SOCK="${_plugin__ssh_sock}"
    fi
}

function _plugin__set_gpg_agent_sock()
{
    local gpg_sock_file
    local gpg_sock_port

    gpg_sock_file="${GPG_AGENT_INFO%%:*}"
    gpg_sock_port="${GPG_AGENT_INFO#*:}"

    # Add a symlink for screen/tmux for agent forwarding
    if [[ ! -L "$gpg_sock_file" ]]; then
        mkdir -p "${_plugin__gpg_sock_dir}"
        chmod 700 "${_plugin__gpg_sock_dir}"
        ln -sfn "$gpg_sock_file" "${_plugin__gpg_sock}"
        export GPG_AGENT_INFO="${_plugin__gpg_sock}:$gpg_sock_port"
    fi
}

function _plugin__start_ssh_agent()
{
    echo starting ssh-agent...

    # start ssh-agent and setup environment
    (umask 0077; /usr/bin/env ssh-agent | sed 's/^echo/#echo/' > "${_plugin__ssh_env}")
    chmod 600 "${_plugin__ssh_env}"
    . "${_plugin__ssh_env}" > /dev/null

    # load identies
    /usr/bin/env ssh-add

    _plugin__set_ssh_agent_sock
}

function _plugin__start_gpg_agent()
{
    echo starting gpg-agent...

    # start gpg-agent and setup environment
    (umask 0077; /usr/bin/env gpg-agent --quiet --daemon --write-env-file "${_plugin__gpg_env}" > /dev/null)
    chmod 600 "${_plugin__gpg_env}"
    . "${_plugin__gpg_env}" > /dev/null
    export GPG_AGENT_INFO

    _plugin__set_gpg_agent_sock
}

if _plugin__ssh_agent_running; then
    _plugin__set_ssh_agent_sock
else
    if [[ -f "${_plugin__ssh_env}" ]]; then
        . "${_plugin__ssh_env}" > /dev/null
        _plugin__set_ssh_agent_sock
    fi

    if ! _plugin__ssh_agent_running; then
        _plugin__start_ssh_agent
    fi
fi

if _plugin__gpg_agent_running; then
    _plugin__set_gpg_agent_sock
else
    if [[ -f "${_plugin__gpg_env}" ]]; then
        . "${_plugin__gpg_env}" > /dev/null
        export GPG_AGENT_INFO
        _plugin__set_gpg_agent_sock
    fi

    if ! _plugin__gpg_agent_running; then
        _plugin__start_gpg_agent
    fi
fi

GPG_TTY="$(tty)"
export GPG_TTY

# cleanup
unset -f _plugin__ssh_agent_running
unset -f _plugin__gpg_agent_running
unset -f _plugin__set_ssh_agent_sock
unset -f _plugin__set_gpg_agent_sock
unset -f _plugin__start_ssh_agent
unset -f _plugin__start_gpg_agent
unset _plugin__ssh_env
unset _plugin__gpg_env
unset _plugin__ssh_sock_dir
unset _plugin__gpg_sock_dir
unset _plugin__ssh_sock
unset _plugin__gpg_sock
