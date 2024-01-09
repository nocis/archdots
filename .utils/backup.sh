# ------------------------------------------------------
# Backup 
# ------------------------------------------------------

datets=$(date '+%Y%m%d%H%M%S')
if [ -d ~/.local/archdots ] || [ -f ~/.bashrc ]; then
echo -e "${GREEN}"
figlet "Backup"
echo -e "${NONE}"
    if [ -d ~/.local/dots-backup ]; then
        echo "The script has detected an existing dotfiles folder and will try to create a backup into the folder:"
        echo "~/.local/dots-backup/$datets"
    fi
    if [ ! -L ~/.bashrc ] && [ -f ~/.bashrc ]; then
        echo "The script has detected an existing .bashrc file and will try to create a backup to:" 
        echo "~/.local/dots-backup/$datets/.bashrc-old"
    fi
    if gum confirm "Do you want to create a backup?" ;then
        if [ ! -d ~/.local/dots-backup ]; then
            mkdir ~/.local/dots-backup
            echo "~/.local/dots-backup created."
        fi
        if [ ! -d ~/.local/dots-backup/$datets ]; then
            mkdir ~/.local/dots-backup/$datets
            echo "~/.local/dots-backup/$datets created"
        fi
        # if [ -d ~/.local/archdots ]; then
            # cp -r ~/.local/archdots/  ~/.local/dots-backup/$datets
            # echo "Backup of your current dotfiles in ~/dotfiles-versions/backups/$datets created."
        # fi
        if [ -f ~/.bashrc ]; then
            cp ~/.bashrc ~/.local/dots-backup/$datets/.bashrc-old
            echo "Existing .bashrc file found in homefolder. .bashrc-old created"
        fi
    elif [ $? -eq 130 ]; then
        exit 130
    else
        echo "Backup skipped."
    fi
    echo ""
fi
