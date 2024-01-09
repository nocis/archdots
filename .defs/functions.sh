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
