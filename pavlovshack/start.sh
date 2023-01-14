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

function fill_game_ini {
cat <<EOF > ./Pavlov/Saved/Config/LinuxServer/Game.ini
[/Script/Pavlov.DedicatedServer]
bEnabled=true
ServerName="My_private_idaho"
MaxPlayers=10     #Set this to 10 for Shack. 24 is the max for PC, setting it higher will not allow players to join.
ApiKey="ABC123FALSEKEYDONTUSEME"
bSecured=true
bCustomServer=true
bVerboseLogging=false
bCompetitive=false #This only works for SND
bWhitelist=false
RefreshListTime=120
LimitedAmmoType=0
TickRate=90
TimeLimit=60
#Password=0000
#BalanceTableURL="vankruptgames/BalancingTable/main"
MapRotation=(MapId="UGC1758245796", GameMode="GUN")
MapRotation=(MapId="datacenter", GameMode="SND")
MapRotation=(MapId="sand", GameMode="DM")
EOF
}

if [ "$VAR_A" = "pavlovshack" ]; then
    # ./start.sh pavlovshack gsport gsqueryport gsplayer

    if [ ! -f ./Pavlov/Saved/Config/LinuxServer/Game.ini ]; then
        fill_game_ini
    fi

    if [ ! -f ./Pavlov/Saved/Config/mods.txt ]; then
        touch ./Pavlov/Saved/Config/mods.txt
    fi

    if [ ! -f ./Pavlov/Saved/Config/blacklist.txt ]; then
        touch ./Pavlov/Saved/Config/blacklist.txt
    fi

    if [ ! -f ./Pavlov/Saved/Config/whitelist.txt ]; then
        touch ./Pavlov/Saved/Config/whitelist.txt
    fi

    if [ ! -f ./Pavlov/Saved/Config/RconSettings.txt ]; then
        touch ./Pavlov/Saved/Config/RconSettings.txt 
    fi

    if grep -q '^Port=' ./Pavlov/Saved/Config/RconSettings.txt; then
        sed -i "s/^Port=.*$/Port=${VAR_C}/" ./Pavlov/Saved/Config/RconSettings.txt
    else
        echo "Port=${VAR_C}" >> ./Pavlov/Saved/Config/RconSettings.txt
    fi

    if grep -q '^MaxPlayers=' ./Pavlov/Saved/Config/LinuxServer/Game.ini; then
        sed -i "s/^MaxPlayers=.*$/MaxPlayers=${VAR_D}/" ./Pavlov/Saved/Config/LinuxServer/Game.ini
    else
        echo "MaxPlayers=${VAR_D}" >> ./Pavlov/Saved/Config/LinuxServer/Game.ini
    fi

    if grep -q '^Password=' ./Pavlov/Saved/Config/RconSettings.txt; then
        echo ""
    else
        echo "Password=$(gen_passwd 14)" >> ./Pavlov/Saved/Config/RconSettings.txt
    fi

    ./PavlovServer.sh -PORT=${VAR_B}
fi

exit 0