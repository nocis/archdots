# ------------------------------------------------------
# Select installation profile
# ------------------------------------------------------
echo -e "${GREEN}"
figlet "Profile"
echo -e "${NONE}"

echo -e "\e[1;31m SPACE = select/unselect a profile. RETURN = confirm. No selection = CANCEL \e[0m"
profile=$(gum choose --no-limit --cursor-prefix "( ) " --selected-prefix "(x) " --unselected-prefix "( ) " "Hyprland" "Qtile")

# -z string: True if the string is null (an empty string)
if [ -z $profile ] ;then
    echo "No profile selected. Installation canceled."
    exit
else
    echo "Profile/s selected: $profile"
fi
