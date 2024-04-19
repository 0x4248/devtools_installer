# Devtools installer
# A simple program to select and install packages with a terminal menu interface.
# Github: https://www.github.com/0x4248/devtools_installer
# Licence: GNU General Public License v3.0
# By: 0x4248

use_sudo=1

sudo apt update

if [ $? -ne 0 ]; then
    echo "Failed to update apt. Do you want to try without sudo? (y/n)"
    read -r response
    if [ "$response" = "y" ]; then
        echo "Continuing without sudo"
        use_sudo=1
    else
        use_sudo=0
    fi
fi

if [ $use_sudo -eq 1 ]; then
    yes | apt update
    yes | apt install python3 python3-pip
else
    yes | sudo apt update
    yes | sudo apt install python3 python3-pip
fi



pip3 install bin/kconfiglib-14.1.0.tar.gz 
if [ $? -ne 0 ]; then
    echo "Failed to install kconfiglib. Do you want to try with --break-system-packages? (y/n)"
    read -r response
    if [ "$response" = "y" ]; then
        echo "Continuing with --break-system-packages"
        pip3 install bin/kconfiglib-14.1.0.tar.gz --break-system-packages
    else
        echo "Exiting"
        exit 1
    fi
fi

menuconfig config

python3 src/main.py
