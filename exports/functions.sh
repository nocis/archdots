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

# 1. find executable
function findexe() {
  for ARG in $(pacman -Qql $1); do
    [ ! -d $ARG ] && [ -x $ARG ] && echo $ARG;
  done
}

# 2. cmake-init
function cmake-init {

if [ ! -d .git ]; then
  echo "Not a git folder!"
  exit
fi

cat <<'EOT' >> build.sh
#!/bin/bash
mkdir build
cd build
echo "Building in $(dirname $PWD)"
cmake_opts=(
        -B "$PWD/out/"
	# -DQt5_DIR="/path/to/Qt5.6/"
	-DCMAKE_EXPORT_COMPILE_COMMANDS=1
	-DCMAKE_C_COMPILER="/usr/bin/clang"
	-DCMAKE_CXX_COMPILER="/usr/bin/clang++"
	-DCMAKE_BUILD_TYPE=Debug
	-DCMAKE_INSTALL_PREFIX:PATH="$(dirname $PWD)/dist/"
	-DCMAKE_PREFIX_PATH="thirdparty" 
)

cmake "${cmake_opts[@]}" ..

cd ..
TMP_SRC_DIR="$PWD"
if [[ -f "${TMP_SRC_DIR}/compile_commands.json" || -L "${TMP_SRC_DIR}/compile_commands.json" ]]; then
	rm compile_commands.json
fi

if command -v fd >/dev/null
then
    FILES=$(fd -u -H -t f -F "compile_commands.json" $TMP_SRC_DIR/build/out/)
else
    FILES=$(find $TMP_SRC_DIR/build -name "compile_commands.json")
fi

TARGETS=($(echo $FILES))
LINK_NAMES=( $(echo $FILES | sed "s:$TMP_SRC_DIR/build/out/:$TMP_SRC_DIR/:g") )

for i in ${!TARGETS[*]}
do
    if [ "$1" == "-f" ]
    then
        ln -srfv ${TARGETS[i]} ${LINK_NAMES[i]}
    else
        ln -srv ${TARGETS[i]} ${LINK_NAMES[i]}
    fi
done

EOT

cat <<'EOT' >> CMakeLists.txt
cmake_minimum_required(VERSION 3.20)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../bin)
EOT
}
