#!/bin/bash

if [ -d ~/.local/archdots ] ;then
    echo "A dotfiles installation has been detected!"
    echo "This script will update dotfiles."
else
    echo "This script will instal dotfiles."
fi
echo ""


# chmod +x ./x.sh new pid
# bash x.sh       new pid
# source x.sh     current pid(for current terminal env)
# . x.sh          current pid(for current terminal env)

# alias pmi="sudo pacman -S --needed"
# alias pmu="sudo pacman -Syu"  
# alias pmr="sudo pacman -Rcns"

cd $HOME/.local

# 0. save root password
echo "enter the sudo password, please"
read -s PW
# IFS= read -rs PW
# IFS= make read accept white space ! still not working for white space
echo -e "\e[1;32m [root password saved successful] \e[0m"

#echo $PW | ./playback_delete_data_patch.sh 09_delete_old_data_p.sql  
#./command_wo_sudo.sh <param>
#echo $PW | ./other_command_requires_sudo.sh <param>

# 1. prepare
echo $PW | sudo -kS pacman -Syu > /dev/null 2>&1
echo -e "\e[1;32m [pkgs update successful] \e[0m"

# 2. install git
echo $PW | sudo -kS pacman -S --needed --noconfirm git > /dev/null 2>&1
echo -e "\e[1;32m [git install successful] \e[0m"

# 4. fetch scripts from 
git clone https://github.com/nocis/archdots.git > /dev/null 2>&1
cd archdots
pwd > /dev/null 2>&1
ls > /dev/null 2>&1
git pull --recurse-submodules > /dev/null 2>&1
echo -e "\e[1;32m [clone scripts successfull] \e[0m"
git remote set-url origin git@github.com:nocis/archdots.git
cd ..
git config --global core.autocrlf input

# 5. import 
source ~/.local/archdots/.defs/colors.sh
source ~/.local/archdots/.defs/functions.sh

# 6. auto install packages
. ~/.local/archdots/.utils/install.sh
#echo -e "\e[1;32m [pkgs install successful] \e[0m"

# 7. backup
source ~/.local/archdots/.utils/backup.sh

# 8. Select profiles
source ~/.local/archdots/.utils/profile.sh


source ~/.local/archdots/.defs/general-packages.sh
source ~/.local/archdots/.utils/install-packages.sh
# 9. Hyprland packages
if [[ $profile == *"Hyprland"* ]]; then
    source ~/.local/archdots/.utils/hyprland-profile.sh
    source ~/.local/archdots/.defs/hyprland-packages.sh
    source ~/.local/archdots/.utils/install-packages.sh
fi

#if [[ $profile == *"Qtile"* ]]; then
#    source .install/qtile.sh
#    source .install/qtile-packages.sh
#    source .install/install-packages.sh
#fi

# 10. config dotfiles
read -p "Do you want to install config dotfiles? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [[ ! -d ~/.local/dotfiles ]]; then
        mkdir ~/.local/dotfiles
    fi
    cp -r ~/.local/archdots/config ~/.local/dotfiles/
    echo -e "\e[1;32m --[config dotfiles installed in ~/.local/dotfiles/] \e[0m"
fi    

if [[ $profile == *"Hyprland"* ]]; then
    source ~/.local/archdots/.utils/hyprland-dotfiles.sh
fi
#if [[ $profile == *"Qtile"* ]]; then
#    source .install/qtile-dotfiles.sh
#fi




# 7. append init.sh scrirt to bashrc
if grep -q "init.sh" ~/.bashrc
then
    # if found
    echo -e "\e[1;31m init.sh is already loaded \e[0m"
else
    # if not found
    echo 'source ~/.local/archdots/init/init.sh' >> ~/.bashrc 
    . ~/.local/archdots/init/init.sh 
#fi
#echo -e "\e[1;32m [init.sh activate successful] \e[0m"
