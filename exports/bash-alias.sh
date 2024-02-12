# -----------------------------------------------------
# Alias
# -----------------------------------------------------
# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -hal'

# workspace
alias workspace='history -a; cd "$HOME/Workspace" && export TERMINAL_WORKSPACE_NAME=workspace && export HISTFILE=${HOME}/.myhistfile.${TERMINAL_WORKSPACE_NAME} && history -c; history -r'
alias common='history -a; cd "$HOME" && export TERMINAL_WORKSPACE_NAME=common && export HISTFILE=${HOME}/.myhistfile.${TERMINAL_WORKSPACE_NAME} && history -c; history -r'
alias incognito='history -a; export TERMINAL_WORKSPACE_NAME=incognito && export HISTFILE=/dev/null && history -c; history -r'
