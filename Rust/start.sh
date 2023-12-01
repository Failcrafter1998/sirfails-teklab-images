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

function gen_settings {
cat <<EOF > ./settings.txt
Mapname=Procedural Map
Seed=
Weltgröße=6000
Servername=Rust Server
Beschreibung=Rust Server
ServerURL=https://rust.facepunch.com/
Imageurl=
Serveridentität=rustserver
RconPassword=
EOF
}

if [ "$VAR_A" = "rust" ]; then
    # ./start.sh rust gsport gsplayer gsqueryport

    if [ ! -f settings.txt ]; then
        gen_settings
    fi

    # Empty Checks

    if grep -q '^Mapname=' ./settings.txt; then
        echo ""
    else    
        echo "Mapname=Procedural Map" >> ./settings.txt
    fi

    if grep -q '^Seed=' ./settings.txt; then
        echo ""
    else
        echo "Seed=$(gen_passwd 8)" >> ./settings.txt
    fi

    if grep -q '^Weltgröße=' ./settings.txt; then
        echo ""
    else
        echo "Weltgröße=6000" >> ./settings.txt
    fi

    if grep -q '^Servername=' ./settings.txt; then
        echo ""
    else
        echo "Servername=Rust Server" >> ./settings.txt
    fi

    if grep -q '^Beschreibung=' ./settings.txt; then
        echo ""
    else
        echo "Beschreibung=Rust Server" >> ./settings.txt
    fi

    if grep -q '^Serveridentität=' ./settings.txt; then
        echo ""
    else
        echo "Serveridentität=rustserver" >> ./settings.txt
    fi

    if grep -q '^RconPassword=' ./settings.txt; then
        echo ""
    else
        echo "RconPassword=$(gen_passwd 8)" >> ./settings.txt
    fi

    # Values Auslesen

    mapname=$(grep "Mapname" ./settings.txt | cut -d "=" -f 2)
    seed=$(grep "Seed" ./settings.txt | cut -d "=" -f 2)
    size=$(grep "Weltgröße" ./settings.txt | cut -d "=" -f 2)
    hostname=$(grep "Servername" ./settings.txt | cut -d "=" -f 2)
    description=$(grep "Beschreibung" ./settings.txt | cut -d "=" -f 2)
    url=$(grep "ServerURL" ./settings.txt | cut -d "=" -f 2)
    imageurl=$(grep "Imageurl" ./settings.txt | cut -d "=" -f 2)
    identity=$(grep "Serveridentität" ./settings.txt | cut -d "=" -f 2)
    rconpw=$(grep "RconPassword" ./settings.txt | cut -d "=" -f 2)

    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:`dirname $0`/RustDedicated_Data/Plugins/x86_64
    ./RustDedicated -batchmode +server.port ${VAR_B} +server.level "$mapname" +server.seed $seed +server.worldsize $size +server.maxplayers ${VAR_C} +server.hostname "$hostname" +server.description "$description" +server.url "$url" +server.headerimage "$imageurl" +server.identity "$identity" +rcon.port ${VAR_D} +rcon.password $rconpw +rcon.web 1 -logfile 2>&1

fi

exit 0