#!/bin/bash

# -----------------------------------------------------
# Alias
# -----------------------------------------------------
source ~/.local/dotfiles/exports/bash-alias.sh



# -----------------------------------------------------
# PFETCH if on wm
# -----------------------------------------------------
if [[ $(tty) == *"pts"* ]]; then
    pfetch
fi


# Define Editor
export EDITOR=nvim
# CHROMIUM_FLAGS="--force-device-scale-factor=5.2 --high-dpi-support=1"

# -----------------------------------------------------
# START STARSHIP
# -----------------------------------------------------
eval "$(starship init bash)"
# -----------------------------------------------------


# -----------------------------------------------------
# nvm
# -----------------------------------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# -----------------------------------------------------
# NeoVim
# -----------------------------------------------------
alias vuevim="export MY_NVIM_APPNAME="vuevim" && nvim"
alias lazyvim="export MY_NVIM_APPNAME="lazyvim" && nvim"
# default lazyvim
export MY_NVIM_APPNAME="lazyvim"



# -----------------------------------------------------
# wsl
# must start terminal with C:\Windows\system32\wsl.exe -d Ubuntu
# for start up with prev session setting，another ubuntu.exe wont pick osx 9;9;
# -----------------------------------------------------
PROMPT_COMMAND=${PROMPT_COMMAND:+"$PROMPT_COMMAND; "}'printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"'



# -----------------------------------------------------
# History
# -----------------------------------------------------
source ~/.local/dotfiles/exports/history.sh

