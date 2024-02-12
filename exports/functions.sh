#!/bin/bash
# ==============================
# exports/functions
# ==============================
mkfile() 
{ 
    mkdir -p -- "$1" && touch -- "$1"/"$2" 
}

# 0. check installed
# hash records the location of the binary of these commands in a hash table
check_installed() 
{
    hash $1 > /dev/null 2>&1
    if [ "$?" != "0" ]; then
        echo -e "\e[1;31m [$1 not found] \e[0m"
        exit 1
    else
        echo -e "\e[1;32m [$1 is installed] \e[0m"
    fi
}

# 0. find executable
function findexe() {
  for ARG in $(pacman -Qql $1); do
    [ ! -d $ARG ] && [ -x $ARG ] && echo $ARG;
  done
}
