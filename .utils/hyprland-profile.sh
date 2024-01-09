# ------------------------------------------------------
# Hyprland profile
# ------------------------------------------------------
echo -e "${GREEN}"
figlet "Hyprland"
echo -e "${NONE}"

if [[ $(_isInstalledPacman "hyprland") == 0 ]]; then
    echo -e "\e[0;32m --[hyprland already installed!] \e[0m"
    hyprland_installed=1
else
    echo -e "\e[1;32m --[hyprland NOT installed!] \e[0m"
fi
echo
