#!/bin/bash

# TekBase - server control panel
# Image installer made by SirFail

USER=$(whoami)
DATADIR=$(pwd)

mkdir ets2dedi
mkdir ./ets2dedi/saves
mkdir ./ets2dedi/logs
chmod 770 start.sh; mv start.sh ./ets2dedi
chmod 770 installer.sh;./installer.sh steam 1948160 ets2dedi
cd ./ets2dedi/bin/linux_x64;./eurotrucks2_server
cp -R /home/$USER/.local/share/Euro\ Truck\ Simulator\ 2/* $DATADIR/ets2dedi/saves