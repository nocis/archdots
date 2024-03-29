# ‘[[ ]]’ is an extended Bash command that is the enhanced version of ‘[ ]’.

# 0. minimal packages
# pacstrap -K /mnt base linux linux-firmware
# efibootmgr: cat /etc/fstab | grep -om 1 "^UUID[^ ]*" >> /boot/loader/entries/arch.conf
# networkmanager: sudo systemctl enable --now NetworkManager.service -> nmtui
# curl
# openssh
# sshd: sudo systemctl start sshd

# 1. 
# read -p "Do you want to install Xorg drivers? " -n 1 -r
# echo    # (optional) move to a new line
# if [[ $REPLY =~ ^[Yy]$ ]]
#then
#    echo $PW | sudo -kS pacman -S --noconfirm xf86-video-amdgpu xorg  > /dev/null 2>&1
#    echo -e "\e[1;33m --[Xorg drivers installed] \e[0m"
#else
#    echo -e "\e[1;31m --[Xorg drivers not installed] \e[0m"
#fi

# 0. required
read -p "Do you want to install required packages (gum, figlet)? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
    _installPkgsPacman "gum" "figlet"
else
    echo -e "\e[1;31m --[required packages (gum, figlet) not installed] \e[0m"
fi    

read -p "Do you want to install nodejs, npm, nvm? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
    _installPkgsPacman "nodejs" "npm"

    if [[ ! -d ~/.nvm ]]; then
        git clone https://github.com/nvm-sh/nvm.git ~/.nvm > /dev/null 2>&1
        cd ~/.nvm
        # Get new tags from remote
        git fetch --tags > /dev/null 2>&1

        # Get latest tag name
        latestTag=$(git describe --tags `git rev-list --tags --max-count=1`)
        git checkout $latestTag > /dev/null 2>&1
        . ./nvm.sh > /dev/null 2>&1
        echo -e "\e[1;32m --[nvm installed successfully] \e[0m"
        cd ~/.local
    else
        echo -e "\e[1;33m --[nvm already installed] \e[0m"
    fi

else
    echo -e "\e[1;31m --[nodejs, npm, nvm not installed] \e[0m"
fi    

# 1. yay
read -p "Do you want to install yay? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo $PW | sudo -kS pacman -S --needed --noconfirm base-devel  > /dev/null 2>&1
    cd /opt
    echo $PW | sudo -kS git clone https://aur.archlinux.org/yay.git > /dev/null 2>&1
    echo $PW | sudo -kS chmod -R 777 yay > /dev/null 2>&1
    echo $PW | sudo -kS chown -R $USER:$USER yay > /dev/null 2>&1
    cd yay
    makepkg -si 
    echo -e "\e[1;33m --[yay installed] \e[0m"
    cd ..
    echo $PW | sudo -kS rm -rf yay
else
    echo -e "\e[1;31m --[yay not installed] \e[0m"
fi
# 2. hyprland
read -p "Do you want to install hyprland? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo $PW | sudo -kS pacman -S --noconfirm hyprland > /dev/null 2>&1
    echo -e "\e[1;33m --[hyprland installed] \e[0m"
else
    echo -e "\e[1;31m --[hyprland not installed] \e[0m"
fi

