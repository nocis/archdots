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


