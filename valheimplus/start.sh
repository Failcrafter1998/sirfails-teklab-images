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

    executable_name="valheim_server.x86_64"
    export VALHEIM_PLUS_SCRIPT="$(readlink -f "$0")"
    export VALHEIM_PLUS_PATH="$(dirname "$VALHEIM_PLUS_SCRIPT")"
    export DOORSTOP_ENABLE=TRUE
    export DOORSTOP_INVOKE_DLL_PATH="${VALHEIM_PLUS_PATH}/BepInEx/core/BepInEx.Preloader.dll"
    export DOORSTOP_CORLIB_OVERRIDE_PATH="${VALHEIM_PLUS_PATH}/unstripped_corlib"
    doorstop_libs="${VALHEIM_PLUS_PATH}/doorstop_libs"
    executable_path="${VALHEIM_PLUS_PATH}/${executable_name}"
	lib_postfix="so"
    executable_type=$(LD_PRELOAD="" file -b "${executable_path}");
    arch="x64"

    doorstop_libname=libdoorstop_${arch}.${lib_postfix}
    export LD_LIBRARY_PATH="${doorstop_libs}":"${LD_LIBRARY_PATH}"
    export LD_PRELOAD="$doorstop_libname":"${LD_PRELOAD}"
    export DYLD_LIBRARY_PATH="${doorstop_libs}"
    export DYLD_INSERT_LIBRARIES="${doorstop_libs}/$doorstop_libname"

    export templdpath="$LD_LIBRARY_PATH"
    export LD_LIBRARY_PATH="${VALHEIM_PLUS_PATH}/linux64":"${LD_LIBRARY_PATH}"
    export SteamAppId=892970

    "${VALHEIM_PLUS_PATH}/${executable_name}" -name "$servername" -port "${VAR_B}" -savedir "./saves" -world "$weltname" -password "${VAR_C}" -public "1"

    export LD_LIBRARY_PATH=$templdpath
fi

exit 0