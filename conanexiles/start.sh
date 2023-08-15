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

if [ "$VAR_A" = "conan" ]; then
    # ./start.sh conan gsport gsqueryport gsplayer gspasswd

    returndir=$(pwd)

    # Setzt Variablen (Funktioniert erst beim zweiten Server start, da die Datein erst vom Server generiert werden müssen(Kein Problem die wichtigen werte setzten wir über die Command Line beim starten))
    if grep -q '^ServerPasswort=' ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini; then
        sed -i "s/^ServerPasswort=.*$/ServerPasswort=${VAR_E}/" ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini
    else
        echo "ServerPasswort=${VAR_E}" >> ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini
    fi

    if ! grep -q '^ServerName=' ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini; then
        echo 'ServerName=' >> ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini
    fi

    if grep -q '^Port=' ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini; then
        sed -i "s/^Port=.*$/Port=${VAR_B}/" ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini
    else
        echo "Port=${VAR_B}" >> ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini
    fi

    if grep -q '^ServerQueryPort=' ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini; then
        sed -i "s/^ServerQueryPort=.*$/ServerQueryPort=${VAR_C}/" ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini
    else
        echo "ServerQueryPort=${VAR_C}" >> ./ConanSandbox/Saved/Config/WindowsServer/Engine.ini
    fi

    if grep -q '^MaxPlayers=' ./ConanSandbox/Saved/Config/WindowsServer/Game.ini; then
        sed -i "s/^MaxPlayers=.*$/MaxPlayers=${VAR_D}/" ./ConanSandbox/Saved/Config/WindowsServer/Game.ini
    else
        echo "MaxPlayers=${VAR_D}" >> ./ConanSandbox/Saved/Config/WindowsServer/Game.ini
    fi


    # Auto Mod Updater (Wenn diese Funktion nicht gewünscht ist einfach auskomentieren oder den Code löschen)

    if [ ! -f workshopids.txt ]; then
        touch workshopids.txt # In dieser Datei werden die Workshop ID's eingetragen
    fi

    # Conan Mod Setup

    if [ ! -d ./ConanSandbox/Mods ]; then
        mkdir ./ConanSandbox/Mods
    fi

    if [ ! -f ./ConanSandbox/Mods/modlist.txt ]; then
        touch ./ConanSandbox/Mods/modlist.txt
    fi

    if [ ! -d automods ]; then
        mkdir automods
    fi
    
    cd automods
    
    if [ ! -f steamcmd.sh ]; then
        curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxf -
    fi

    # Setzet appid und den Installationsordner
    APP_ID=440900
    INSTALL_DIR="./items"
    FILE=${returndir}/workshopids.txt

    # Ueberpruefe, ob mindestens eine Id in der Datei vorhanden ist
    if [ -s $FILE ]; then
    #  Wenn mehr als eine Id in der Datei vorhanden ist, starte eine Schleife
    if [ `wc -l < $FILE` -gt 1 ]; then
        while read line; do
        echo "workshop_download_item $APP_ID $line" >> script.txt
        done < $FILE
    # Wenn nur eine Id in der Datei vorhanden ist, starte keine Schleife
    else
        read line < $FILE
        echo "workshop_download_item $APP_ID $line" >> script.txt
    fi

    ./steamcmd.sh +login anonymous +force_install_dir "$INSTALL_DIR" +runscript script.txt +quit
    
    rm script.txt

    cd ${returndir}    

    find ${returndir}/automods/items/steamapps/workshop/content/440900 -name '*.pak' -exec cp {} ./ConanSandbox/Mods \;

    find ./ConanSandbox/Mods -name '*.pak' -exec bash -c 'echo "*$(basename {})"' \; >> ./ConanSandbox/Mods/modlist.txt
    else
    # Gebe eine Nachricht aus, wenn die Datei leer ist
    echo "Keine Workshop IDS in workshopids.txt gefunden. Mod Installer wird nicht ausgefuehrt"
    fi

    cd ${returndir}
    
    xvfb-run --auto-servernum --server-args='-screen 0 1024x768x16 -terminate' bash -c "wine ConanSandboxServer.exe -log -MaxPlayers=${VAR_D} -Port=${VAR_B} -QueryPort=${VAR_C}"
fi                            
