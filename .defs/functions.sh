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
    echo $PW | sudo -kS  yay --noconfirm -S "${toInstall[@]}" 
    echo -e "\e[1;32m --[${toInstall[@]} installed successfully] \e[0m"
}

_installSymbolicLink(){
    name="$1"
    symbolicLink="$2"
    sourcePath="$3"
    targetPath="$4"

    # if [-L test for symbolic link
    if [ -L $symbolicLink ]; then
        rm ${symbolicLink}
        ln -s $sourcePath $targetPath
        echo -e "\e[1;32m [Symbolic link $sourcePath -> $targetPath created.] \e[0m"
 
        # -d test for director exist
    elif [ -d $symbolicLink ]; then
        echo $PW | sudo -kS rm -rf ${symbolicLink}/ > /dev/null 2>&1
        ln -s $sourcePath $targetPath
        echo -e "\e[1;32m [Symbolic link for directory ${sourcePath} -> ${targetPath} created.] \e[0m"

        # -d test for file
    elif [ -f $symbolicLink ]; then
        echo $PW | sudo -kS rm -f $symbolicLink > /dev/null 2>&1
        ln -s $sourcePath $targetPath 
        echo -e "\e[1;32m [Symbolic link to file ${sourcePath} -> ${targetPath} created.] \e[0m"
    else
        ln -s $sourcePath $targetPath
        echo -e "\e[1;32m [New symbolic link ${sourcePath} -> ${targetPath} created.] \e[0m"
    fi
}

# _replaceFileInFile $startMarket $endMarker $customFile $targetFile
_replaceFileInFile() {

    # Set function parameters
    start_string=$1
    end_string=$2
    customFile=$3
    file_path="$4"

    # Counters
    start_line_counter=0
    end_line_counter=0
    start_found=0
    end_found=0

    if [ -f $file_path ] ;then

        # Detect Start String
        while read -r line
        do
            ((start_line_counter++))
            if [[ $line = *$start_string* ]]; then
                # echo "Start found in $start_line_counter"
                start_found=$start_line_counter
                break
            fi 
        done < "$file_path"

        # Detect End String
        while read -r line
        do
            ((end_line_counter++))
            if [[ $line = *$end_string* ]]; then
                # echo "End found in $end_line_counter"
                end_found=$end_line_counter
                break
            fi 
        done < "$file_path"

        # Check that deliminters exists
        if [[ "$start_found" == "0" ]] ;then
            echo "ERROR: Start deliminter not found."
            sleep 2
        fi
        if [[ "$end_found" == "0" ]] ;then
            echo "ERROR: End deliminter not found."
            sleep 2
        fi

        # Replace text between delimiters
        if [[ ! "$start_found" == "0" ]] && [[ ! "$end_found" == "0" ]] && [ "$start_found" -le "$end_found" ] ;then
            # Remove the old line
            ((start_found++))

            if [ ! "$start_found" == "$end_found" ] ;then    
                ((end_found--))
                sed -i "$start_found,$end_found d" $file_path
            fi
            # Add the new line
            
            ((start_found--))
            # sed -i "$start_found i $new_string" $file_path
            sed -i "$start_found r $customFile" $file_path
        else
            echo "ERROR: Delimiters syntax."
            sleep 2
        fi
    else
        echo "ERROR: Target file not found."
        sleep 2
    fi
}
