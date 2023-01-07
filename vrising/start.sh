#!/bin/bash

# TekBase - server control panel
# Copyright since 2005 TekLab
# Christian Frankenstein
# Script edited by SirFail
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


if [ "$VAR_A" = "vrising" ]; then
    # ./start.sh vrising gsport gsqueryport gsplayer

    sed -i "s/\"Port\": [0-9]*/\"Port\": ${VAR_B}/g" ./saves/Settings/ServerHostSettings.json
    sed -i "s/\"QueryPort\": [0-9]*/\"QueryPort\": ${VAR_C}/g" ./saves/Settings/ServerHostSettings.json
    sed -i "/MaxConnectedUsers/c\  \"MaxConnectedUsers\" : \"${VAR_D}\"," ./saves/Settings/ServerHostSettings.json

    xvfb-run --auto-servernum --server-args='-screen 0 1024x768x16 -terminate' bash -c "wine VRisingServer.exe -persistentDataPath ./saves"
fi               