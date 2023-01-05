#!/bin/bash

# TekBase - server control panel
# Copyright since 2005 TekLab
# Christian Frankenstein
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

function gen_passwd { 
    PWCHARS=$1
    [ "$PWCHARS" = "" ] && PWCHARS=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${PWCHARS} | xargs
}

function sed_edit {
    SETFILE=$1
    SETVAR=$2
    SETVALUE=$3
    SETSEP=$4
    SETQUOTE=$5

    if ! grep "${SETVAR}${SETSEP}" "${SETFILE}" &>/dev/null; then
        sed -i "${SETFILE}" -e "s/^\(${SETVAR}${SETSEP}\).*$/\1${SETQUOTE}${SETVALUE}${SETQUOTE}/"
    else
        echo "${SETVAR}${SETSEP}${SETQUOTE}${SETVALUE}${SETQUOTE}" >> "${SETFILE}"
    fi
}

function workshopid_download {
    SETLOGIN=$1
    SETAPPID=$2
    if [ -d "game" ]; then
        SETPATH="game"
    else
        SETPATH=""
    fi
	
    if [ -f "workshopid.list" ]; then
        for LINE in $(cat workshopid.list)
        do
            if [ "$LINE" != "" ]; then
                ./steamcmd/steamcmd.sh +login ${SETLOGIN}  +force_install_dir ./${SETPATH} +workshop_download_item ${SETAPPID} ${LINE} +quit
            fi
        done
    fi
}

if [ "$VAR_A" = "vrising" ]; then
    # ./start.sh vrising gsport gsqueryport gsplayer

    sed -i "s/\"Port\": [0-9]*/\"Port\": ${VAR_B}/g" ./saves/Settings/ServerHostSettings.json
    sed -i "s/\"QueryPort\": [0-9]*/\"QueryPort\": ${VAR_C}/g" ./saves/Settings/ServerHostSettings.json
    sed -i "/MaxConnectedUsers/c\  \"MaxConnectedUsers\" : \"${VAR_D}\"," ./saves/Settings/ServerHostSettings.json

    xvfb-run --auto-servernum --server-args='-screen 0 1024x768x16 -terminate' bash -c "wine VRisingServer.exe -persistentDataPath ./saves"
fi               