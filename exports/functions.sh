#!/bin/bash
# ==============================
# exports/functions
# ==============================
mkfile() 
{ 
    mkdir -p -- "$1" && touch -- "$1"/"$2" 
}

project() {
  pjlist=$(find ~ -name '.*' -prune -name '.git' -printf "%h\n" | fzf --height=10%)
  echo $pjlist
  nvim $pjlist
}


hibernate_deprecated()
{
    OFFSET=$(sudo filefrag -v /swap | awk '$1=="0:" {print substr($4, 1, length($4)-2)}')
    SWAPLOC=$(findmnt -no MAJ:MIN -T /swap)
    sudo bash -c "echo $SWAPLOC > /sys/power/resume"
    sudo bash -c "echo $OFFSET > /sys/power/resume_offset"
    systemctl hibernate
}


connectX11Bus() {
  echo "enter the sudo password, please"
  read -s PW
  echo $PW | sudo -kS service dbus start >/dev/null 2>&1
  export XDG_RUNTIME_DIR=/run/user/$(id -u)
  echo $PW | sudo -kS mkdir -p $XDG_RUNTIME_USER >/dev/null 2>&1
  echo $PW | sudo -kS chmod 700 $XDG_RUNTIME_DIR >/dev/null 2>&1
  echo $PW | sudo -kS chown $(id -un):$(id -gn) $XDG_RUNTIME_DIR >/dev/null 2>&1
  export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
  dbus-daemon --session --address=$DBUS_SESSION_BUS_ADDRESS --nofork --nopidfile --syslog-only &
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

# 2. clear nvim swap
function nvim-clear-swap() {
  rm ~/.local/state/nvim/swap/*
}

# 3. cmake-init
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


# cmake --build build/out --target all -- -j 8
EOT

cat <<'EOT' >> CMakeLists.txt
cmake_minimum_required(VERSION 3.20)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../bin)

project(HelloWorld)

include(FetchContent)
FetchContent_Declare(
  NCmake
  GIT_REPOSITORY git@github.com:nocis/NCmake.git
  GIT_TAG main)
FetchContent_MakeAvailable(NCmake)
nocis_init_git()
nocis_update_modules()
EOT
}
