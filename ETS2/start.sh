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
USER=$(whoami)

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

if [ "$VAR_A" = "ets2" ]; then
    # ./start.sh ets2 gsplayer gsport gsqueryport

    virtual=$( expr $VAR_D + 1)
    query=$( expr $VAR_D + 2)

    cp /home/$USER/.local/share/Euro\ Truck\ Simulator\ 2/server.log.txt $DATADIR/logs/server.log_$(date +%Y-%m-%d_%H:%M:%S).txt

    logprefix="server.log_"
    cleanup_logs() {
        ls -tp "$DATADIR/logs/$logprefix"*.txt | tail -n +11 | xargs -d '\n' rm --
    }

    cleanup_logs

    sed -i "s/max_players: .*/max_players: ${VAR_B}/" ./saves/server_config.sii

    sed -i "s/connection_dedicated_port: .*/connection_dedicated_port: ${VAR_C}/" ./saves/server_config.sii

    sed -i "s/query_dedicated_port: .*/query_dedicated_port: ${VAR_D}/" ./saves/server_config.sii
    
    sed -i "s/connection_virtual_port: .*/connection_virtual_port: ${virtual}/" ./saves/server_config.sii
    
    sed -i "s/query_virtual_port: .*/query_virtual_port: ${query}/" ./saves/server_config.sii

    cp -R ./saves/* /home/$USER/.local/share/Euro\ Truck\ Simulator\ 2/

    cd ./bin/linux_x64
    LD_LIBRARY_PATH="/home/$USER/.steam/sdk32" ./eurotrucks2_server
fi

exit 0