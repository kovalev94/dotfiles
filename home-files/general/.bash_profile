# Honor per-interactive-shell startup file
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

pgrep  emacs >> /dev/null || emacs --daemon >> /dev/null
