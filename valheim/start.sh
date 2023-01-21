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
    # ./start.sh valheim gsport gspasswd

    if [ ! -f settings.txt ]; then
        settings_txt
    fi

    # read the value of "Servername"
    servername=$(grep "Servername" ./settings.txt | cut -d "=" -f 2)

    # read the value of "Weltname"
    weltname=$(grep "Weltname" ./settings.txt | cut -d "=" -f 2)

    export templdpath=$LD_LIBRARY_PATH
    export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
    export SteamAppId=892970

    ./valheim_server.x86_64 -name "$servername" -port ${VAR_B} -savedir ./saves -world "$weltname" -password "${VAR_C}" -public 1
fi

exit 0