#!/bin/bash

# TekBase - server control panel
# Copyright since 2005 TekLab
# Christian Frankenstein
# Edited by SirFail
# Website: teklab.de
#          teklab.net

VAR_A=$1
VAR_B=$2
VAR_C=$3
VAR_D=$4
VAR_E=$5
VAR_F=$6
VAR_G=$7

DATADIR=$(pwd)

function settings_txt {
cat <<EOF > ./settings.txt
Servername=Valheim Server
Weltname=defaultworld
EOF
}

if [ "$VAR_A" = "valheim" ]; then
    # ./start.sh valheim gsport gspasswd gsplayer

    if [ ! -f settings.txt ]; then
        settings_txt
    fi

    if [ ! -f ./BepInEx/config/valheim_plus.cfg ]; then
        wget https://raw.githubusercontent.com/valheimPlus/ValheimPlus/development/valheim_plus.cfg
        mv valheim_plus.cfg ./BepInEx/config
    fi

    if grep -q '^maxPlayers =' ./BepInEx/config/valheim_plus.cfg; then
        sed -i "s/^maxPlayers =.*$/maxPlayers = ${VAR_D}/" ./BepInEx/config/valheim_plus.cfg
    else
        echo "maxPlayers = ${VAR_D}" >> ./BepInEx/config/valheim_plus.cfg
    fi

    # read the value of "Servername"
    servername=$(grep "Servername" ./settings.txt | cut -d "=" -f 2)

    # read the value of "Weltname"
    weltname=$(grep "Weltname" ./settings.txt | cut -d "=" -f 2)

    # BepInEx-specific settings
    # NOTE: Do not edit unless you know what you are doing!
    ####
    export DOORSTOP_ENABLE=TRUE
    export DOORSTOP_INVOKE_DLL_PATH=./BepInEx/core/BepInEx.Preloader.dll
    export DOORSTOP_CORLIB_OVERRIDE_PATH=./unstripped_corlib

    export LD_LIBRARY_PATH="./doorstop_libs:$LD_LIBRARY_PATH"
    export LD_PRELOAD="libdoorstop_x64.so:$LD_PRELOAD"
    ####


    export LD_LIBRARY_PATH="./linux64:$LD_LIBRARY_PATH"
    export SteamAppId=892970

    ./valheim_server.x86_64 -name "$servername" -port "${VAR_B}" -savedir "./saves" -world "$weltname" -password "${VAR_C}" -public "1"

fi

exit 0