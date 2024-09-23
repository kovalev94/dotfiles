# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

# Start ssh-agent
SSH_ENV="$HOME/.ssh/agent-environment"
SSH_AGENT_CMD=$(which ssh-agent)
function start_agent {
    echo "Initialising new SSH agent..."
    $SSH_AGENT_CMD | sed 's/^echo/#echo/' > "${SSH_ENV}"
    echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
}

if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    #ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

pgrep  emacs >> /dev/null || emacs --daemon >> /dev/null
