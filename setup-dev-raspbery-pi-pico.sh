#!/bin/bash
set -u -e

# https://www.raspberrypi.com/documentation/microcontrollers/raspberry-pi-pico.html

# Install
cd ~/
mkdir pico
cd pico
git clone -b master https://github.com/raspberrypi/pico-sdk.git
cd pico-sdk
git submodule update --init
cd ..
git clone -b master https://github.com/raspberrypi/pico-examples.git
sudo apt update
sudo apt -y install cmake gcc-arm-none-eabi build-essential 

# PATH
echo "export PICO_SDK_PATH=${HOME}/pico/pico-sdk" >> ~/.bashrc

# Setup vscode
sudo apt -y install code
code --install-extension marus25.cortex-debug
code --install-extension ms-vscode.cmake-tools
code --install-extension ms-vscode.cpptools
cd ~/pico/pico-examples
mkdir .vscode
cp ide/vscode/launch-raspberrypi-swd.json .vscode/launch.json
cp ide/vscode/settings.json .vscode/settings.json

# setup debbung
cd ~/pico/pico-examples
rm -rf build
mkdir build
cd build
export PICO_SDK_PATH=../../pico-sdk
cmake -DCMAKE_BUILD_TYPE=Debug ..
cd hello_world/serial
make -j4

sudo apt -y install gdb-multiarch

# Install https://github.com/dorssel/usbipd-win/releases/tag/v4.2.0 in Windows

sudo apt update
sudo apt install binutils-multiarch
cd /usr/bin
ln -s /usr/bin/objdump objdump-multiarch
ln -s /usr/bin/nm nm-multiarch 


