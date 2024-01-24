#!/bin/bash
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
function vuevim
    env NVIM_APPNAME=vuevim nvim
end

function lazyvim
    env NVIM_APPNAME=lazyvim nvim
end

// default lazyvim
env NVIM_APPNAME=lazyvim


