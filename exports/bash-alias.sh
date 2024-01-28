# -----------------------------------------------------
# Alias
# -----------------------------------------------------
# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -hal'

# workspace
alias workspace='cd "$HOME/Workspace" && export TERMINAL_WORKSPACE_NAME=workspace && export HISTFILE=${HOME}/.myhistfile.${TERMINAL_WORKSPACE_NAME}'
alias common='cd "$HOME" && export TERMINAL_WORKSPACE_NAME=common && export HISTFILE=${HOME}/.myhistfile.${TERMINAL_WORKSPACE_NAME}'
alias incognito='alacritty && cd "$PWD" && export TERMINAL_WORKSPACE_NAME=incognito && export HISTFILE=/dev/null '
