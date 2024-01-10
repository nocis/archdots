#!/bin/bash
# ======================
# .install/functions
# ======================

# -n : if not zero length
# $? only once/per command

_isExportedToBashrc(){
    filename="$1";
    grep -q "$filename" "$HOME/.bashrc";
    echo "$?";
    return;
}

_isInstalledPacman() {
    package="$1";
    check="$(sudo pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}

_isInstalledYay() {
    package="$1";
    check="$(sudo yay -Qs --color always "${package}" | grep "local" | grep "${package} ")";
    if [ -n "${check}" ] ; then
        echo 0; #'0' means 'true' in Bash
        return; #true
    fi;
    echo 1; #'1' means 'false' in Bash
    return; #false
}



_installPkgsPacman() {
    toInstall=();
    for pkg; do
        if [[ $(_isInstalledPacman "${pkg}") == 0 ]]; then
            echo -e "\e[1;33m --[${pkg} is already installed] \e[0m"
            continue;
        fi;
        toInstall+=("${pkg}");
    done;

    if [[ "${toInstall[@]}" == "" ]] ; then
        return;
    fi;

    # printf "Package not installed:\n%s\n" "${toInstall[@]}";
    echo $PW | sudo -kS  pacman --noconfirm -S "${toInstall[@]}" > /dev/null 2>&1
    echo -e "\e[1;32m --[${toInstall[@]} installed successfully] \e[0m"
}

_installPkgsYay() {
    toInstall=();
    for pkg; do
        if [[ $(_isInstalledYay "${pkg}") == 0 ]]; then
            echo -e "\e[1;33m --[${pkg} is already installed] \e[0m"
            continue;
        fi;
        toInstall+=("${pkg}");
    done;

    if [[ "${toInstall[@]}" == "" ]] ; then
        return;
    fi;

    # printf "Package not installed:\n%s\n" "${toInstall[@]}";
    echo $PW | sudo -kS  yay --noconfirm -S "${toInstall[@]}" > /dev/null 2>&1
    echo -e "\e[1;32m --[${toInstall[@]} installed successfully] \e[0m"
}
