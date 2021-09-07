# typeset -g ZSH_AUTOSUGGES1T_BUFFER_MAX_SIZE='20'
source <(kubectl completion zsh)

alias k=kubectl
complete -F _kubectl k