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
    check="$(echo $PW | sudo -kS  pacman -Qs --color always "${package}" | grep "local" | grep "${package} ")";
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
            echo "${pkg} is already installed.";
            continue;
        fi;
        toInstall+=("${pkg}");
    done;
    echo $toInstall

    if [[ "${toInstall[@]}" == "" ]] ; then
        # echo "All pacman packages are already installed.";
        return;
    fi;

    # printf "Package not installed:\n%s\n" "${toInstall[@]}";
    echo $PW | sudo -kS  pacman --noconfirm -S "${toInstall[@]}" > /dev/null 2>&1
}
