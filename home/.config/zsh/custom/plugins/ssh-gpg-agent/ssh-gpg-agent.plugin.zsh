# Ref:
#   https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/ssh-agent/ssh-agent.plugin.zsh
#   https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/gpg-agent/gpg-agent.plugin.zsh

[[ -n "$HOST" ]] || HOST="$(hostname)"
_plugin__ssh_env="$HOME/.ssh/ssh-agent-$HOST.env"

function _plugin__gpg21()
{
    [[ "$(/usr/bin/env gpg --version 2>/dev/null | head -n 1)" = *"2.1"* ]]
}

function _plugin__ssh_agent_running()
{
    # ssh-add -l exit code: 0 agent running, 1 agent running without key, 2 not running
    [[ -n "$SSH_AUTH_SOCK" && "$(/usr/bin/env ssh-add -l &>/dev/null; echo $?)" -ne 2 ]]
}

function _plugin__mac_ssh_agent_running_without_key()
{
    # ssh-add -l exit code: 0 agent running, 1 agent running without key, 2 not running
    [[ "$OSTYPE" == darwin* && -n "$SSH_AUTH_SOCK" && "$(/usr/bin/env ssh-add -l &>/dev/null; echo $?)" -eq 1 ]]
}

function _plugin__gpg_agent_running()
{
    [[ "$(/usr/bin/env gpg-connect-agent --no-autostart --quiet /bye 2>&1)" != *"no gpg-agent running"* ]]
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
}

function _plugin__start_gpg_agent()
{
    echo starting gpg-agent...
    (umask 0077; /usr/bin/env gpg-agent --quiet --daemon > /dev/null)
}

if ! _plugin__ssh_agent_running; then
    if [[ -f "${_plugin__ssh_env}" ]]; then
        . "${_plugin__ssh_env}" > /dev/null
    fi

    if ! _plugin__ssh_agent_running; then
        _plugin__start_ssh_agent
    fi
fi

if _plugin__mac_ssh_agent_running_without_key; then
    echo loading ssh keys from macOS keychain...
    (/usr/bin/env ssh-add -A &>/dev/null &)
fi

if _plugin__gpg21 && ! _plugin__gpg_agent_running; then
    _plugin__start_gpg_agent
fi

GPG_TTY="$(tty)"
export GPG_TTY

# cleanup
unset -f _plugin__gpg21
unset -f _plugin__ssh_agent_running
unset -f _plugin__gpg_agent_running
unset -f _plugin__start_ssh_agent
unset -f _plugin__start_gpg_agent
unset -f _plugin__mac_ssh_agent_running_without_key
unset _plugin__ssh_env
