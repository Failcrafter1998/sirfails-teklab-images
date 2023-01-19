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

function create_conf {
cat <<EOF > serverconfig.txt
world=./saves/world/world1.wld
autocreate=3
seed=
worldname=World
difficulty=0
maxplayers=10
port=7777
password=
motd=Please don't cut the purple trees!
worldpath=./saves/world
banlist=banlist.txt
secure=1
language=de-DE
upnp=1
npcstream=60
priority=3
journeypermission_time_setfrozen=1
journeypermission_time_setdawn=1
journeypermission_time_setnoon=1
journeypermission_time_setdusk=1
journeypermission_time_setmidnight=1
journeypermission_godmode=1
journeypermission_wind_setstrength=1
journeypermission_rain_setstrength=1
journeypermission_time_setspeed=1
journeypermission_rain_setfrozen=1
journeypermission_wind_setfrozen=1
journeypermission_increaseplacementrange=1
journeypermission_setdifficulty=1
journeypermission_biomespread_setfrozen=1
journeypermission_setspawnrate=1
EOF
}

if [ "$VAR_A" = "terraria" ]; then
    #./start.sh terraria gsip gsport gsplayer

    if [ ! -f serverconfig.txt ]; then
        create_conf
    fi

    if grep -q '^port=' serverconfig.txt; then
        sed -i "s/^port=.*$/port=${VAR_C}/" serverconfig.txt
    else
        echo "port=${VAR_C}" >> serverconfig.txt
    fi

    if grep -q '^maxplayers=' serverconfig.txt; then
        sed -i "s/^maxplayers=.*$/maxplayers=${VAR_D}/" serverconfig.txt
    else
        echo "maxplayers=${VAR_D}" >> serverconfig.txt
    fi

    ./TerrariaServer.bin.x86_64 -config serverconfig.txt -ip ${VAR_B}
fi

exit 0