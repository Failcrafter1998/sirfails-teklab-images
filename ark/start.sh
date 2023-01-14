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

if [ "$VAR_A" = "ark" ]; then
    # ./start.sh ark gsport gsqueryport gsplayer gsmap

    if [ -d game ]; then
        SETPATH="game/"
    else
    	SETPATH=""
    fi
    
    # Adminpanel -> game list -> ark -> start folder -> "game" or "" but not "ShooterGame/Binaries/Linux" 
    SESSION_NAME=$(grep -i "SessionName" ${SETPATH}/ShooterGame/Saved/Config/LinuxServer/GameUserSettings.ini | awk -F "=" '{print $2}')
    ADMIN_PASSWORD=$(grep -i "ServerAdminPassword" ${SETPATH}/ShooterGame/Saved/Config/LinuxServer/GameUserSettings.ini | awk -F "=" '{print $2}')
    if [ "${SESSION_NAME}" = "" ]; then
        SESSION_NAME="Ark Server"
    fi
    if [ "${ADMIN_PASSWORD}" = "" ]; then
        ADMIN_PASSWORD=$(gen_passwd 8)
    fi
    echo "Hinweis: Der ARK Server braucht je nach Hardware 10-30 Minuten zum starten." > screenlog.0
    echo "Es tauchen einige Fehlermeldungen auf. Diese koennen ignoriert werden." >> screenlog.0
    echo "" >> screenlog.0	
    echo "Attention: The ARK server needs 10-30 minutes to start depending on the hardware." >> screenlog.0
    echo "Some error messages appear. These can be ignored." >> screenlog.0

    #return point
    returndir=$(pwd)
    #Creating Linux steamcmd.sh, if it is missing
    cd ./Engine/Binaries/ThirdParty/SteamCMD
    if [ ! -d Linux ]; then
        mkdir Linux
    fi
    #installing Linux steamcmd
    cd Linux    
    if [ ! -f steamcmd.sh ]; then
        curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxf -
    fi
    #create symbolic link, so that steamcmd can process the mods further
    if [ ! -d steamapps ]; then 
        ln -s ~/Steam/steamapps/ steamapps       
    fi
    #returning
    cd ${returndir}

    if [ -d game ]; then
        cd game
    fi

    RCON_PORT=$( expr $VAR_B + 3)
    
    cd ./ShooterGame/Binaries/Linux/
    ./ShooterGameServer "${VAR_E}"?listen?SessionName="${SESSION_NAME}"?ServerAdminPassword="${ADMIN_PASSWORD}"?Port="${VAR_B}"?QueryPort="${VAR_C}"?RCONPort="${RCON_PORT}"?MaxPlayers="${VAR_D}" -server -log ${VAR_F} ${VAR_G}
fi

exit 0