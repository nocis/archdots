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
echo $PW | sudo -kS pacman -S tzdata > /dev/null 2>&1

echo $PW | sudo -kS ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime > /dev/null 2>&1
echo $PW | sudo -kS hwclock --systohc > /dev/null 2>&1

echo $PW | sudo -kS bash -c "sed -i -e 's|#en_US.UTF-8|en_US.UTF-8|g' /etc/locale.gen" > /dev/null 2>&1
echo $PW | sudo -kS locale-gen

echo $PW | sudo -kS rm /etc/locale.conf > /dev/null 2>&1 
echo $PW | sudo -kS bash -c "echo 'LANG=en_US.UTF-8'>> /etc/locale.conf" > /dev/null 2>&1

echo $PW | sudo -kS rm /etc/hostname > /dev/null 2>&1
echo $PW | sudo -kS bash -c "echo 'arch' >> /etc/hostname" > /dev/null 2>&1

echo $PW | sudo -kS rm /etc/hosts > /dev/null 2>&1
echo $PW | sudo -kS bash -c "echo '127.0.0.1    localhost' >> /etc/hosts" > /dev/null 2>&1
echo $PW | sudo -kS bash -c "echo '::1   localhost' >> /etc/hosts" > /dev/null 2>&1
echo $PW | sudo -kS bash -c "echo '127.0.1.1    arch.localdomain    arch' >> /etc/hosts" > /dev/null 2>&1

echo $PW | sudo -kS pacman -Syu > /dev/null 2>&1
echo -e "\e[1;32m [pkgs update successful] \e[0m"

# 2. install git neovim
echo $PW | sudo -kS pacman -S --needed --noconfirm git neovim > /dev/null 2>&1
echo -e "\e[1;32m [git neovim install successful] \e[0m"

if [[ ! -f ~/.ssh/id_rsa ]]; then
    read -p "Enter github username: " githubuser
    git config --global user.name "$githubuser"
    echo "Using username $githubuser"
    read -p "Enter github email : " email
    git config --global user.email "$email"
    echo "Using email $email"

    ssh-keygen -t ed25519 -C "$email"
    ssh-add ~/.ssh/id_ed25519.pub
    pub=`cat ~/.ssh/id_ed25519.pub`

    read -p "Enter github token: " githubToken
    sshtitle = "archssh"+$(date '+%Y%m%d%H%M%S')

    echo $sshtitle
    echo $pub
#    curl -L \
#        -X POST \
#        -H "Accept: application/vnd.github+json" \
#        -H "Authorization: Bearer ${githubToken}" \
#        -H "X-GitHub-Api-Version: 2022-11-28" \
#        https://api.github.com/user/keys \
#        -d '{"title":"${sshtitle}","key":"${pub}"}'
fi

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


# 5. lazy vim
read -p "Do you want to install lazy vim? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim
    git clone https://github.com/LazyVim/starter ~/.config/nvim > /dev/null 2>&1
    rm -rf ~/.config/nvim/.git
    echo -e "\e[1;32m --[lazy vim installed in ~/.config/nvim/] \e[0m"
fi    

# 6. import 
source ~/.local/archdots/.defs/colors.sh
source ~/.local/archdots/.defs/functions.sh

# 7. auto install packages
. ~/.local/archdots/.utils/install.sh
#echo -e "\e[1;32m [pkgs install successful] \e[0m"

# 8. backup
source ~/.local/archdots/.utils/backup.sh

# 9. Select profiles
source ~/.local/archdots/.utils/profile.sh

# 10. install packages

source ~/.local/archdots/.defs/general-packages.sh
source ~/.local/archdots/.utils/install-packages.sh

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

# 11. config dotfiles
read -p "Do you want to install config dotfiles? " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
    if [[ ! -d ~/.local/dotfiles ]]; then
        mkdir ~/.local/dotfiles
    else
        rm -rf ~/.local/dotfiles/*
    fi
    cp -r ~/.local/archdots/config ~/.local/dotfiles/
    cp -r ~/.local/archdots/exports ~/.local/dotfiles/
    echo -e "\e[1;32m --[config dotfiles installed in ~/.local/dotfiles/] \e[0m"
fi    

source ~/.local/archdots/.utils/general-dotfiles.sh
if [[ $profile == *"Hyprland"* ]]; then
    source ~/.local/archdots/.utils/hyprland-dotfiles.sh
fi
#if [[ $profile == *"Qtile"* ]]; then
#    source .install/qtile-dotfiles.sh
#fi



# 12. append init.sh scrirt to bashrc
if grep -q "init.sh" ~/.bashrc
then
    # if found
    read -p "Do you want to overwrite init.sh in bashrc? " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        startMarker="START INIT"
        endMarker="END INIT"
        # customtext='$(cat ~/.local/archdots/init.sh | sed 's_/_\\/_g')'
        # customtext="$(cat ~/.local/archdots/init.sh)"
        _replaceFileInFile "$startMarker" "$endMarker" ~/.local/archdots/init.sh ~/.bashrc 
        echo -e "\e[1;32m --[init.sh has been overwirten in .bashrc] \e[0m"
    else
        echo -e "\e[1;33m --[init.sh is already loaded in .bashrc] \e[0m"
    fi 
else
    # if not found
    echo "# START INIT" >> ~/.bashrc
    cat ~/.local/archdots/init.sh >> ~/.bashrc 
    echo "# END INIT" >> ~/.bashrc
    echo -e "\e[1;32m --[init.sh is already loaded in .bashrc] \e[0m"
fi
. ~/.local/archdots/init.sh 
echo -e "\e[1;32m [init.sh activated successfully] \e[0m"
